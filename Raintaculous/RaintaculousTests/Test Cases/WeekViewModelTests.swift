//
//  WeekViewModelTests.swift
//  RaintaculousTests
//
//  Created by Smithers on 24/03/2021.
//

import XCTest
@testable import Raintaculous

class WeekViewModelTests: XCTestCase {

    var viewModel: WeekViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let data = loadStub(name: "ForecastWeather", extenson: "json")
        let decoder = JSONDecoder()
        
        let forecastResponse = try! decoder.decode(ForecastWeather.self, from: data)
        viewModel = WeekViewModel(weatherData: forecastResponse.list)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 40)
    }


}
