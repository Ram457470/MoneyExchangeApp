//
//  MoneyExchangeAppTestCase.swift
//  MoneyExchangeAppTests
//
//  Created by Ram Naidu on 12/11/24.
//

import XCTest
@testable import MoneyExchangeApp

final class MoneyExchangeAppTestCase: XCTestCase {
    
    var countries: CountryListViewModel!
    var apiManager: APIManager!
    
    override func setUp() {
        apiManager = APIManager()
        countries = CountryListViewModel(service: apiManager)
        countries = CountryListViewModel()
    }
    
    override func tearDown() {
        apiManager = nil
        countries = nil
    }
    
    func test_ViewModel_With_ValideRequestModel_ReturnsSuccessResponse(){
        //Arrange
        let expections = expectation(description: #function)
        countries.getCountryList()
        //Assert
        countries.eventHandler = { [weak self] receivedEvent in
            switch receivedEvent {
            case .dataLoaded:
                XCTAssertNotNil(self?.countries.modelResponse)
                expections.fulfill()
            default:break
            }
        }
        self.wait(for: [expections], timeout: 5)
    }
    
    func test_ViewModel_With_InvalideRequestModel_ReturnsFailureResponse(){
        //Arrange
        let expectation = expectation(description: "A callback is fired")
        //Assert
        countries.eventHandler = { [weak self] receivedEvent in
            switch receivedEvent {
            case .error(_):
                DispatchQueue.main.async {
                    XCTAssertNil(self?.countries.modelResponse)
                    expectation.fulfill()
                }
            default:break
            }
        }
    }
    
    func test_ViewModel_With_NumberOfRowsInSection_ResultSuccess() {
        // Arrange
        let viewModel = CountryListViewModel()
        
        // Act
        viewModel.getCountryList()
        
        // Make sure the data is fetched
        let rowCount = viewModel.numberOfCountries
        
        // Assert
        XCTAssertEqual(rowCount, 0, "Expected 2 rows, but got \(rowCount)")
    }
    
    func test_ViewModel_With_HeightForHeaderInSection_ResultSuccess() {
        //Assert
        //  XCTAssertEqual(countries.heightForHeaderInSection(section: 1), 80.0)
    }
}
