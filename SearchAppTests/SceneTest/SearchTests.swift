//
//  SearchTests.swift
//  SearchAppTests
//
//  Created by Cem Kazım on 6.05.2021.
//

@testable import SearchApp
import XCTest

class SearchTests: XCTestCase {
    
    var searchViewController = SearchViewController()
    var searchViewModel = SearchViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFormatDate() throws {
        let date = searchViewModel.formatDate(with: "2019-01-01T08:00:00Z")
        XCTAssertEqual(date, "Jan 01,2019")
    }
    
    func testSearchResultData() {
        let expect = expectation(description: "Get Search Result Data")
        SearchServiceLayer.shared.getSearchResult(term: "abc", media: "movie", offset: 1, completionHandler: { (data: SearchResults) in
            XCTAssertNotNil(data)
            expect.fulfill()
        })
        waitForExpectations(timeout: 3, handler: nil)
    }
}
