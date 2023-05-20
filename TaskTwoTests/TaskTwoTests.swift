//
//  TaskTwoTests.swift
//  TaskTwoTests
//
//  Created by Dinara Alagozova on 19.05.2023.
//

//import XCTest
//@testable import TaskTwo
//
//class TaskTwoTests: XCTestCase {
//
//    var sut: FavoritesViewController!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        sut = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController
//    }
//
//    override func tearDownWithError() throws {
//        sut = nil
//
//        try super.tearDownWithError()
//    }
//
//    // MARK: - Test Cases
//
//    func testTableViewDataSource() {
//        sut.loadViewIfNeeded()
//
//        XCTAssert(sut.tableView.dataSource === sut)
//    }
//
//    func testTableViewDelegate() {
//        sut.loadViewIfNeeded()
//
//        XCTAssert(sut.tableView.delegate === sut)
//    }
//
//    func testTableViewNumberOfRows() {
//        sut.loadViewIfNeeded()
//
//        sut.favorites = [
//            Favorite(id: 1, query: "Query 1", imageURL: "URL 1", date: Date()),
//            Favorite(id: 2, query: "Query 2", imageURL: "URL 2", date: Date()),
//            Favorite(id: 3, query: "Query 3", imageURL: "URL 3", date: Date())
//        ]
//
//        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
//    }

//
//    // MARK: - Performance Test
//
//    func testPerformanceExample() throws {
//        self.measure {
//            // to measure the time ----
//        }
//    }
//}

import XCTest
@testable import TaskTwo

class TaskTwoTests: XCTestCase {
    var sut: HomeViewController!
    
    override func setUpWithError() throws {
        sut = HomeViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testFavoriteButtonTapped() throws {
        // Given
        let sut = HomeViewController()
        sut.loadViewIfNeeded()
        
        // Set up the initial state
        sut.queryTextField.text = "Test Query"
        
        // When
        sut.favoriteButtonTapped()
        
        // Then
        // Verify that the appropriate error message is displayed
        XCTAssertTrue(sut.errorMessageLabel.text == "Невозможно добавить пустой запрос в избранное")
        
        // Simulate entering a non-empty query
        sut.queryTextField.text = "Non-empty Query"
        
        // When
        sut.favoriteButtonTapped()
        
        // Then
        // Verify that the appropriate success message is displayed
        XCTAssertTrue(sut.successMessageLabel.text == "Картинка добавлена в избранное")
    }
}
