//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Jake Sager on 12/3/16.
//  Copyright © 2016 Jake Sager. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    enum NameError: Error {
        case NoName
    }

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nameTextFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            do {
                if let name = nameTextField.text {
                    if name == "" {
                        throw NameError.NoName
                    }
                    if let pageController = segue.destination as? PageController {
                        pageController.page = Adventure.story(name: name)
                    }
                    
                }
            } catch NameError.NoName {
                let alertController = UIAlertController(title: "Name Not Provided", message: "Please enter a name so you can play the game!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                    present(alertController, animated: true, completion: nil)
            } catch let error {
                fatalError("\(error)")
            }
        }
    }
    
    func keyboardWillShow(notification: Notification) {
        if let userInfoDict = notification.userInfo,
            let keyboardFrameValue = userInfoDict[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardFrame = keyboardFrameValue.cgRectValue
            UIView.animate(withDuration: 0.8) {
                self.nameTextFieldBottomConstraint.constant = keyboardFrame.size.height + 10
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.8) {
            self.nameTextFieldBottomConstraint.constant = 36
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    


}

