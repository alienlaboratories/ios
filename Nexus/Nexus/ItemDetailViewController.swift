//
//  ItemDetailViewController.swift
//  Nexus
//
//  Created by Rich Burdon on 4/7/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController {
    
    // Currently selected item.
    var item: Item!

    // Fields.
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var typeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Update fields.
        self.titleTextField.text = self.item?.title
        if let type = self.item?.type {
            self.typeLabel.text = type
        }

        // Create placeholder item.
        if (self.item == nil) {
            self.item = Item()
        }
    }

    // Select textfield if click anywhere in cell.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            self.titleTextField.becomeFirstResponder()
        }
    }

    // Detect save event.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveItem" {
            // Update item.
            self.item.title = self.titleTextField.text
            self.item.type = self.typeLabel.text
        }
    }

    //
    // Events
    //

    @IBAction func onSelectType(segue: UIStoryboardSegue) {
        let itemTypePickerViewController = segue.sourceViewController as ItemTypePickerViewController
        if let type = itemTypePickerViewController.getType() {
            self.typeLabel.text = type
            
            // Close pop-over.
            itemTypePickerViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
