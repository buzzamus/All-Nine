//
//  ButtonViewModel.swift
//  AllNine Watch App
//
//  Created by Brent Busby on 6/6/23.
//

import Foundation

// used to resolve issue where state changes in DiceRollView would not update until one
// turn later in the ButtonsView
// separates current form state from GameManager state and used for reconciliation
class ButtonViewModel: ObservableObject {
    @Published var pickedNumbers: [Int] = []
    @Published var currentChoices = [1, 2, 3, 4, 5, 6, 7, 8, 9]
}
