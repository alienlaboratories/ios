//
//  Util.swift
//  Nexus
//
//  Created by Rich Burdon on 4/5/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import Foundation
import SwiftyJSON

class Util {

    private init() {}

    // Test if value changed.
    class func changed(v1: String?, v2: String?) -> Bool {
        if (v1 != nil) {
            return v1 != v2
        }

        return v2 != nil
    }

    // Async read local file.
    class func loadFromFile(filePath: String, success: (data: NSData?, error: Int?) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var readError: NSError?
            if let data = NSData(
                contentsOfFile: filePath,
                options: NSDataReadingOptions.DataReadingUncached,
                error: &readError) {
                    success(data: data, error: nil)
                }
        })
    }

    // Async read from URL.
    class func loadFromURL(url: NSURL, success: (data: NSData?, error: Int?) -> Void) {
        var session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL.
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: {
            (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if let responseError = error {
                    success(data: nil, error: responseError.code)
                } else if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        success(data: nil, error: httpResponse.statusCode)
                    } else {
                        success(data: data, error: nil) // OK
                    }
                }
        })
        
        loadDataTask.resume()
    }

}

class JsonLoader {
    
    private init() {}
    
    // Async load JSON object.
    // NOTE: UI updates must be dispatched via main thread.
    // http://stackoverflow.com/questions/25603390/swift-update-label-with-html-content-takes-1min/25603877#25603877
    func load(success: (data: JSON?, error: Int?) -> Void) {
        fatalError("Not implemented")
    }

    // Silently returns nil on parse error.
    func toJson(data: NSData?) -> JSON? {
        if (data != nil) {
            return JSON(data: data!)
        }

        return nil
    }

}

class JsonFileLoader: JsonLoader {
    
    let filePath: String
    
    init(filePath: String) {
        self.filePath = filePath
    }
    
    override func load(success: (data: JSON?, error: Int?) -> Void) {
        Util.loadFromFile(self.filePath, success: { (data: NSData?, error: Int?) -> Void in
            success(data: self.toJson(data), error: error)
        })
    }
}

class JsonUrlLoader: JsonLoader {
    
    let url: NSURL
    
    init(url: NSURL) {
        self.url = url
    }
    
    override func load(success: (data: JSON?, error: Int?) -> Void) {
        Util.loadFromURL(self.url, success: { (data: NSData?, error: Int?) -> Void in
            success(data: self.toJson(data), error: error)
        })
    }
}

