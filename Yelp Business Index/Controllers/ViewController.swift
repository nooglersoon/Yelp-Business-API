//
//  ViewController.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 23/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectLocationButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
       
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .systemBlue
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.style = .large
        indicatorView.isHidden = true
        
        return indicatorView
        
    }()
    
    var businessResult: [Business] = []
    var term: String = ""
    var location: String = "Singapore"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        layout()
        fetchAPI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork() {
            tableView.allowsSelection = true
        } else {
            showAlert(with: .errorConnection, completion: nil)
            tableView.allowsSelection = false
        }
    }
    
    func setupUI(){
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseID)
        tableView.separatorStyle = .none
        
        tableView.rowHeight = 200
    }
    
    // MARK: - Setup the layout of ViewController
    func layout(){
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
        
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        
    }

    func fetchAPI(){
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        APIService.shared.getAttractions(location: location, term: term, sortBy: "distance") { [weak self] result, error in
            
            guard let result = result else {
                print(error!.localizedDescription)
                return
            }

            self?.businessResult = result.businesses
            self?.tableView.reloadData()
            self?.activityIndicatorView.stopAnimating()
        }
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseID) as! CustomTableViewCell
        cell.configureCell(businessResult: businessResult[indexPath.row])
        cell.selectionStyle = .none
        return cell
        
    }
    
}
