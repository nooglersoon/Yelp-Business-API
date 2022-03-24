//
//  ViewController.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 23/03/22.
//

import UIKit

class BusinessViewController: UIViewController {
    
    @IBOutlet weak var selectLocationButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortByButton: UIBarButtonItem!
    
    var businessViewModel = BusinessViewModel()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .systemBlue
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.style = .large
        indicatorView.isHidden = true
        
        return indicatorView
        
    }()
    
    lazy var filterPickerView: UIPickerView = {
       
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        layout()
        businessViewModel.fetchAPI(activityIndicatorView: activityIndicatorView, tableView: tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork() {
            selectLocationButton.isEnabled = true
            tableView.allowsSelection = true
            sortByButton.isEnabled = true
        } else {
            showAlert(with: .errorConnection, completion: nil)
            selectLocationButton.isEnabled = false
            tableView.allowsSelection = false
            sortByButton.isEnabled = false
        }
    }
    
    func setupUI(){
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseID)
        tableView.separatorStyle = .none
        tableView.rowHeight = 200
        
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        searchBar.enablesReturnKeyAutomatically = false
        
    }
    
    // MARK: - Setup the layout of ViewController
    func layout(){
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        
    }
    
    
    
    @IBAction func inputLocationTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Input Location", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Location"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [weak self ] alert -> Void in
            if let textField = alertController.textFields?[0]{
                if textField.text!.count > 0 {
                    guard let text = textField.text else { return }
                    self?.businessViewModel.location = text
                    self?.businessViewModel.fetchAPI(activityIndicatorView: self!.activityIndicatorView, tableView: self!.tableView)
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.preferredAction = saveAction
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func sortByTapped(_ sender: UIBarButtonItem) {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: view.frame.width, height: 200)
        vc.view.addSubview(filterPickerView)
        
        NSLayoutConstraint.activate([
        
            filterPickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            filterPickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
            
        ])
        
        let alert = UIAlertController(title: "Select Business List By Category", message: "", preferredStyle: .alert)
        alert.popoverPresentationController?.sourceView = filterPickerView
        alert.popoverPresentationController?.sourceRect = filterPickerView.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] _ in
            let selectedRow = self?.filterPickerView.selectedRow(inComponent: 0)
            
            guard let selectedRow = selectedRow else { return }
            
            if let selectedCategory = self?.businessViewModel.filterByCategories[selectedRow] {
                self?.businessViewModel.filterBySelectedCategory = selectedCategory
                self?.businessViewModel.fetchAPI(activityIndicatorView: self!.activityIndicatorView, tableView: self!.tableView)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
}


extension BusinessViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessViewModel.businessResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseID) as! CustomTableViewCell
        cell.configureCell(businessResult: businessViewModel.businessResult[indexPath.row])
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let businessDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BusinessDetailVC") as! BusinessDetailViewController
        let businessDetailViewModel = BusinessDetailViewModel()
        businessDetailViewModel.businessDetail = businessViewModel.businessResult[indexPath.row]
        businessDetailVC.businessDetailViewModel = businessDetailViewModel
        navigationController?.pushViewController(businessDetailVC, animated: true)
        
    }
    
}

extension BusinessViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return businessViewModel.filterByCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let category = businessViewModel.filterByCategories[row].rawValue
        return category.capitalized
    }
}

extension BusinessViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        businessViewModel.term = searchText
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        if searchBar.text != "" {
            businessViewModel.fetchAPI(activityIndicatorView: self.activityIndicatorView, tableView: self.tableView)
            tableView.reloadData()
        }
        
    }
    
}
