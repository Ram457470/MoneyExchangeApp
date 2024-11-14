//
//  ViewController.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import UIKit

protocol SelectDepositData: AnyObject {
    func updateDepositData(model: CountryListModel?)
}

class MoneyTransferViewController: UIViewController {
    // MARK: - UI Elements Navigation
    @IBOutlet weak var moneyTransferLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var questionmarkSymbal: UIImageView!
    // MARK: - UI Elements Country
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryStackView: UIStackView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var dropDownBtn: UIButton!
    // MARK: - UI Elements Delivery Method
    @IBOutlet weak var deliveryMethedView: UIView!
    @IBOutlet weak var deliveryMethodLabel: UILabel!
    @IBOutlet weak var methodStackView: UIStackView!
    @IBOutlet weak var selectMethodLabel: UILabel!
    @IBOutlet weak var deliveryDropDownBtn: UIButton!
    // MARK: - UI Elements you deposit
    @IBOutlet weak var depositView: UIView!
    @IBOutlet weak var depositName: UILabel!
    @IBOutlet weak var countryDeclareView: UIView!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryImageName: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var amountCountLabel: UILabel!
    
    @IBOutlet weak var depositDropDownBtn: UIButton!
    // Calculate Value
    @IBOutlet weak var synImage: UIImageView!
    @IBOutlet weak var calculateLabel: UILabel!
    // Recipect Gest
    @IBOutlet weak var recipectName: UILabel!
    @IBOutlet weak var recipectView: UIView!
    @IBOutlet weak var recipectImage: UIImageView!
    @IBOutlet weak var recipectImageName: UILabel!
    @IBOutlet weak var recipectDropDownBtn: UIButton!
    @IBOutlet weak var countryRate: UILabel!
    
    // MARK: - UI Elements payment method
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var paymentStackView: UIStackView!
    @IBOutlet weak var paymentName: UILabel!
    @IBOutlet weak var dropDownPaymentBtn: UIButton!
    
    private var viewModel = CountryListViewModel()
    private var dataModel: CountryListModel?
    
    weak var delegate: SelectDepositData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func backToTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func updateUI() {
        // UI Elements Money Transfer
        moneyTransferLabel.text = "Money Transfer"
        backBtn.tintColor = .white
        questionmarkSymbal.tintColor = .white
        // UI Elements Country
        countryNameLabel.text = "Country"
        dropDownBtn.imageView?.image = UIImage(named: "chevron.down")
        dropDownBtn.tintColor = .systemGreen
        countryView.layer.cornerRadius = 12
        countryView.layer.masksToBounds = true
        countryStackView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        countryStackView.layer.cornerRadius = 12
        countryStackView.layer.masksToBounds = true
        countryName.text = "Select Country"
        countryName.textColor = .systemGreen
        countryName.font = .systemFont(ofSize: 18, weight: .medium)
        
        // UI Elements Delivery Method
        deliveryMethodLabel.text = "Delivery Medthod"
        deliveryDropDownBtn.imageView?.image = UIImage(named: "chevron.down")
        deliveryDropDownBtn.tintColor = .systemGreen
        deliveryMethedView.layer.cornerRadius = 12
        deliveryMethedView.layer.masksToBounds = true
        methodStackView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        methodStackView.layer.cornerRadius = 12
        methodStackView.layer.masksToBounds = true
        selectMethodLabel.text = "Select Delivery Method"
        selectMethodLabel.textColor = .systemGreen
        selectMethodLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        // UI Elements You deposit
        depositView.layer.cornerRadius = 12
        depositName.text = "You Deposite"
        depositDropDownBtn.isHidden = true
        countryDeclareView.layer.borderWidth = 1.0
        countryDeclareView.layer.borderColor = UIColor.lightGray.cgColor
        countryDeclareView.layer.cornerRadius = 12
        countryImageName.text = "AED"
        //   calculateLabel.text = "1 AED = 13.42 PHP"
        synImage.image = UIImage(named: "syncImg")
        synImage.tintColor = .systemGreen
        
        dropDownButton.imageView?.image = UIImage(named: "chevron.down")
        dropDownButton.tintColor = .lightGray
        recipectView.layer.borderWidth = 1.0
        recipectView.layer.borderColor = UIColor.lightGray.cgColor
        recipectView.layer.cornerRadius = 12
        // recipectImageName.text = "INR"
        recipectName.text = "Recipent Guest"
        //  countryRate.text = "1750.0"
        
        // UI Elements payment method
        paymentLabel.text = "Expected Payment Method"
        dropDownPaymentBtn.imageView?.image = UIImage(named: "chevron.down")
        dropDownPaymentBtn.tintColor = .systemGreen
        paymentView.layer.cornerRadius = 12
        paymentView.layer.masksToBounds = true
        paymentStackView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        paymentStackView.layer.cornerRadius = 12
        paymentStackView.layer.masksToBounds = true
        paymentName.text = "Select Payment Method"
        paymentName.textColor = .systemGreen
        paymentName.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    @IBAction func countryButton(_ sender: UIButton) {
        let viewControllerToPresent = storyboard?.instantiateViewController(withIdentifier: "CountryListBottomVC") as! CountryListBottomVC
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        viewControllerToPresent.delegate = self
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    @IBAction func selectMethodTapped(_ sender: UIButton) {
        let viewControllerToPresent = storyboard?.instantiateViewController(withIdentifier: "SelectDeliveryMethodVC") as! SelectDeliveryMethodVC
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        viewControllerToPresent.delegate = self
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    @IBAction func selectDepositMethodTapped(_ sender: UIButton) {
        let viewControllerToPresent = storyboard?.instantiateViewController(withIdentifier: "CountryListBottomVC") as! CountryListBottomVC
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        viewControllerToPresent.delegate = self
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    @IBAction func selectPaymentMethodTapped(_ sender: UIButton) {
        let viewControllerToPresent = storyboard?.instantiateViewController(withIdentifier: "CountryListBottomVC") as! CountryListBottomVC
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        viewControllerToPresent.delegate = self
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func updateCountryLabel(model: CountryListModel?) {
        if let currencies = model?.currencies, let firstCurrency = currencies.values.first {
            let currencyName = firstCurrency.name
            amountCountLabel.text = currencyName?.description
            print(currencyName ?? "No Currency Name")
        }
        countryName.text = model?.name?.common
        recipectImageName.text = model?.cioc
        recipectImage.imageFromServerURL(model?.flags?.png ?? "")
        if let currencies = model?.currencies, let firstCurrency = currencies.values.first {
            let currencyName = firstCurrency.name
            countryRate.text = currencyName?.description
            print(currencyName ?? "No Currency Name")
        }
        calculateLabel.text = model?.name?.common
        if let currencies = model?.currencies, let firstCurrency = currencies.values.first {
            let currencyName = firstCurrency.name
            calculateLabel.text = currencyName?.description
            print(currencyName ?? "No Currency Name")
        }
        countryImage.imageFromServerURL(model?.flags?.png ?? "")
        paymentName.text = model?.name?.common
    }
    
    func updateDeliveryMethod(model: CountryItem?) {
        selectMethodLabel.text = model?.name
    }
}

extension MoneyTransferViewController: SelectedCountry, SelectedDeliverMethod {
    func selectDeliveryMethodData(model: CountryItem) {
        updateDeliveryMethod(model: model)
    }
    
    func selectCountryData(model: CountryListModel?) {
        updateCountryLabel(model: model)
    }
}
