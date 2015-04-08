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

// TODO: Source control project

// http://www.raywenderlich.com/75289/swift-tutorial-part-3-tuples-protocols-delegates-table-views

// TODO: Table + Detail Segue: http://www.raywenderlich.com/81880/storyboards-tutorial-swift-part-2
// TODO: Item object (from JSON)
// TODO: Populate table view
// TODO: Add item from segue
// TODO: Pick type

// TODO: Search: http://www.raywenderlich.com/76519/add-table-view-search-swift

// TODO: Load data from JSON file: http://www.raywenderlich.com/82706/working-with-json-in-swift-tutorial
// TODO: Post to server (actions)
// TODO: Auth

// TODO: Table with columns
// TODO: Reuse rows (identifier)

// TODO: labels
// TODO: J2ObjC share Java database code
// TODO: Search/Query/Result (local and remote)
// TODO: OpenGL/Metal graph (with links)
// TODO: Sidemenu
// TODO: Navmenu


// TODO: Replace with protocol buffer
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

class DB {
    
    var idmax = 0

    func getId() -> String {
        self.idmax++
        return "I\(self.idmax)"
    }
    
    // TODO: Model types as items.
    let types: [String:String] = [
        "person":   "Person",
        "place":    "Place",
        "org":      "Org",
        "event":    "Event",
        "task":     "Task",
        "note":     "Note"
    ]

    func getTypes() -> [String] {
        return [String](self.types.keys)
    }

    func getTypeLabel(type: String) -> String {
        return self.types[type]!
    }

}

// TODO: Global
let db = DB()

class QueryModel {

    // TODO(burdon): Load from file.
    let DATA = [
        Item(id: db.getId(), type: "place", title: "Amserterdam"),
        Item(id: db.getId(), type: "place", title: "Barcelona"),
        Item(id: db.getId(), type: "place", title: "Copenhagen"),
        Item(id: db.getId(), type: "place", title: "Hanoi"),
        Item(id: db.getId(), type: "place", title: "Hong Kong"),
        Item(id: db.getId(), type: "place", title: "London"),
        Item(id: db.getId(), type: "place", title: "Los Angeles"),
        Item(id: db.getId(), type: "place", title: "New York"),
        Item(id: db.getId(), type: "place", title: "Paris"),
        Item(id: db.getId(), type: "place", title: "Shanghai"),
        Item(id: db.getId(), type: "place", title: "Tokyo"),
        Item(id: db.getId(), type: "place", title: "Zurich"),
    ]

    // TODO(burdon): Return Result object.
    func getItems() -> [Item] {
        return DATA
    }
    
    func test() {

        let jsonObject = [
            "name": "Test"
        ]

        let json = JSON(jsonObject)
    
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
    
    func update() {
        self.items = self.model.getItems()
    }
    
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
