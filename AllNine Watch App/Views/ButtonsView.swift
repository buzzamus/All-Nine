//
//  ButtonsView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import SwiftUI

struct ButtonsView: View {
    // these all need to be moved to GameManager
    var availableNumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    @State var bothDice = false
    @State var isInvalidSubmittedValue = false
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
                    if (2 + 2 == 4) {
                        isInvalidSubmittedValue = true
                    }
                } label: {
                    Text("Submit")
                }
                .alert(isPresented: $isInvalidSubmittedValue) {
                    Alert(
                        title: Text("Invalid Amount Submitted"),
                        message: Text("Your submission must match the amount you rolled.")
                    )
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
