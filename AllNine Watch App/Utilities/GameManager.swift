//
//  GameManager.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import Foundation

class GameManager {
    private(set) var rolledValue: Int
    private(set) var numberOfDice: Int
    private var submittedAmount: Int
    private(set) var availableNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    init() {
        self.rolledValue = 0
        self.numberOfDice = 2
        self.submittedAmount = 0
    }
    
    func checkSubmittedAmount(submit amount: Int) {
        if (amount != rolledValue) {
            // return error to have view give response to player to submit correct numbers
            
        }
    }
    
    func removePickedNumbers(choices: [Int]) {
        for choice in choices {
            if let index = availableNumbers.firstIndex(of: choice) {
                availableNumbers.remove(at: index)
            }
        }
    }
    
    func rollDice() {
        // if 2 dice roll, return 2 numbers combined, else just do one dice roll
    }
    
    func canRollSingleDice() -> Bool {
        // this is ugly, but .contains([]) not supported prior to WatchOS 9.0 and my watch can only have 8.7
        if (availableNumbers.contains(7) || availableNumbers.contains(8) || availableNumbers.contains(9)) {
            return false
        } else {
            return true
        }
    }
}