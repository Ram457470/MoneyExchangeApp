//
//  CountryListViewModel.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import Foundation

class CountryListViewModel {
    
    private let service: APIManagerProtocol
    var eventHandler: ((_ event: Event) -> Void)?
    var modelResponse: [CountryListModel] = []

    var numberOfCountries: Int {
        return modelResponse.count
    }

    func getCountries(at index: Int) -> CountryListModel? {
        guard index < modelResponse.count else { return nil }
        return modelResponse[index]
    }
        
    init(service: APIManagerProtocol = APIManager()) {
        self.service = service
    }
        
    func getCountryList() {
        self.eventHandler?(.loading)
        service.getDecodaleData(from: APIEndpoint.getAllCountryList, with: [CountryListModel].self) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let response):
                self.modelResponse = response
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}
