//
//  ShowEncodedViewController.swift
//  Hill
//
//  Created by Tixon Markin on 04.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import UIKit

class DetailEncodeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var encodedTextLabel: UILabel!
    
    var hillItem: HillItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }
    
    func loadUI() {
        // setting labels
        titleLabel.text = "Encoded with \(hillItem.alphabet.name) aplhabet"
        encodedTextLabel.text = hillItem.encodedText
        encodedTextLabel.numberOfLines = 0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
