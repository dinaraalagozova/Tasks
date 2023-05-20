//
//  TaskTwoUITests.swift
//  TaskTwoUITests
//
//  Created by Dinara Alagozova on 19.05.2023.
//

import XCTest

class HomeViewControllerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testFavoriteButtonTapped() throws {
        // Given
        let query = "Test Query"
        let nonEmptyQuery = "Non-empty Query"

        // When
        let queryTextField = app.textFields["queryTextField"]
        queryTextField.tap()
        queryTextField.typeText(query)

        let favoriteButton = app.buttons["favoriteButton"]
        favoriteButton.tap()

        // Then
        let errorMessageLabel = app.staticTexts["errorMessageLabel"]
        XCTAssertTrue(errorMessageLabel.exists)
        XCTAssertEqual(errorMessageLabel.label, "Невозможно добавить пустой запрос в избранное")

        // When
        queryTextField.tap()
        queryTextField.typeText(nonEmptyQuery)
        favoriteButton.tap()

        // Then
        let successMessageLabel = app.staticTexts["successMessageLabel"]
        XCTAssertTrue(successMessageLabel.exists)
        XCTAssertEqual(successMessageLabel.label, "Картинка добавлена в избранное")
    }
}
