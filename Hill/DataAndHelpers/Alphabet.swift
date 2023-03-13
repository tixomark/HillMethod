//
//  Alphabet.swift
//  Hill
//
//  Created by Tixon Markin on 04.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import Foundation

struct Alphabet: Codable {
    var name: String
    var letters: String
    
    static var archiveAlphabetsUrl: URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let alphabetsFileUrl = directory.appendingPathComponent("alphabets").appendingPathExtension("plist")
        return alphabetsFileUrl
    }
    
    static let defaultAlphabets = [Alphabet(name: "English", letters: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"),
                            Alphabet(name: "Russan", letters: "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ"),
                            Alphabet(name: "EnglishExtended", letters: "ABCDEFGHIJKLMNOPQRSTUVWXYZ .,?!"),
                            Alphabet(name: "RussanExtended", letters: "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ .,?!")]
    
    // MARK: - Managing data
    
    static func saveToFileAlphabets(alphabets: [Alphabet]) {
        guard let data = try? PropertyListEncoder().encode(alphabets) else { return }
        try? data.write(to: Alphabet.archiveAlphabetsUrl, options: .noFileProtection)
    }
    
    static func loadAlphabets() -> [Alphabet] {
        guard let data = try? Data(contentsOf: Alphabet.archiveAlphabetsUrl),
            let decodedAlphabetsArray = try? PropertyListDecoder().decode([Alphabet].self, from: data) else { return Alphabet.defaultAlphabets }
        return decodedAlphabetsArray
    }
}
