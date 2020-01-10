//
//  GetPosition.swift
//  BaluchonOCTests
//
//  Created by Bouziane Bey on 10/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

@testable import BaluchonOC
import XCTest

class GetPosition: XCTestCase {
    
    var weatherDataModel : CoordinateUser?
    
    func testGetPositionShouldShowFailedCallbackIfError(){
        //Given
        let weatherAPI = WeatherAPI(session: URLSessionMock(data: nil, response: nil, error: MockResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherAPI.getCoordinateTest() { (success, cityCoordinate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(cityCoordinate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetPositionShouldShowFailedCallbackIfNoData(){
        //Given
        let weatherAPI = WeatherAPI(session: URLSessionMock(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherAPI.getCoordinateTest() { (success, cityCoordinate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(cityCoordinate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetPositionShouldShowFailedCallbackIfIncorrectResponse(){
        //Given
        let weatherAPI = WeatherAPI(session: URLSessionMock(data: MockResponseData.getPositionCorrectData, response: MockResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherAPI.getCoordinateTest() { (success, cityCoordinate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(cityCoordinate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetPostionShouldShowFailedCallbackIfIncorrectData(){
        //Given
        let weatherAPI = WeatherAPI(session: URLSessionMock(data: MockResponseData.APIIncorrectData, response: MockResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherAPI.getCoordinateTest() { (success, cityCoordinate) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(cityCoordinate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetPositionShouldShowSuccessCallbackAndCorrectData(){
        //Given
        let weatherAPI = WeatherAPI(session: URLSessionMock(data: MockResponseData.getPositionCorrectData, response: MockResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        func fetchMockData(fileName : String, completion : @escaping (WeatherData?) -> Void){
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json"){
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(WeatherData.self, from: data)
                    completion(jsonData)
                } catch {
                    print("Error \(error)")
                }
            }
        }
        weatherAPI.getCoordinateTest() { (success, cityCoordinate) in
            //Then
            fetchMockData(fileName: "Weather") { (response) in
                if response != nil {
                    if response!.coord != nil {
                        self.weatherDataModel = response!.coord
                    } else {
                        print("Error")
                    }
                }
            }
            
            let positionCity = "London"
            let positionUser = "\(self.weatherDataModel!.lat), \(self.weatherDataModel!.lon)"
            XCTAssertTrue(success)
            XCTAssertNotNil(cityCoordinate)
            XCTAssertEqual(positionCity, positionUser)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
