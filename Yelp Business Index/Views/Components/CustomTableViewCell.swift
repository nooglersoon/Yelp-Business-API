//
//  CustomTableViewCell.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 23/03/22.
//

import Foundation

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let reuseID = "CustomTableViewCell"
    
    let containerView = UIView()
    let businessImageView = UIImageView()
    let businessNameLabel = UILabel()
    let categoriesLabel = UILabel()
    let distanceLabel = UILabel()
    let priceLabel = UILabel()
    let ratingLabel = UILabel()
    let stackView = UIStackView()
    let starImageView = UIImageView()
    let ratingStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomTableViewCell {
    
    func setupUI(){
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemGray5
        containerView.layer.cornerRadius = 20
        
        businessNameLabel.translatesAutoresizingMaskIntoConstraints = false
        businessNameLabel.font = .boldSystemFont(ofSize: 24)
        categoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriesLabel.font = .preferredFont(forTextStyle: .caption1)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .preferredFont(forTextStyle: .caption1)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = .preferredFont(forTextStyle: .caption1)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = .preferredFont(forTextStyle: .caption1)
        
        businessImageView.translatesAutoresizingMaskIntoConstraints = false
        businessImageView.image = UIImage(systemName: "film.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        businessImageView.contentMode = .scaleAspectFit
        businessImageView.clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing  = 10
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.axis = .horizontal
        ratingStackView.distribution = .equalCentering
        ratingStackView.spacing = 5
        
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        starImageView.image = UIImage(systemName: "star.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        
    }
    
    func layout(){
        
        ratingStackView.addArrangedSubview(starImageView)
        ratingStackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(businessNameLabel)
        stackView.addArrangedSubview(categoriesLabel)
        stackView.addArrangedSubview(distanceLabel)
        stackView.addArrangedSubview(ratingStackView)
        containerView.addSubview(businessImageView)
        containerView.addSubview(stackView)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            containerView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: containerView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: containerView.bottomAnchor, multiplier: 2)
            
        ])
        
        
        NSLayoutConstraint.activate([
        
            businessImageView.topAnchor.constraint(equalToSystemSpacingBelow: containerView.topAnchor, multiplier: 2),
            businessImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 1),
            containerView.bottomAnchor.constraint(equalToSystemSpacingBelow: businessImageView.bottomAnchor, multiplier: 2),
            businessImageView.widthAnchor.constraint(equalToConstant: 110)
            
        ])
        
        NSLayoutConstraint.activate([
        
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: businessImageView.trailingAnchor, multiplier: 1),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: containerView.topAnchor, multiplier: 2),
            containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
            
        ])
        
        businessImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
    }
    
    func configureCell(businessResult: Business){
        businessNameLabel.text = businessResult.name
        categoriesLabel.text = businessResult.categories.first??.title
        priceLabel.text = businessResult.price ?? ""
        distanceLabel.text = String("\(businessResult.distance?.rounded() ?? 0 ) m")
        ratingLabel.text = String(businessResult.rating ?? 0)

        guard let urlString = businessResult.imageURL else { return }

        guard let url = URL(string: urlString) else { return }
        
        businessImageView.load(url: url)

    }
    
}
