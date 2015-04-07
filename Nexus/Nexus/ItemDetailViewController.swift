//
//  ItemDetailViewController.swift
//  Nexus
//
//  Created by Rich Burdon on 4/7/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailLabel: UILabel!
    
    var item:Item!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = self.item?.title
    }

    // Select textfield if click anywhere in cell.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            titleTextField.becomeFirstResponder()
        }
    }

    // Detect save event.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveItem" {
            if (self.item != nil) {
                // Update existing item.
                self.item.title = self.titleTextField.text
            } else {
                // Create new item.
                self.item = Item(title: self.titleTextField.text)
            }
        }
    }

}
