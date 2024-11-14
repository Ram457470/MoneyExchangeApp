//
//  AllCountryTableViewCell.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import UIKit

class AllCountryTableViewCell: UITableViewCell {
    
    static let identifier = "AllCountryTableViewCell"
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        countryImage.layer.cornerRadius = countryImage.frame.size.width / 2
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "AllCountryTableViewCell", bundle: nil)
    }
}
