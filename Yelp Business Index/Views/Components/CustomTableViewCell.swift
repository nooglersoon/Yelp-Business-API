//
//  CustomTableViewCell.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 23/03/22.
//

import Foundation

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let reuseID = "MovieTableViewCell"
    
    let containerView = UIView()
    let movieImageView = UIImageView()
    let movieTitleLabel = UILabel()
    let movieReleaseDateLabel = UILabel()
    let movieOverview = UILabel()
    let movieVoteAverage = UILabel()
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
        
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.font = .boldSystemFont(ofSize: 24)
        movieReleaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        movieReleaseDateLabel.font = .preferredFont(forTextStyle: .caption1)
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        movieOverview.font = .preferredFont(forTextStyle: .body)
        movieOverview.numberOfLines = 2
        movieVoteAverage.translatesAutoresizingMaskIntoConstraints = false
        movieVoteAverage.font = .preferredFont(forTextStyle: .caption1)
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.image = UIImage(systemName: "film.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.clipsToBounds = true
        
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
        ratingStackView.addArrangedSubview(movieVoteAverage)
        stackView.addArrangedSubview(movieTitleLabel)
        stackView.addArrangedSubview(movieReleaseDateLabel)
        stackView.addArrangedSubview(movieOverview)
        stackView.addArrangedSubview(ratingStackView)
        containerView.addSubview(movieImageView)
        containerView.addSubview(stackView)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            containerView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: containerView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: containerView.bottomAnchor, multiplier: 2)
            
        ])
        
        NSLayoutConstraint.activate([
        
            movieOverview.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
        
            movieImageView.topAnchor.constraint(equalToSystemSpacingBelow: containerView.topAnchor, multiplier: 2),
            movieImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 1),
            containerView.bottomAnchor.constraint(equalToSystemSpacingBelow: movieImageView.bottomAnchor, multiplier: 2),
            movieImageView.widthAnchor.constraint(equalToConstant: 110)
            
        ])
        
        NSLayoutConstraint.activate([
        
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: movieImageView.trailingAnchor, multiplier: 1),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: containerView.topAnchor, multiplier: 2),
            containerView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
            
        ])
        
        movieImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
    }
    
//    func configureCell(movieResult: Result){
//        movieTitleLabel.text = movieResult.originalTitle
//        movieReleaseDateLabel.text = movieResult.releaseDate
//        movieOverview.text = movieResult.overview
//        movieVoteAverage.text = String(movieResult.voteAverage)
//        
//        guard let urlString = movieResult.posterPath else { return }
//        
//        movieImageView.load(url: URL(string: "https://image.tmdb.org/t/p/w500/\(urlString)")!)
//        
//    }
//    
//    func configureCell(favoriteMovie: FavoriteMovie){
//        movieTitleLabel.text = favoriteMovie.title
//        movieReleaseDateLabel.text = favoriteMovie.releaseDate
//        movieOverview.text = favoriteMovie.overview
//        movieVoteAverage.text = String(favoriteMovie.rating)
//        
//        guard let urlString = favoriteMovie.posterPath else { return }
//        
//        movieImageView.load(url: URL(string: "https://image.tmdb.org/t/p/w500/\(urlString)")!)
//    }
    
}
