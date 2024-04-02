//
//  AlphaHuntModel.swift
//  AlphaHunt
//
//  Created by Nathan on 10/2/23.
//

import Foundation

struct AlphaHuntGame {
    private(set) var currentLetter: String = ""
    private(set) var numberCompleted: Int = 0
    private(set) var percentProgress = 0.0
    private(set) var letters: Array<String> = []
    private(set) var responses: [String : String]
//    private(set) var isAlphabetical: Bool = false
    private(set) var invalidEntry = false
    
    init(isAlphabetical: Bool) {
//        letters = ["A", "B", "C", "D", "E", "F"]
        letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        responses = ["A":"", "B":"", "C":"", "D":"", "E":"", "F":"", "G":"", "H":"", "I":"", "J":"", "K":"", "L":"", "M":"", "N":"", "O":"", "P":"", "Q":"", "R":"", "S":"", "T":"", "U":"", "V":"", "W":"", "X":"", "Y":"", "Z":""]
//        randomLetter(letters: letters)
        nextLetter(isAlphabetical: true, letters: letters)
    }
    
    mutating func addResponse(response: String, isAlphabetical: Bool) {
        if !response.isEmpty {
            if currentLetter.first == response.first {
                responses[currentLetter] = response
                numberCompleted += 1
                percentProgress += 0.03846
                removeLetter(letter: currentLetter)
//                randomLetter(letters: letters)
                nextLetter(isAlphabetical: isAlphabetical, letters: letters)
            } else {
                invalidEntry.toggle()
            }
        }
    }
    
    mutating func randomLetter(letters: Array<String>) {
        if letters.count > 0 {
            let randomLetter = letters.randomElement()!
//            removeLetter(letter: randomLetter)
//            print(letters)
            currentLetter = randomLetter
        } else {
            print("No letters remaining")
        }
    }
    
    mutating func firstLetter(letters: Array<String>) {
        if letters.count > 0 {
            let firstLetter = letters[0]
            //            removeLetter(letter: firstLetter)
            //            print(letters)
            currentLetter = firstLetter
        } else {
            print("No letters remaining")
        }
    }
    
    mutating func skipLetter(isAlphabetical: Bool, letters: Array<String>) {
        if isAlphabetical {
            if let next = letters.after(currentLetter) {
                currentLetter = next
            }
        } else {
            randomLetter(letters: letters)
        }
    }
    
    mutating func nextLetter(isAlphabetical: Bool, letters: Array<String>) {
        if isAlphabetical {
            firstLetter(letters: letters)
        } else {
            randomLetter(letters: letters)
        }
    }
    
    mutating func removeLetter(letter: String) {
        if let index = letters.firstIndex(of: letter) {
            letters.remove(at: index)
        }
    }
}

extension Array where Element: Hashable {
    func after(_ item: Element, loop: Bool = false) -> Element? {
            if let itemIndex = self.firstIndex(of: item) {
                let lastItem: Bool = (index(after:itemIndex) == endIndex)
                if loop && lastItem {
                    return self.first
                } else if lastItem {
                    return nil
                } else {
                    return self[index(after:itemIndex)]
                }
            }
            return nil
        }
    }
