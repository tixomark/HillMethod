//
//  AddAlphabetViewController.swift
//  Hill
//
//  Created by Tixon Markin on 05.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import UIKit

class AddAlphabetViewController: UIViewController {
    
    @IBOutlet weak var alphabetNameView: UIView!
    @IBOutlet weak var alphabetNameTextField: UITextField!
    
    @IBOutlet weak var alphabetLettersView: UIView!
    @IBOutlet weak var alphabetLettersTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveButtonTopConstraint: NSLayoutConstraint!
    
    var alphabet: Alphabet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        addObservers()
        
        self.alphabetNameTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Selector funcs
    
    @objc func keyboardWillHide() {
        saveButtonTopConstraint.constant = 20.0
        view.layoutIfNeeded()
    }
    
    // MARK: - My Funcs
    
    func loadUI() {
        if let alphabet = alphabet {
            alphabetNameTextField.text = alphabet.name
            alphabetLettersTextView.text = alphabet.letters
        }
        
        alphabetLettersView.layer.borderWidth = 1.0
        alphabetLettersView.layer.cornerRadius = 8.0
        alphabetLettersView.layer.borderColor = HillController.interfaceColor
        
        alphabetNameView.layer.borderWidth = 1.0
        alphabetNameView.layer.cornerRadius = 8.0
        alphabetNameView.layer.borderColor = HillController.interfaceColor
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey ] as? CGRect else { return }
            self.saveButtonTopConstraint.constant = keyboardSize.height - self.view.safeAreaInsets.bottom - self.saveButton.frame.height
            self.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveAlphabet" {
            alphabet = Alphabet(name: alphabetNameTextField.text!, letters: alphabetLettersTextView.text)
        }
    }
}

// MARK: - Extensions

extension AddAlphabetViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
