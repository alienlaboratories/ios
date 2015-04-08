//
//  ItemTypePickerViewController.swift
//  Nexus
//
//  Created by Rich Burdon on 4/7/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import UIKit

// Notes
// http://www.raywenderlich.com/81880/storyboards-tutorial-swift-part-2

class ItemTypePickerViewController: UITableViewController {

    // Sorted list of type IDs.
    var types: [String]!

    var selectedIndex: Int? = nil

    // TODO: Better way to return optional.
    func getType() -> String? {
        if (selectedIndex != nil) {
            return self.types[self.selectedIndex!]
        } else {
            return nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.types = DB.getTypes()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }

    // Get table data.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TypeCell", forIndexPath: indexPath) as UITableViewCell
        let type = self.types[indexPath.row]
        cell.textLabel?.text = DB.getTypeLabel(type)

        if indexPath.row == self.selectedIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }

        return cell
    }

    // Update selection before exit.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TypeSelected" {
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            self.selectedIndex = indexPath?.row
        }
    }

}
