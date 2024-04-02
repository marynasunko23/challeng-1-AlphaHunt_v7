//
//  AlphaHuntViewModel.swift
//  AlphaHunt
//
//  Created by Nathan on 10/2/23.
//

import SwiftUI

class AlphaHunt: ObservableObject {
    @Published var model: AlphaHuntGame = AlphaHuntGame(isAlphabetical: true)
    @Published var isAlphabetical = true
    
//    private static func createAlphaHuntGame() -> AlphaHuntGame {
//        return AlphaHuntGame(isAlphabetical: <#Bool#>)
//    }
    
    init() {
    }
    
    var letters: Array<String> { model.letters }
    var responses: [String : String] { model.responses }
    var currentLetter: String { model.currentLetter }
    var numberCompleted: Int { model.numberCompleted }
    var percentProgress: Double { model.percentProgress }
    var invalidEntry: Bool { model.invalidEntry }
//    var isAlphabetical: Bool { model.isAlphabetical }
    
    func randomLetter(letters: Array<String>) {
        model.randomLetter(letters: letters)
    }
    
    func firstLetter(letters: Array<String>) {
        model.firstLetter(letters: letters)
    }
    
    func nextLetter(isAlphabetical: Bool, letters: Array<String>) {
        model.nextLetter(isAlphabetical: isAlphabetical, letters: letters)
    }
    
    func removeLetter(letter: String) {
        model.removeLetter(letter: letter)
    }
    
    func addResponse(response: String, isAlphabetical: Bool) {
        model.addResponse(response: response, isAlphabetical: isAlphabetical)
    }
    
    func skipLetter(isAlphabetical: Bool, letters: Array<String>) {
        model.skipLetter(isAlphabetical: isAlphabetical, letters: letters)
    }
    
    func newGame(isAlphabetical: Bool) {
        model = AlphaHuntGame(isAlphabetical: isAlphabetical)
    }
}
