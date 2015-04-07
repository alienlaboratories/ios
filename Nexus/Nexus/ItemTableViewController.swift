//
//  TableViewController.swift
//  Nexus
//
//  Created by Rich Burdon on 4/5/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    let tableViewDataSource = TableViewDataSourceAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self.tableViewDataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Set-up detail view.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EditItem") {
            let row = self.tableView.indexPathForSelectedRow()?.row
            let dataSource = self.tableView.dataSource as TableViewDataSourceAdapter
            let item = dataSource.items[row!]

            // Configure the detail scene.
            let itemDetailViewController = segue.destinationViewController.topViewController as ItemDetailViewController
            itemDetailViewController.item = item
        }
    }

    //
    // Event handlers.
    //
    
    @IBAction func onClearButton(sender: AnyObject) {
        self.tableViewDataSource.clear()
        self.tableView.reloadData()
    }

    @IBAction func onRefreshButton(sender: AnyObject) {
        self.tableViewDataSource.update()
        self.tableView.reloadData()
    }
    
    @IBAction func cancelDetail(segue: UIStoryboardSegue) {
        // No-op
    }
    
    @IBAction func saveDetail(segue: UIStoryboardSegue) {
        let itemDetailViewController = segue.sourceViewController as ItemDetailViewController

        // Update the data source
        let dataSource = self.tableView.dataSource as TableViewDataSourceAdapter
        let item = itemDetailViewController.item

        // Create new item
        if (item.id == nil) {
            item.id = db.getId()
            dataSource.items.append(item)
        }

        // Update the table view.
        self.tableView.reloadData()

        dismissViewControllerAnimated(true, completion: nil)
    }

}
