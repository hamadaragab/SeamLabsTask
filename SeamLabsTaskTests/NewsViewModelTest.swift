//
//  NewsViewModelTest.swift
//  SeamLabsTaskTests
//
//  Created by Hamada Ragab on 05/09/2023.
//

import XCTest
@testable import SeamLabsTask
final class NewsViewModelTest: XCTestCase {
    var sut: NewsViewModel!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NewsViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    func testGetArticleSuccessully() throws {
        // call getArticles With Date "2023-08-24"
        let exp = expectation(description: "Loading Articles")
        var arictles: [Articles] = []
        sut.newsServices?.getArticles(fromDate: "2023-08-24", completion: { Articles, error in
            arictles = Articles ?? []
            exp.fulfill()
        })
        waitForExpectations(timeout: 30)
        XCTAssertGreaterThan(arictles.count,0 , "articles count must be grater than 0")
        
    }
    func testFaildToGetArticleAtDate() throws {
        // call getArticles With Date "2023-09-24"
        // date dose not conatains any Articles
        // arictles count Zero and there is an error from Api
        let exp = expectation(description: "Loading Articles")
        var errorr: ErrorStatus?
        var arictles: [Articles] = []
        sut.newsServices?.getArticles(fromDate: "2023-09-24", completion: { Articles, error in
            arictles = Articles ?? []
            errorr = error
            exp.fulfill()
        })
        waitForExpectations(timeout: 20)
        XCTAssertEqual(arictles.count,0 , "should return no Articles becuase there is no articles at that day")
        XCTAssertNotNil(errorr, "should return error there is no netwrok")
        
    }
    func testArticlesSavedSuccessfullyToCoreData() throws {
        // test Saved Articles when app Is offline and there is no internet
        let savedArticles = sut.dataBaseManager.fetchSavedArticles()
        XCTAssertGreaterThan(savedArticles.count, 0,"saved Article must be found")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
