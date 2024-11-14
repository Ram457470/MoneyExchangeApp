//
//  CountryListBottomVC.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import UIKit

enum Section: Int, CaseIterable {
    case papularCountries
    case allCountries
}

protocol SelectedCountry: AnyObject {
    func selectCountryData(model: CountryListModel?)
}

class CountryListBottomVC: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectCountryName: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    static let identifier = "CountryListBottomVC"
    var isSearching: Bool = false
    var searchedCountry = [String]()
    
    var viewModel = CountryListViewModel()
    var dataModel: [CountryListModel] = []
    
    weak var delegate: SelectedCountry?
    var filterDataModel: [CountryListModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CountryTableViewCell.nib(), forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.register(AllCountryTableViewCell.nib(), forCellReuseIdentifier: AllCountryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        updateUI()
        setupViewModel()
        tableView.reloadData()
    }
    
    func updateUI() {
        selectCountryName.text = "Select the recive Country"
        searchBar.contentMode = .right
    }
    
    func updatePapularData(model: CountryListModel?) {
        selectCountryName.text = model?.name?.common
    }
}

extension CountryListBottomVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.numberOfCountries
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .papularCountries:
            let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell
            cell?.collectionView.delegate = self
            cell?.selectionStyle = .none
        case .allCountries:
            let cell = tableView.dequeueReusableCell(withIdentifier: AllCountryTableViewCell.identifier, for: indexPath) as?
            AllCountryTableViewCell
            cell?.selectionStyle = .none
            if let model = viewModel.getCountries(at: indexPath.row) {
                cell?.countryName.text = model.name?.common
                cell?.countryImage.imageFromServerURL(model.flags?.png ?? "")
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return 40
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Papular Countries"
        case 1:
            return "All Countries"
        default:
            break
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.modelResponse[indexPath.row]
        self.delegate?.selectCountryData(model: model)
        _ = isSearching ? filterDataModel : dataModel
        self.dismiss(animated: true)
    }
}

extension CountryListBottomVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filterDataModel.removeAll()
        } else {
            isSearching = true
            filterDataModel = dataModel.filter { $0.name?.common?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        filterDataModel.removeAll()
        tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - ViewModel Setup
extension CountryListBottomVC {
    
    private func setupViewModel() {
        
        viewModel.getCountryList()
        callBackEvents()
    }
    
    private func callBackEvents(){
        
        viewModel.eventHandler = { [weak self] receivedEvent in
            
            switch receivedEvent{
            case .loading:
                debugPrint("Start loading....")
            case .stopLoading:
                debugPrint("Stop loading...")
            case .dataLoaded:
                debugPrint("Data loaded...")
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .error(let error):
                debugPrint(String(describing: error?.localizedDescription))
            }
        }
    }
}

extension CountryListBottomVC: selectPapularCountries {
    func updatePapularCountries(model: CountryListModel?) {
        self.updatePapularData(model: model)
    }
}
