//
//  ButtonsView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import SwiftUI

struct ButtonsView: View {
    @EnvironmentObject var gameManager: GameManager
    @State var submittedAmount = 0
    @State var isInvalidSubmittedValue = false
    @State var isRollingDice = false
    @State var pickedNumbers: [Int] = []
    @State var currentChoices = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let buttonRows = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"]
        ]
    var body: some View {
        VStack {
            ForEach(buttonRows, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { number in
                        Button {
                            submittedAmount += Int(number)!
                            let index = currentChoices.firstIndex(of: Int(number)!)
                            currentChoices.remove(at: index!)
                            pickedNumbers.append(Int(number)!)
                        } label: {
                            Text(number)
                        }
                        .disabled(!currentChoices.contains(Int(number)!))
                    }
                }
            }
            HStack {
                Button {
                    validateAndSubmitAmount()
                } label: {
                    Text("Submit")
                }
                .alert(isPresented: $isInvalidSubmittedValue) {
                    Alert(
                        title: Text("Invalid Amount Submitted"),
                        message: Text("Your submission must match the amount you rolled.")
                    )
                }
                Button("Clear") {
                    submittedAmount = 0
                    currentChoices = gameManager.availableNumbers
                }
                Text(String(submittedAmount))
            }
        }.sheet(isPresented: $isRollingDice) {
            DiceRollView()
        }
        .onChange(of: gameManager.availableNumbers) { _ in
            currentChoices = gameManager.availableNumbers
        }
    }
    
    func validateAndSubmitAmount() {
        if (submittedAmount != gameManager.rolledValue) {
            isInvalidSubmittedValue = true
            submittedAmount = 0
            currentChoices = gameManager.availableNumbers
        } else {
            gameManager.removePickedNumbers(choices: pickedNumbers)
            isRollingDice = true
            submittedAmount = 0
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
            .environmentObject(GameManager())
    }
}
