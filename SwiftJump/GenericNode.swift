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



class GenericNode : SKNode{
    
    func collisionWithPlayer(player : SKNode)->Bool{
        return false
    }
    
    func shouldRemoveNode(playerY : CGFloat){
        
        if playerY > self.position.y + 300 {
            self.removeFromParent()
        }
        
    }
    
}
