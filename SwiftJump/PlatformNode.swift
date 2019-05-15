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
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        
        if player.physicsBody!.velocity.dy < 0{
            
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 250)
            
            if platformType == PlatformType.breakableBrick{
                self.removeFromParent()
            }
        }
        
        return false
    }
    
}
