//
//  getTranslation.swift
//  BaluchonOCTests
//
//  Created by Bouziane Bey on 10/01/2020.
//  Copyright © 2020 Bouziane Bey. All rights reserved.
//

@testable import BaluchonOC
import XCTest

class GetTranslation: XCTestCase {
    func testGetTranslationShouldShowFailedCallbackIfError(){
        //Given
        let translatorApi = TranslatorAPI(session: URLSessionMock(data: nil, response: nil, error: MockResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translatorApi.getTranslation(q: "Salut", source: "fr", target: "en") { (success, translationResult) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translationResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslationShouldShowFailedCallbackIfNoData(){
        //Given
        let translatorApi = TranslatorAPI(session: URLSessionMock(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translatorApi.getTranslation(q: "Salut", source: "fr", target: "en") { (success, translationResult) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translationResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslationShouldShowFailedCallbackIfIncorrectResponse(){
        //Given
        let translatorApi = TranslatorAPI(session: URLSessionMock(data: MockResponseData.translatorCorrectData, response: MockResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translatorApi.getTranslation(q: "Salut", source: "fr", target: "en") { (success, translationResult) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translationResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslationShouldShowFailedCallbackIfIncorrectData(){
        //Given
        let translatorApi = TranslatorAPI(session: URLSessionMock(data: MockResponseData.APIIncorrectData, response: MockResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translatorApi.getTranslation(q: "Salut", source: "fr", target: "en") { (success, translationResult) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translationResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslationShouldShowSuccessCallbackAndCorrectData(){
        //Given
        let translatorApi = TranslatorAPI(session: URLSessionMock(data: MockResponseData.translatorCorrectData, response: MockResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translatorApi.getTranslation(q: "Salut", source: "fr", target: "en") { (success, translationResult) in
            //Then
            let translatedText = "Hi"
            
            XCTAssertTrue(success)
            XCTAssertNotNil(translationResult)
            XCTAssertEqual(translatedText, translationResult!)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
