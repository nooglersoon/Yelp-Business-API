//
//  BusinessDetailViewController.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 24/03/22.
//

import Foundation
import UIKit

class BusinessDetailViewController: UIViewController {
    
//    var businessID: Int?
    var businessDetail: Business?
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        return tableView
        
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .systemBlue
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.style = .large
        indicatorView.isHidden = true
        
        return indicatorView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layout()
    }
    
}

extension BusinessDetailViewController {
    
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    func layout(){
        
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
        
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        
    }
    
}

extension BusinessDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as! DetailTableViewCell
        guard let businessDetail = businessDetail else { return UITableViewCell()}
        cell.titleLabel.text = businessDetail.name
        cell.ratingLabel.text = "\(String(businessDetail.rating ?? 0 ))"
        
        cell.priceLabel.text = "\(String(businessDetail.price ?? "" ))"
        cell.priceLabel.textColor = .systemOrange
        
        cell.categoryLabel.text = businessDetail.categories.map { category in
            guard let category = category else { return "" }
            return category.title ?? ""
        }.joined(separator: ", ")
        
        cell.addressLabel.text = businessDetail.location?.displayAddress.map({ address in
            guard let address = address else { return "" }
            return address
        }).joined(separator: ", ")
        
        cell.telpLabel.text = businessDetail.phone ?? ""
        
        if let urlString = businessDetail.imageURL, let url = URL(string: urlString) {
            cell.imageVIew.load(url: url)
        }
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
}
