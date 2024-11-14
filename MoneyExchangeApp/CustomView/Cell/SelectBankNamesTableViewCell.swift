//
//  SelectBankNamesTableViewCell.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import UIKit

class SelectBankNamesTableViewCell: UITableViewCell {
    
    static let identifier = "SelectBankNamesTableViewCell"
    
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var selectBankName: UILabel!
    @IBOutlet weak var selectBankBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateUI()
    }
    
    func configure(with item: CountryItem) {
           selectBankName.text = item.name
           selectImage.image = UIImage(named: item.imageName)
           selectBankBtn.setImage(UIImage(named: item.buttonImageName), for: .normal)
       }

    func setBorderColor(_ color: UIColor) {
            selectView.layer.borderColor = color.cgColor
        }
    
    func updateUI() {
        selectImage.translatesAutoresizingMaskIntoConstraints = false
        selectImage.layer.cornerRadius = selectImage.frame.height / 2
        selectBankBtn.tintColor = .lightGray
        selectImage.clipsToBounds = true
        selectView.layer.borderWidth = 0.8
        selectView.layer.cornerRadius = 12
    }
    
    func didSelectConfig() {
        selectBankBtn.backgroundColor = .clear
        selectBankBtn.tintColor = .systemGreen
        setBorderColor(.systemGreen)
    }
    
    func didDeselectonfig() {
        selectBankBtn.tintColor = .lightGray
        setBorderColor(.lightGray)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SelectBankNamesTableViewCell", bundle: nil)
    }
    
    @IBAction func selectBankTapped(_ sender: UIButton) {
        
    }
}
