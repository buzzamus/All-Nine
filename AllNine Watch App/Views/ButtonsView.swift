//
//  ButtonsView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import SwiftUI

struct ButtonsView: View {
    @State var bothDice = false
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
                            print(number)
                        } label: {
                            Text(number)
                        }
                    }
                }
            }
            HStack {
                Button {
                    print("Submit")
                } label: {
                    Text("Submit")
                }
                Toggle(isOn: $bothDice) {
                    Text("# of Dice")
                }
            }
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
    }
}
