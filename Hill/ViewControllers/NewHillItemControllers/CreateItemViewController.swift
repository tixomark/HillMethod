//
//  CreateItemViewController.swift
//  Hill
//
//  Created by Tixon Markin on 04.12.2019.
//  Copyright © 2019 Tixon Markin. All rights reserved.
//

import UIKit

class CreateItemViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var textToEncodeView: UIView!
    @IBOutlet weak var textToEncodeTextField: UITextView!
    
    @IBOutlet weak var codeVordView: UIView!
    @IBOutlet weak var codeWordTextField: UITextField!
    
    @IBOutlet weak var alphabetLettersLabel: UILabel!
    
    @IBOutlet weak var alphabetPickerView: UIPickerView!
    
    @IBOutlet weak var encodeButtonOutlet: UIButton!
    
    @IBOutlet weak var alphabetLettersLabelBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var encodeButtonBottomSpace: NSLayoutConstraint!
    
    var hillItem: HillItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        
        self.alphabetPickerView.delegate = self
        self.alphabetPickerView.dataSource = self
        self.codeWordTextField.delegate = self
        
        addObservers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - My Funcs
    
    func loadUI() {
        let selectedAlphabet = HillController.shared.alphabets[alphabetPickerView.selectedRow(inComponent: 0)]
        
        textToEncodeView.layer.borderWidth = 1
        textToEncodeView.layer.cornerRadius = 8.0
        textToEncodeView.layer.borderColor = HillController.interfaceColor
        
        codeWordTextField.placeholder = "Enter your key phrase"
        codeVordView.layer.borderWidth = 1
        codeVordView.layer.cornerRadius = 8.0
        codeVordView.layer.borderColor = HillController.interfaceColor
        
        alphabetLettersLabel.text = selectedAlphabet.letters
        alphabetLettersLabel.textAlignment = .center
        alphabetLettersLabel.numberOfLines = 2
        
        encodeButtonOutlet.setTitle("Encode with \(selectedAlphabet.name)", for: .normal)
        encodeButtonOutlet.titleLabel?.textColor = .white
        encodeButtonOutlet.backgroundColor = UIColor(cgColor: HillController.interfaceColor)
        encodeButtonOutlet.layer.cornerRadius = 8.0
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadPickerData), name: HillController.appendedNewAlphabet, object: nil)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey ] as? CGRect else { return }
            self.alphabetLettersLabelBottomSpace.constant = keyboardSize.height - self.view.safeAreaInsets.bottom - self.encodeButtonOutlet.frame.height - self.encodeButtonBottomSpace.constant - self.alphabetPickerView.frame.height - self.alphabetLettersLabel.frame.height
            self.alphabetPickerView.isHidden = true
            self.view.layoutIfNeeded()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Selector funcs
    
    @objc func keyboardWillHide() {
        alphabetLettersLabelBottomSpace.constant = 0
        self.alphabetPickerView.isHidden = false
        self.view.layoutIfNeeded()
    }
    
    @objc func reloadPickerData() {
        alphabetPickerView.reloadComponent(0)
        alphabetLettersLabel.text = HillController.shared.alphabets[alphabetPickerView.selectedRow(inComponent: 0)].letters
        encodeButtonOutlet.setTitle("Encode with \(HillController.shared.alphabets[alphabetPickerView.selectedRow(inComponent: 0)].name)", for: .normal)
    }
    
    // MARK: - Button Actions
    
    @IBAction func CountButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2) {
            self.encodeButtonOutlet.transform = CGAffineTransform(scaleX: 1.4, y: 1.3)
            self.encodeButtonOutlet.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        // Check dimensions
        let root = Int(sqrt(Double(codeWordTextField.text!.count)))
        
        if codeWordTextField.text?.count != 0,
           textToEncodeTextField.text.count != 0,
           root * root == codeWordTextField.text!.count,
           textToEncodeTextField.text.count % root == 0 {
            
            let text = textToEncodeTextField.text!.uppercased()
            let alphabet = HillController.shared.alphabets[alphabetPickerView.selectedRow(inComponent: 0)]
            let key = codeWordTextField.text!.uppercased()
            
            hillItem = HillItem(text: text, alphabet: alphabet, key: key)
            hillItem = HillController.encode(hillItem: hillItem)
            
            HillController.shared.hillItems.append(hillItem)
            
            performSegue(withIdentifier: "ToDetailEncodeViewController", sender: UIButton())
            
        } else {
            var message = ""
            if codeWordTextField.text?.count == 0 ||
                textToEncodeTextField.text.count == 0 {
                message = "Fields can not be empty"
            } else if root * root != codeWordTextField.text!.count {
                message = "Hill method requires key phrase lenght to have integer square root"
            } else if textToEncodeTextField.text.count % root != 0 {
                message = "Encoding text character number must be a multile of square root of key phrase"
            }
            
            let alert = UIAlertController(title: "Methodology Trouble", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailEncodeViewController" {
            let detailEncodeViewController = segue.destination as! DetailEncodeViewController
            detailEncodeViewController.hillItem = hillItem
        }
    }
    
    @IBAction func unwindToHillItemCreation(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissDetailedEncodeController" {
            textToEncodeTextField.text = ""
            codeWordTextField.text = ""
            alphabetPickerView.selectRow(0, inComponent: 0, animated: true)
        }
    }
}

// MARK: Extensions

extension CreateItemViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return HillController.shared.alphabets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return HillController.shared.alphabets[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        encodeButtonOutlet.setTitle("Encode with \(HillController.shared.alphabets[row].name)", for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.alphabetLettersLabel.text = HillController.shared.alphabets[row].letters
            self.view.layoutIfNeeded()
        }
    }
}

extension CreateItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
