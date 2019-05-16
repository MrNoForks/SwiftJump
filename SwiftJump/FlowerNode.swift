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
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        
        //Boosting player  up by 400
        player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400)
        
        GameHandler.sharedInstance.score += (flowerType == FlowerType.NormalFlower ? 20 : 100)
        GameHandler.sharedInstance.flowers += (flowerType == FlowerType.NormalFlower ? 1 : 5)
        
        //removing flower 
        self.removeFromParent()
        
        return true
    }
    
}
