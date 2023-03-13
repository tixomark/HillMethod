//
//  DetailHillItemViewController.swift
//  Hill
//
//  Created by Tixon Markin on 05.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import UIKit

class DetailHillItemViewController: UIViewController {
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var alphabetNameLabel: UILabel!
    @IBOutlet weak var alphabetView: UIView!
    @IBOutlet weak var alphabetLettersLabel: UILabel!
    
    @IBOutlet weak var keyView: UIView!
    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var encodedTextView: UIView!
    @IBOutlet weak var encodedTextLabel: UILabel!
    
    var hillItem: HillItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
    }
    
    func loadUI() {
        textLabel.text = hillItem.text.lowercased()
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8.0
        textView.layer.borderColor = HillController.interfaceColor
        
        alphabetNameLabel.text = "Encoded using \(hillItem.alphabet.name) alphabet:"
        
        alphabetLettersLabel.text = hillItem.alphabet.letters.lowercased()
        alphabetView.layer.borderWidth = 1
        alphabetView.layer.cornerRadius = 8.0
        alphabetView.layer.borderColor = HillController.interfaceColor
        
        keyLabel.text = hillItem.key.lowercased()
        keyView.layer.borderWidth = 1
        keyView.layer.cornerRadius = 8.0
        keyView.layer.borderColor = HillController.interfaceColor
        
        encodedTextLabel.text = hillItem.encodedText!.lowercased()
        encodedTextView.layer.borderWidth = 1
        encodedTextView.layer.cornerRadius = 8.0
        encodedTextView.layer.borderColor = HillController.interfaceColor
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
