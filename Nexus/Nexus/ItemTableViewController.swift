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
    
    @IBAction func onCancelDetail(segue: UIStoryboardSegue) {
        // No-op.
    }

    @IBAction func onSaveDetail(segue: UIStoryboardSegue) {
        let itemDetailViewController = segue.sourceViewController as ItemDetailViewController

        // Update the data source.
        let dataSource = self.tableView.dataSource as TableViewDataSourceAdapter
        let mutation = itemDetailViewController.mutation

        // Apply the mutation.
        // TODO: Move to database.
        println("Mutation: \(mutation.debug())")
        var item: Item
        if (mutation.id != nil) {
            item = dataSource.getItem(mutation.id!)!
        } else {
            // Create new item.
            item = Item(id: db.getId())
            dataSource.items.append(item)
        }
        item.applyMutation(mutation)

        // Update the table view.
        self.tableView.reloadData()

        dismissViewControllerAnimated(true, completion: nil)
    }

}
