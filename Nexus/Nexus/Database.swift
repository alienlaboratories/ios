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
    var title: String
    
    init(id: String?=nil, title: String) {
        self.id = id
        self.title = title

        super.init()
    }

    func debug() -> String {
        return "Item(\(self.id))"
    }
    
}

class DB {
    
    var idmax = 0
    func getId() -> String {
        idmax++
        return "I\(idmax)"
    }
    
}

// TODO: Global
let db = DB()

class QueryModel {

    // TODO(burdon): Load from file.
    let DATA = [
        Item(id: db.getId(), title: "Amserterdam"),
        Item(id: db.getId(), title: "Barcelona"),
        Item(id: db.getId(), title: "Copenhagen"),
        Item(id: db.getId(), title: "Hanoi"),
        Item(id: db.getId(), title: "Hong Kong"),
        Item(id: db.getId(), title: "London"),
        Item(id: db.getId(), title: "Los Angeles"),
        Item(id: db.getId(), title: "New York"),
        Item(id: db.getId(), title: "Paris"),
        Item(id: db.getId(), title: "Shanghai"),
        Item(id: db.getId(), title: "Tokyo"),
        Item(id: db.getId(), title: "Zurich"),
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
    var items = [Item]()
    
    func clear() {
        self.items = []
    }
    
    func update() {
        self.items = self.model.getItems()
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
