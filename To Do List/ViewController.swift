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
    
    var toDoArray = ["Learn Swift", "Build Apps", "Change the World!"]
    

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
            tableView.reloadRows(at: [indexPath], with: .automatic)
            // update the table at the array of indexes that were changed
        } else {
            // Must have pressed plus button
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            toDoArray.append(sourceViewController.toDoItem!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
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
