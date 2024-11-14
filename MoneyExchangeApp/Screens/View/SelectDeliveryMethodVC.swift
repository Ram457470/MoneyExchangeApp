//
//  SelectDeliveryMethodVC.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 10/11/24.
//

import UIKit

protocol SelectedDeliverMethod: AnyObject {
    func selectDeliveryMethodData(model: CountryItem)
}

class SelectDeliveryMethodVC: UIViewController {
    
    static let identifier = "SelectDeliveryMethodVC"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectDeliverymethodName: UILabel!
    
    weak var delegate: SelectedDeliverMethod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SelectBankNamesTableViewCell.nib(), forCellReuseIdentifier: SelectBankNamesTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        updateUI()
        tableView.reloadData()
    }
    
    let countryItems: [CountryItem] = [
        CountryItem(name: "Bank Account", imageName: "bankImg", buttonImageName: "record.circle"),
        CountryItem(name: "Cash Pickup", imageName: "cashPickup", buttonImageName: "record.circle"),
        CountryItem(name: "Mobile Wallet", imageName: "mobileWallet", buttonImageName: "record.circle"),
    ]
    
    func updateUI() {
        selectDeliverymethodName.text = "Select delivery Method"
    }
}

extension SelectDeliveryMethodVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectBankNamesTableViewCell.identifier, for: indexPath) as? SelectBankNamesTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let item = countryItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = countryItems[indexPath.row]
        self.delegate?.selectDeliveryMethodData(model: model)
        self.dismiss(animated: true)
    }
}

