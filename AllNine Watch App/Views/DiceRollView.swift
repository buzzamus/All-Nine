//
//  DiceRollView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import SwiftUI

struct DiceRollView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var gameManager: GameManager
    @State var numberofDice = 2
    @State var gameOver = false
    var body: some View {
        Form {
            if (!gameManager.mustRollBothDice()) {
                Picker("Number of Dice to Roll", selection: $numberofDice) {
                    Text("Roll One Dice").tag(1)
                    Text("Roll Both Dice").tag(2)
                }
            }
            Button {
                gameManager.setNumberOfDice(dice: numberofDice)
                gameManager.rollDice()
                checkForGameOver(currentRoll: gameManager.rolledValue)
                
                if (gameOver) {
                    numberofDice = 2
                    gameManager.resetGameState()
                } else {
                    dismiss()
                }
            } label: {
                Text("Roll Dice")
            }
            .alert(isPresented: $gameOver) {
                Alert(
                    title: Text("Game over"),
                    message: Text("No more winning combinations with roll of \(gameManager.rolledValue). New game starting.")
                )
            }
        }
        .navigationBarTitle("") //this must be empty
        .navigationBarHidden(true)
    }
    
    func checkForGameOver(currentRoll: Int) {
        if (gameManager.isGameWinnable(rolledAmount: currentRoll) == false) {
            gameOver.toggle()
        }
    }
}

struct DiceRollView_Previews: PreviewProvider {
    static var previews: some View {
        DiceRollView()
            .environmentObject(GameManager())
    }
}
