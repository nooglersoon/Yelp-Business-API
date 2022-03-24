//
//  BusinessViewModel.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 24/03/22.
//

import Foundation
import UIKit

class BusinessViewModel {
    
    var businessResult: [Business] = []
    let filterByCategories: [FilterCategories] = [.distance,.rating]
    var term: String = ""
    var location: String = "Singapore"
    var filterBySelectedCategory: FilterCategories = .distance
    
    func fetchAPI(activityIndicatorView: UIActivityIndicatorView, tableView: UITableView){
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        APIService.shared.getAttractions(location: location, term: term, sortBy: filterBySelectedCategory.rawValue) { [weak self] result, error in
            
            guard let result = result else {
                print(error!.localizedDescription)
                return
            }
            
            self?.businessResult = result.businesses
            tableView.reloadData()
            activityIndicatorView.stopAnimating()
        }
    }
    
}
