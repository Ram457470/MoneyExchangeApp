//
//  CountryTableViewCell.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import UIKit

protocol selectPapularCountries: AnyObject {
    func updatePapularCountries(model: CountryListModel?)
}

class CountryTableViewCell: UITableViewCell {
    
    static var identifier = "CountryTableViewCell"
    private var viewModel = CountryListViewModel()
    private var dataModel: CountryListModel?
    
    weak var delegate: selectPapularCountries?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(CountryListCollectionViewCell.nib(), forCellWithReuseIdentifier: CountryListCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = flowLayout
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        setupViewModel()
    }
    
    func configure(name: String) {
        collectionView.reloadData()
    }
    
    func updatePapularCountryData(model: CountryListModel?) {
        collectionView.delegate = self
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CountryTableViewCell", bundle: nil)
    }
}

extension CountryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCountries
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryListCollectionViewCell.identifier, for: indexPath) as? CountryListCollectionViewCell else { return UICollectionViewCell()
        }
        if let model = viewModel.getCountries(at: indexPath.row) {
            cell.countryLabel.text = model.name?.common
            cell.countryImage.imageFromServerURL(model.flags?.png ?? "")
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.modelResponse[indexPath.row]
        self.delegate?.updatePapularCountries(model: model)
    }
}

// MARK: - ViewModel Setup
extension CountryTableViewCell {
    
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
                    self?.collectionView.reloadData()
                }
            case .error(let error):
                debugPrint(String(describing: error?.localizedDescription))
            }
        }
    }
}

extension CountryTableViewCell: selectPapularCountries {
    func updatePapularCountries(model: CountryListModel?) {
        updatePapularCountryData(model: model)
    }
}
