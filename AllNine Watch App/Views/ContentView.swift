//
//  ContentView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 5/30/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameManager = GameManager()
    var body: some View {
        VStack {
            HStack {
                Text("Roll: \(gameManager.rolledValue)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.leading)
            }
            ButtonsView()
        }
        .environmentObject(gameManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
