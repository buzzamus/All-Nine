//
//  ContentView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import SwiftUI

struct ContentView: View {
    var currentRoll = 12
    var body: some View {
        VStack {
            HStack {
                Text("Roll: \(currentRoll)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.leading)
            }
            ButtonsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
