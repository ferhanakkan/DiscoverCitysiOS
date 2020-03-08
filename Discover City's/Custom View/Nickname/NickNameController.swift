//
//  NickNameController.swift
//  DiscoverCity
//
//  Created by ferhan akkan on 6.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class NickNameController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var outletSwitch: UISwitch!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRadius()
        
    }
        
    private func setRadius() {
        mainView.cornerRadius = 20
        continueButton.cornerRadius = 15
        
        let myColor = UIColor.rouge
        continueButton.layer.borderWidth = 3.0
        continueButton.layer.borderColor = myColor.cgColor
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    

    
    @IBAction func textfieldAction(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        if sender.isOn {
            nicknameTextfield.isUserInteractionEnabled = true
        } else {
            nicknameTextfield.text?.removeAll()
            nicknameTextfield.isUserInteractionEnabled = false
        }
        
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        if outletSwitch.isOn && nicknameTextfield.text == "" {
           let alert = SingletonGameManager.shared.makeAlert(title: "Ups!!", message: "Please enter nickname or turn off switch.")
            UIApplication.getPresentedViewController()!.present(alert, animated: true)
        } else {
            if outletSwitch.isOn {
                UserDefaults.standard.setValue(true, forKey: "nicknamePreferance")
                UserDefaults.standard.setValue(nicknameTextfield.text, forKey: "UserNickName")
            } else {
                UserDefaults.standard.setValue(false, forKey: "nicknamePreferance")
            }
            
            dismiss(animated: true, completion: nil)
        }
    }

}
