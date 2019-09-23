//
//  ViewController.swift
//  To Do List
//
//  Created by Carter Borchetta on 9/22/19.
//  Copyright © 2019 Carter Borchetta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var toDoArray = ["Learn Swift", "Build Apps", "Change the World!"]
    var toDoNotesArray = ["Test 1", "Test 2", "Test 3"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        // The tableView is going to send messages out and they should be recieved by the viewController
        tableView.dataSource = self
        // The tableView is going to get data from the viewController like the toDoArray
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" { // If we clicked on a cell
            let destination = segue.destination as! DetailViewController // Force it to look specifically at DetialViewController
            let index = tableView.indexPathForSelectedRow!.row // We can force unwrap becuase we have to click on a valid cell for this to happen
            destination.toDoItem = toDoArray[index] // We can access the destination's variable toDoItem from this class and give it data
            destination.toDoNoteItem = toDoNotesArray[index]
        } else {
            // To get rid of the case where we've clicked on the plus but we still have a lingering selection
            // BC if we aren't using the EditItem we must be using the AddItem
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromDetialViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! DetailViewController
        // Lets grab the source
        if let indexPath = tableView.indexPathForSelectedRow {
            // is there an index we can grab from the row that was clicked on?
            toDoArray[indexPath.row] = sourceViewController.toDoItem!
            // update the array with the new value at the index that it used to be in
            toDoNotesArray[indexPath.row] = sourceViewController.toDoNoteItem!
            tableView.reloadRows(at: [indexPath], with: .automatic)
            // update the table at the array of indexes that were changed
        } else {
            // Must have pressed plus button(Coming back from adding new item)
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            toDoNotesArray.append(sourceViewController.toDoNoteItem!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) { // Getting the editing bar button working depedning on if in edimting mode or not it has to push you back to the other mode when you press the button
        if tableView.isEditing {
            // When the button is pressed and we are in editing mode we want to set UI back to normal(non-editing)
            tableView.setEditing(false, animated: true)
            addBarButton.isEnabled = true
            editBarButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            editBarButton.title = "Done"
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Getting the delete functionality working for both editing and swipe left
        // - Both are built into the .delete style of editing
        if editingStyle == .delete {
            toDoArray.remove(at: indexPath.row)
            toDoNotesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Getting the move row functionality working
        // We copy the source and move it to destiantion
        let itemToMove = toDoArray[sourceIndexPath.row]
        let noteToMove = toDoNotesArray[sourceIndexPath.row]
        toDoArray.remove(at: sourceIndexPath.row)
        toDoNotesArray.remove(at: sourceIndexPath.row)
        toDoArray.insert(itemToMove, at: destinationIndexPath.row)
        toDoNotesArray.insert(noteToMove, at: destinationIndexPath.row)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // Contains required methods that XCode will automatically call
    
    // Gets the total number of rows(in a section)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
        // ViewController asking tableView for number of rows and getting it returned from tableView
    }
    
    // Creates reusable tableView Cell using the "Cell" we specified on main storyboard
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        // Add some text to the cell
        // - Cells automatically have a textLabel object in it
        cell.detailTextLabel?.text = toDoNotesArray[indexPath.row]
        return cell
        // Asks the data source for a cell to insert at some location on the table view
        // Called when a cell is needed either recycled or new
        // These are function XCode will automatically call but we need to implement
        // Returning a UITableViewCell
    }
}


// 5.1 Notes
// Extension I believe is inheritance
// - Adding protocols to ViewController
// - Why can't we do it at the top again?
// - We can implement all out table view code in this little section
