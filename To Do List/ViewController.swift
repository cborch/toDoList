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
