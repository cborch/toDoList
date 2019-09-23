//
//  DetailViewController.swift
//  To Do List
//
//  Created by Carter Borchetta on 9/22/19.
//  Copyright © 2019 Carter Borchetta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var toDoField: UITextField!
    var toDoItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toDoItem = toDoItem { // If its not nil(if assignment from String? to String works)
            toDoField.text = toDoItem
        }
        enableDisableSaveButton()
        toDoField.becomeFirstResponder()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSave" {
            toDoItem = toDoField.text
        }
    }
    
    func enableDisableSaveButton() {
        if let toDoFieldCount = toDoField.text?.count, toDoFieldCount > 0 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func toDoFieldChanged(_ sender: UITextField) {
    // Responds anytime editing inside is changed
        enableDisableSaveButton()

        
//        if toDoField.text!.count > 0 { // We can force unwrap safely becuase even an empty text field is an empty string so it won't ever be nil
//            saveBarButton.isEnabled = true
//        } else {
//            saveBarButton.isEnabled = false
//        }
    }
    

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        // Did we come over from Navigation controller, if so we came from Add
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

// 5.3 Notes
// Passing data between viewControllers
// When you do this one will be the Source and one will be the Destination
// - The desitnation will have to have a var to catch the data from the source
// - Use prepare for segue

// Navigation controllers manage the stack of viewControllers
// Also add a navigation bar with navigation bar buttons
// View controllers are embedded in in Navigation Controllers
// Segue = transitions between different viewControllers
// - Present modally  = used when user must complete a new task
// - New viewController slides up from bottom
// - Show = used when showing detail
// - Comes in on right

// Present Modally goes through navigation controller
// Show does not need to go through navigation controller
// When you present modally you dismiss to go back

// When you show you pop to go back 

// Unwind = returning from where we started from
// - Have a condition here where when we press save we want code to be executed back on the main ViewContoller 
