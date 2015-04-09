//
//  TestViewController.swift
//  Nexus
//
//  Created by Rich Burdon on 4/8/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import UIKit
import SwiftyJSON

class TestTableViewController: UITableViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func onTestButton(sender: AnyObject) {
        JsonFileLoader(filePath: DB.Test.DATA_FILE).load({ (data: JSON?, error: Int?) -> Void in
            if (data != nil) {
                println(data)
                let item = data!["item"][0]
                println(item)
                let title = item["summary"]["title"].stringValue
                NSLog("Title: \(title)")

                // TODO: Must update UI on main thread (not closure).
                // http://stackoverflow.com/questions/25603390/swift-update-label-with-html-content-takes-1min/25603877#25603877
                dispatch_async(dispatch_get_main_queue()) {
                    self.statusLabel.text = title
                }
            } else {
                NSLog("Error: \(error)")
            }
        })
        
    }

}
