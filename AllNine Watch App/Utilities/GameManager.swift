//
//  GameManager.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import Foundation

class GameManager: ObservableObject {
    @Published private(set) var rolledValue: Int
    @Published private(set) var availableNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    private(set) var numberOfDice: Int
    private var submittedAmount: Int
    init() {
        self.numberOfDice = 2
        self.submittedAmount = 0
        self.rolledValue = Int.random(in: 1...12)
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
        if (numberOfDice == 2) {
            rolledValue = Int.random(in: 1...6) + Int.random(in: 1...6)
        } else {
            rolledValue = Int.random(in: 1...6)
        }
    }
    
    func mustRollBothDice() -> Bool {
        // this is ugly, but .contains([]) not supported prior to WatchOS 9.0 and my watch can only have 8.7
        if (availableNumbers.contains(7) || availableNumbers.contains(8) || availableNumbers.contains(9)) {
            return true
        } else {
            return false
        }
    }
    
    func isGameWinnable(rolledAmount: Int, currentIndex: Int = 0, currentSum: Int = 0) -> Bool {
        if currentSum == rolledAmount {
            // Combination found that adds up to the target
            return true
        } else if currentSum > rolledAmount || currentIndex >= availableNumbers.count {
            // Target exceeded or reached the end of the list, no combination found
            return false
        }
        
        // Recursive call without including the current number
        let excludeCurrent = isGameWinnable(rolledAmount: rolledAmount, currentIndex: currentIndex + 1, currentSum: currentSum)
        
        // Recursive call including the current number
        let includeCurrent = isGameWinnable(rolledAmount: rolledAmount, currentIndex: currentIndex + 1, currentSum: currentSum + availableNumbers[currentIndex])
        
        // Return true if either combination (with or without the current number) is found
        return excludeCurrent || includeCurrent
    }
    
    func setNumberOfDice(dice: Int) {
        if 1...2 ~= dice {
            if (mustRollBothDice()) {
                numberOfDice = 2
            } else {
                numberOfDice = dice
            }
        } else {
            print("Error - number of dice set to invalid number. Should be 1 or 2. How did you get here?")
        }
    }
    
    func resetGameState() {
        availableNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        rollDice()
    }

}
