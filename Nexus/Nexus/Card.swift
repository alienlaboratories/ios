//
//  Card.swift
//  Nexus
//
//  Created by Rich Burdon on 4/9/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import Foundation
import SpriteKit

// http://www.raywenderlich.com/76718/card-game-mechanics-sprite-kit-swift

class Card : SKSpriteNode {
    
    required init(coder aDecoder: NSCoder!) {
        fatalError("NSCoding not supported")
    }

    init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: nil, size: texture.size())
    }
}
