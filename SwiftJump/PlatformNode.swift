//
//  PlatformNode.swift
//  SwiftJump
//
//  Created by Boppo Technologies on 15/05/19.
//  Copyright © 2019 Boppo Technologies. All rights reserved.
//

import SpriteKit

enum PlatformType : Int{
    
    case normalBrick = 0
    
    case breakableBrick = 1
}

class PlatformNode: GenericNode {

    var platformType : PlatformType!
    
}