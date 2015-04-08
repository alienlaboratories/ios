//
//  Util.swift
//  Nexus
//
//  Created by Rich Burdon on 4/5/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

class Util {

    // Test if value changed.
    class func changed(v1: String?, v2: String?) -> Bool {
        if (v1 != nil) {
            return v1 != v2
        }

        return v2 != nil
    }

}
