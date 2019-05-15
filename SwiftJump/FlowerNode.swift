//
//  FlowerNode.swift
//  SwiftJump
//
//  Created by Boppo Technologies on 15/05/19.
//  Copyright © 2019 Boppo Technologies. All rights reserved.
//

import SpriteKit

enum FlowerType : Int{
    
    case NormalFlower = 0
    
    case SpecialFlower = 1
}


class FlowerNode : GenericNode{
    
    var flowerType : FlowerType!
    
}
