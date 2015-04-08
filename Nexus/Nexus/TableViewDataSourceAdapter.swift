//
//  TableViewDataSourceAdapter.swift
//  Nexus
//
//  Created by Rich Burdon on 4/8/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import UIKit

class TableViewDataSourceAdapter: NSObject, UITableViewDataSource {
    
    // TODO: Pass in.
    let model = QueryModel()
    
    // TODO: replace with result object.
    // TODO: create dictionary.
    var items = [Item]()
    
    func clear() {
        self.items = []
    }
    
    // Async update.
    func update(#success: () -> ()) {
        self.model.query(success: { (items: [Item]) -> Void in
            NSLog("Result: \(items.count)")
            self.items = items
            success()
        })
    }
    
    // Get item by ID from cache.
    func getItem(id: String) -> Item? {
        for item in self.items {
            if (item.id == id) {
                return item
            }
        }
        
        return nil
    }
    
    // TOOD: Why is override not valid?
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row] as Item
        
        // Reuse named cells.
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ItemCell") as UITableViewCell
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.debug()
        
        return cell
    }
    
}
