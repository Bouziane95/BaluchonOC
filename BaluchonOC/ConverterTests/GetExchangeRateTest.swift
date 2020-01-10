//
//  GetExchangeRateTest.swift
//  BaluchonOCTests
//
//  Created by Bouziane Bey on 10/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

@testable import BaluchonOC
import XCTest

class GetExchangeRateTest: XCTestCase {
    
    var converterRates : Rates?
    
    func testGetConvertShouldShowFailedCallbackIfError(){
        //Given
        let converterApi = Conversion(session: URLSessionMock(data: nil, response: nil, error: MockResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        converterApi.getExchangeTest() { (success, rates) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rates)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetConvertShouldShowFailedCallbackIfNoData(){
        //Given
        let converterApi = Conversion(session: URLSessionMock(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        converterApi.getExchangeTest() { (success, rates) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rates)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetConvertShouldShowFailedCallbackIfIncorrectResponse(){
        //Given
        let converterApi = Conversion(session: URLSessionMock(data: MockResponseData.currencyCorrectData, response: MockResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        converterApi.getExchangeTest() { (success, rates) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rates)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetConvertShouldShowFailedCallbackIfIncorrectData(){
        //Given
        let converterApi = Conversion(session: URLSessionMock(data: MockResponseData.APIIncorrectData, response: MockResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        converterApi.getExchangeTest() { (success, rates) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(rates)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetConvertShouldShowSuccessCallbackAndCorrectData(){
        //Given
        let converterApi = Conversion(session: URLSessionMock(data: MockResponseData.currencyCorrectData, response: MockResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        func fetchMockData(fileName: String, completion : @escaping (Converter?) -> Void){
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json"){
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Converter.self, from: data)
                    completion(jsonData)
                } catch {
                    print("Error \(error)")
                }
            }
        }
        converterApi.getExchangeTest() { (success, rates) in
            //Then
            fetchMockData(fileName: "Converter") { (response) in
                if response != nil {
                    if response!.rates != nil {
                        self.converterRates = response!.rates
                    } else {
                        print("Error")
                    }
                }
            }
            let convertedInput = 0.9025270758
            let resultConverted = self.converterRates!.EUR
            XCTAssertTrue(success)
            XCTAssertNotNil(rates)
            XCTAssertEqual(convertedInput, resultConverted)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
