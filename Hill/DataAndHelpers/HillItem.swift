//
//  HillItem.swift
//  Hill
//
//  Created by Tixon Markin on 03.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import Foundation

struct HillItem: Codable {
    var text: String
    var encodedText: String?
    var alphabet: Alphabet
    var key: String
    var matrix: [[Int]]?
    
    static var archiveHillItemsUrl: URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let hillItemsFileUrl = directory.appendingPathComponent("hillItems").appendingPathExtension("plist")
        return hillItemsFileUrl
    }
    
    // MARK: - Managing data
    
    static func saveToFileHillItems(hillItems: [HillItem]) {
        guard let data = try? PropertyListEncoder().encode(hillItems) else { return }
        try? data.write(to: HillItem.archiveHillItemsUrl, options: .noFileProtection)
    }
    
    static func loadHillItems() -> [HillItem] {
        guard let data = try? Data(contentsOf: HillItem.archiveHillItemsUrl),
            let decodedHillItemsArray = try? PropertyListDecoder().decode([HillItem].self, from: data) else { return [] }
        return decodedHillItemsArray
    }
    
}
