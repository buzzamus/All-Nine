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
    
    
    func testRemovePickedNumbers_handlesPreviouslyPicked() {
        let choices = [1, 2, 3, 4, 5]
        gameManager.removePickedNumbers(choices: choices)
        
        let moreChoices = [1, 2, 3, 4, 5, 6, 7]
        gameManager.removePickedNumbers(choices: moreChoices)
        
        let expectedValues = [8, 9]
        XCTAssertEqual(gameManager.availableNumbers, expectedValues)
    }
    
    func testCanRollOneDice() {
        XCTAssertTrue(gameManager.mustRollBothDice())
        
        gameManager.removePickedNumbers(choices: [7, 9])
        XCTAssertTrue(gameManager.mustRollBothDice())
    }
    
    func testCanRollOneDice_returnsFalse() {
        XCTAssertTrue(gameManager.mustRollBothDice())
        
        gameManager.removePickedNumbers(choices: [3, 7, 8, 9])
        XCTAssertFalse(gameManager.mustRollBothDice())
    }
    
    func testIsGameWinnable() {
        gameManager.removePickedNumbers(choices: [5, 6, 7, 8, 9])
        // availableNumbers left are [1, 2, 3, 4]
        XCTAssertTrue(gameManager.isGameWinnable(rolledAmount: 6))
        
        gameManager.removePickedNumbers(choices: [2, 4])
        XCTAssertFalse(gameManager.isGameWinnable(rolledAmount: 5))
    }
    
    func testIsGameWinnable_multipleCombinationTesting() {
        gameManager.removePickedNumbers(choices: [2])
        XCTAssertFalse(gameManager.isGameWinnable(rolledAmount: 2))
        
        gameManager = GameManager()
        
        XCTAssertTrue(gameManager.isGameWinnable(rolledAmount: 3))
        gameManager.removePickedNumbers(choices: [1, 2])
        XCTAssertTrue(gameManager.isGameWinnable(rolledAmount: 3))
        gameManager.removePickedNumbers(choices: [3])
        XCTAssertTrue(gameManager.isGameWinnable(rolledAmount: 9))
        gameManager.removePickedNumbers(choices: [4, 5])
        XCTAssertTrue(gameManager.isGameWinnable(rolledAmount: 9))
        gameManager.removePickedNumbers(choices: [9])
        
        XCTAssertFalse(gameManager.isGameWinnable(rolledAmount: 12))
        
    }
    
    func testSetNumberOfDice_whenOnlyTwoAllowed() {
        XCTAssertTrue(gameManager.mustRollBothDice())
        
        gameManager.removePickedNumbers(choices: [7, 9])
        gameManager.setNumberOfDice(dice: 1)
        XCTAssertEqual(gameManager.numberOfDice, 2)
    }
    
    func testSetNumberOfDice_whenOneIsAllowed() {
        gameManager.removePickedNumbers(choices: [7, 8, 9])
        gameManager.setNumberOfDice(dice: 1)
        XCTAssertEqual(gameManager.numberOfDice, 1)
        
        gameManager.setNumberOfDice(dice: 2)
        XCTAssertEqual(gameManager.numberOfDice, 2)
    }
    
    func testSetNumberOfDice_handlesInvalidNumber() {
        gameManager.removePickedNumbers(choices: [7, 8, 9])
        gameManager.setNumberOfDice(dice: 4)
        XCTAssertEqual(gameManager.numberOfDice, 2)
    }
}
