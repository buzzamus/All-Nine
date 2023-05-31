//
//  DiceRollView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import SwiftUI

struct DiceRollView: View {
    @State var diceToRoll = 2
    var body: some View {
        Form {
            Picker("Number of Dice to Roll", selection: $diceToRoll) {
                Text("Roll One Dice").tag(1)
                Text("Roll Both Dice").tag(2)
            }
            Button {
                print(diceToRoll)
            } label: {
                Text("Submit")
            }
        }
    }
}

struct DiceRollView_Previews: PreviewProvider {
    static var previews: some View {
        DiceRollView()
    }
}
