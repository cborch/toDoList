//
//  DetailViewController.swift
//  To Do List
//
//  Created by Carter Borchetta on 9/22/19.
//  Copyright © 2019 Carter Borchetta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var toDoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


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
