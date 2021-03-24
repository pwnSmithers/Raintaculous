//
//  DayViewModelTests.swift
//  RaintaculousTests
//
//  Created by Smithers on 24/03/2021.
//

import XCTest
import UIKit
@testable import Raintaculous

class DayViewModelTests: XCTestCase {
    
    var viewModel: DayViewModel!

    override func setUpWithError() throws {
        let data = loadStub(name: "CurrentWeather", extenson: "json")
        
        let decoder = JSONDecoder()
        let currentWeatherResponse = try! decoder.decode(CurrentWeather.self, from: data)
        
        viewModel = DayViewModel(currentWeatherData: currentWeatherResponse.current, currentWind: currentWeatherResponse.wind, todaysWeather: currentWeatherResponse.weather)
    }

    func testDescription() {
        XCTAssertEqual(viewModel.description, "overcast clouds")
    }
    
    func testTempreture() {
        XCTAssertEqual(viewModel.temp, "283.1 °F")
    }
    
    func testWindSpeed() {
        XCTAssertEqual(viewModel.wind, "0 MPH")
    }
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = UIImage(named: "04d")!.pngData()!
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 100.0)
        XCTAssertEqual(viewModelImage!.size.height, 100.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }

}
