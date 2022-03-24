//
//  DetailTableViewCell.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 24/03/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    var business: Business!

    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telpLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
