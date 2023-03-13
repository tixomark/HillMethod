//
//  HillController.swift
//  Hill
//
//  Created by Tixon Markin on 03.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import Foundation
import UIKit

class HillController {
    
    static var shared = HillController()
    
    static let interfaceColor = CGColor(srgbRed: 0.94, green: 0.64, blue: 0.24, alpha: 1)
    
    static let historyUpdatedNotification = Notification.Name("HillController.historyUpdated")
    static let appendedNewAlphabet = Notification.Name("HillController.appendedNewAlphabet")
    
    var hillItems: [HillItem] = HillItem.loadHillItems() {
        didSet {
            NotificationCenter.default.post(name: HillController.historyUpdatedNotification, object: nil)
            HillItem.saveToFileHillItems(hillItems: self.hillItems)
        }
    }
    
    var alphabets: [Alphabet] = Alphabet.loadAlphabets() {
        didSet {
            NotificationCenter.default.post(name: HillController.appendedNewAlphabet, object: nil)
            Alphabet.saveToFileAlphabets(alphabets: self.alphabets)
        }
    }
    
    // MARK: - Logic to encode text
    
    static func toMatrix(withText text: String, inAlphabet alphabet: Alphabet, withKey key: String) -> [[Int]] {
        
        var numberedText: [Int] = []
        let dim = Int(sqrt(Double(key.count)))
        
        for letter in text {
            for (index, caracter) in alphabet.letters.enumerated() {
                if letter == caracter {
                    numberedText.append(index)
                }
            }
        }
        
        var numberedTextMatrix: [[Int]] = Array.init(repeating: Array.init(repeating: 0, count: dim), count: numberedText.count / dim)
        
        // from vector to matrix
        for i in 0 ..< numberedText.count / dim {
            for j in 0 ..< dim {
                numberedTextMatrix[i][j] = numberedText[i * dim + j]
            }
        }
        return numberedTextMatrix
    }
    
    static func encode(hillItem: HillItem) -> HillItem {
        
        var numberedTextMatrix = toMatrix(withText: hillItem.text, inAlphabet: hillItem.alphabet, withKey: hillItem.key)
        let matrix = toMatrix(withText: hillItem.key, inAlphabet: hillItem.alphabet, withKey: hillItem.key)
        let dim = matrix.count
        var sum = 0
        
        //multiplication and mod
        for i in 0 ..< numberedTextMatrix.count {
            var newMatr = Array.init(repeating: 0, count: dim)
            for j in 0 ..< dim {
                sum = 0
                for f in 0 ..< dim {
                    sum += matrix[j][f] * numberedTextMatrix[i][f]
                }
                newMatr[j] = sum % hillItem.alphabet.letters.count
            }
            numberedTextMatrix[i] = newMatr
        }
        
        var encodedString = ""
        
        //from numbers to text
        for i in 0 ..< numberedTextMatrix.count {
            for number in 0 ..< dim {
                for (index, caracter) in hillItem.alphabet.letters.enumerated() {
                    if numberedTextMatrix[i][number] == index {
                        encodedString.append(caracter)
                    }
                }
            }
        }
        return HillItem(text: hillItem.text, encodedText: encodedString, alphabet: hillItem.alphabet, key: hillItem.key, matrix: matrix)
    }
}
