//
//  GenericNode.swift
//  SwiftJump
//
//  Created by Boppo Technologies on 15/05/19.
//  Copyright © 2019 Boppo Technologies. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    
    static let Player : UInt32 = 0x00
    static let Flower : UInt32 = 0x01
    static let Brick : UInt32  = 0x02
    
}

enum PlatformType : Int{
    
    case normalBrick = 0
    
    case breakableBrick = 1
}


class GenericNode : SKNode{
    
}
