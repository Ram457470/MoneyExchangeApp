//
//  HomeViewController.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import UIKit

class HomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func moneyTransferTapped(_ sender: UIButton) {
        let viewControllerToPresent = storyboard?.instantiateViewController(withIdentifier: "MoneyTransferViewController") as! MoneyTransferViewController
        present(viewControllerToPresent, animated: true)
    }
}
