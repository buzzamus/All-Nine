//
//  GameOverView.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 6/2/23.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        Group {
            Button {
                print("restarting")
            } label: {
                Text("Restart")
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}
