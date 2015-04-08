//
//  NexusModel.swift
//  Nexus
//
//  Created by Rich Burdon on 4/5/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

// Spec:
// - Query for list of items
// - Add, edit, remove
// - Add/remove links
// - Display graph of items
// - Display set of cards for items

// TODO: Item object (from JSON)

// TODO: Load data from JSON file: http://www.raywenderlich.com/82706/working-with-json-in-swift-tutorial
// TODO: Post to server (actions)
// TODO: Auth

// http://www.raywenderlich.com/75289/swift-tutorial-part-3-tuples-protocols-delegates-table-views
// TODO: Search: http://www.raywenderlich.com/76519/add-table-view-search-swift
// TODO: labels
// TODO: J2ObjC share Java database code
// TODO: Search/Query/Result (local and remote)
// TODO: OpenGL/Metal graph (with links)
// TODO: Sidemenu
// TODO: Pulldown menu (options)
// TODO: Test tab


class Item: NSObject {
    
    var id: String?
    var type: String?
    var title: String?

    init(id: String?=nil, type: String?=nil, title: String?=nil) {
        self.id = id
        self.type = type
        self.title = title

        super.init()
    }

    func applyMutation(mutation: Item) {
        if (mutation.type != nil) {
            self.type = mutation.type
        }
        if (mutation.title != nil) {
            self.title = mutation.title
        }
    }

    func debug() -> String {
        return "Item(id:\(self.id), type:\(self.type), title:\(self.title))"
    }

}

/**
 * Database singleton (class utility).
 */
class DB {

    private struct Internal {

        static var idmax = 0

        // TODO: Model types as items?
        static let types: [String:String] = [
            "person":   "Person",
            "org":      "Org",
            "place":    "Place",
            "event":    "Event",
            "task":     "Task",
            "message":  "Message",
            "note":     "Note",
        ]

        // TODO: Load from file.
        static let items: [Item] = [
            Item(id: DB.getId(), type: "place", title: "Amsterdam"),
            Item(id: DB.getId(), type: "place", title: "Barcelona"),
            Item(id: DB.getId(), type: "place", title: "Copenhagen"),
            Item(id: DB.getId(), type: "place", title: "Hanoi"),
            Item(id: DB.getId(), type: "place", title: "Hong Kong"),
            Item(id: DB.getId(), type: "place", title: "London"),
            Item(id: DB.getId(), type: "place", title: "Los Angeles"),
            Item(id: DB.getId(), type: "place", title: "New York"),
            Item(id: DB.getId(), type: "place", title: "Paris"),
            Item(id: DB.getId(), type: "place", title: "Shanghai"),
            Item(id: DB.getId(), type: "place", title: "Tokyo"),
            Item(id: DB.getId(), type: "place", title: "Zurich"),
        ]

    }

    // TODO: Replace with DB.getInstance().getId() (make mockable).

    class func getId() -> String {
        Internal.idmax++
        return "I\(Internal.idmax)"
    }

    class func getItems() -> [Item] {
        return Internal.items
    }
    
    class func getTypes() -> [String] {
        return [String](Internal.types.keys)
    }

    class func getTypeLabel(type: String) -> String {
        return Internal.types[type]!
    }

}

class QueryModel {

    // Async query
    // TODO: Return result object.
    func query(#success: ([Item]) -> ()) {
        var delta: Int64 = 500 * Int64(NSEC_PER_MSEC)
        var time = dispatch_time(DISPATCH_TIME_NOW, delta)

        NSLog("Query...")
        dispatch_after(time, dispatch_get_main_queue()) {
            success(DB.getItems())
        }
    }

    // TODO: Move to test or playground.
    func test() {
        let raw = [
            "id": "123",
            "summary": [
                "title": "Test"
            ]
        ]

        let json = JSON(raw)
        println(json)
    }

}

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
        self.model.query(success: { (items: [Item]) -> () in
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
