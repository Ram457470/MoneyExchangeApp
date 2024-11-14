//
//  CountryListCollectionViewCell.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import UIKit

class CountryListCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "CountryListCollectionViewCell"
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryImage.layer.cornerRadius = countryImage.frame.size.width / 2
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CountryListCollectionViewCell", bundle: nil)
    }
}
