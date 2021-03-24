//
//  XCTestCase.swift
//  RaintaculousTests
//
//  Created by Smithers on 24/03/2021.
//

import XCTest

extension XCTestCase {
    
    func loadStub(name: String, extenson: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: extenson)
        return try! Data(contentsOf: url!)
    }
    
}
