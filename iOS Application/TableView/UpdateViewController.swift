//
//  UpdateViewController.swift
//  TableView
//
//  Created by Richard Richard on 9/5/17.
//  Copyright © 2017 Richard Richard. All rights reserved.
//

import UIKit

class UpdateViewController: Parent, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    var oldUser: [String:Any] = [:]
    @IBOutlet weak var nimLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nimTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var courseTF: UITextField!
    @IBOutlet weak var scoreTF: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBAction func updateButtonCLicked(_ sender: UIButton) {
        if checkTF() == true {
            updateUser(userToUpdate: oldUser, nim: nimTF.text!, name: nameTF.text!, course: courseTF.text!, score: scoreTF.text!)
            self.clearTF()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nimLabel.text = Parent.labelText.nim.rawValue
        nameLabel.text = Parent.labelText.name.rawValue
        courseLabel.text = Parent.labelText.course.rawValue
        scoreLabel.text = Parent.labelText.score.rawValue
        updateButton.setTitle("Update", for: .normal)
        updateButton.layer.borderWidth = 1
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.layer.cornerRadius = 7.0
        nimTF.delegate = self
        nameTF.delegate = self
        courseTF.delegate = self
        scoreTF.delegate = self
        let tapToHideKeyboard = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tapToHideKeyboard.delegate = self
        self.view.addGestureRecognizer(tapToHideKeyboard)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nimTF.text = oldUser["nim"] as? String
        nameTF.text = oldUser["name"] as? String
        courseTF.text = oldUser["course"] as? String
        scoreTF.text = oldUser["score"] as? String
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nimTF {
            nameTF.becomeFirstResponder()
        }
        if textField == nameTF {
            courseTF.becomeFirstResponder()
        }
        if textField == courseTF {
            scoreTF.becomeFirstResponder()
        }
        if textField == scoreTF {
            self.view.endEditing(true)
        }
        return false
    }
    
    func checkTF() -> Bool {
        if nimTF.text == "" {
            return false
        } else if nameTF.text == "" {
            return false
        } else if courseTF.text == "" {
            return false
        } else if courseTF.text == "" {
            return false
        } else if scoreTF.text == "" {
            return false
        }else {
            return true
        }
    }
    
    func clearTF() {
        nimTF.text = ""
        nameTF.text = ""
        courseTF.text = ""
        scoreTF.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
