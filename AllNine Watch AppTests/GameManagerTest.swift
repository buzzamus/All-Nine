//
//  GameManagerTest.swift
//  AllNine Watch AppTests
//
//  Created by Brent Busby on 5/31/23.
//

import XCTest
@testable import AllNine_Watch_App

final class GameManagerTest: XCTestCase {
    var gameManager: GameManager!

    override func setUpWithError() throws {
        gameManager = GameManager()
    }

    override func tearDownWithError() throws {
        gameManager = nil
    }
    
    func testRemovePickedNumbers() {
        let choices = [1, 3, 6]
        gameManager.removePickedNumbers(choices: choices)
        
        let expectedValue = [2, 4, 5, 7, 8, 9]
        XCTAssertEqual(gameManager.availableNumbers, expectedValue)
    }
    
    
    func testRemovePickedNumbersHandlesPreviouslyPicked() {
        let choices = [1, 2, 3, 4, 5]
        gameManager.removePickedNumbers(choices: choices)
        
        let moreChoices = [1, 2, 3, 4, 5, 6, 7]
        gameManager.removePickedNumbers(choices: moreChoices)
        
        let expectedValues = [8, 9]
        XCTAssertEqual(gameManager.availableNumbers, expectedValues)
    }
    
    func testCanRollOneDice() {
        XCTAssertFalse(gameManager.canRollSingleDice())
        
        gameManager.removePickedNumbers(choices: [7, 9])
        XCTAssertFalse(gameManager.canRollSingleDice())
    }
    
    func testCanRollOneDiceReturnsTrue() {
        XCTAssertFalse(gameManager.canRollSingleDice())
        
        gameManager.removePickedNumbers(choices: [3, 7, 8, 9])
        XCTAssertTrue(gameManager.canRollSingleDice())
    }
}
