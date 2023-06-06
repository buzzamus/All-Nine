//
//  ButtonsView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import SwiftUI

struct ButtonsView: View {
    @StateObject var gameManager = GameManager()
    @StateObject var buttonViewModel = ButtonViewModel()
    @State var submittedAmount = 0
    @State var isInvalidSubmittedValue = false
    @State var isRollingDice = false
    @State var gameWon = false
    let buttonRows = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"]
        ]
    var body: some View {
        VStack {
            HStack {
                Text("Roll: \(gameManager.rolledValue)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.leading)
            }
            ForEach(buttonRows, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { number in
                        Button {
                            submittedAmount += Int(number)!
                            let index = buttonViewModel.currentChoices.firstIndex(of: Int(number)!)
                            buttonViewModel.currentChoices.remove(at: index!)
                            buttonViewModel.pickedNumbers.append(Int(number)!)
                        } label: {
                            Text(number)
                        }
                        .disabled(!buttonViewModel.currentChoices.contains(Int(number)!))
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
                .alert(isPresented: $gameWon) {
                    Alert(
                        title: Text("You Win!!!"),
                        message: Text("Great Job!")
                    )
                }
                Button("Clear") {
                    submittedAmount = 0
                    buttonViewModel.currentChoices = gameManager.availableNumbers
                }
                Text(String(submittedAmount))
            }
        }.sheet(isPresented: $isRollingDice) {
            DiceRollView(gameManager: gameManager, buttonViewModel: buttonViewModel)
        }
        .onChange(of: gameManager.gameWon) { _ in
            buttonViewModel.currentChoices = gameManager.availableNumbers
            buttonViewModel.pickedNumbers = []
        }
    }
    
    func validateAndSubmitAmount() {
        if (submittedAmount != gameManager.rolledValue) {
            submittedAmount = 0
            buttonViewModel.pickedNumbers = []
            buttonViewModel.currentChoices = gameManager.availableNumbers
            isInvalidSubmittedValue = true
        } else {
            gameManager.removePickedNumbers(choices: buttonViewModel.pickedNumbers)
            
            if (gameManager.availableNumbers.isEmpty) {
                gameManager.resetGameState()
                buttonViewModel.pickedNumbers = []
                buttonViewModel.currentChoices = gameManager.availableNumbers
                gameWon.toggle()
            }
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
