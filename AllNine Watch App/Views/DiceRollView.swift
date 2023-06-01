//
//  DiceRollView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import SwiftUI

struct DiceRollView: View {
    @State var diceToRoll = 2
    @State var allowSingleDiceRoll = false
    var body: some View {
        Form {
            Picker("Number of Dice to Roll", selection: $diceToRoll) {
                Text("Roll One Dice").tag(1)
                Text("Roll Both Dice").tag(2)
            }
            .disabled(true)
            Button {
                print(allowSingleDiceRoll)
            } label: {
                Text("Roll Dice")
            }
            
        }
    }
}

struct DiceRollView_Previews: PreviewProvider {
    static var previews: some View {
        DiceRollView()
    }
}
