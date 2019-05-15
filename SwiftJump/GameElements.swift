//
//  GameElements.swift
//  SwiftJump
//
//  Created by Boppo Technologies on 15/05/19.
//  Copyright © 2019 Boppo Technologies. All rights reserved.
//

import SpriteKit

extension GameScene{
    
    func createBackground() -> SKNode{
        
        let backgroundNode = SKNode()
        //node height = (image height)64 pixels so 64 * scaleFactor
        let spacing : CGFloat = 64 * scaleFactor
        
        //Mark:- Format type and Custom String using format
        for index in 0...19 {
            let node = SKSpriteNode(imageNamed: String(format: "Background%02d", index+1))
            
            node.setScale(scaleFactor)
            
            node.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            node.position = CGPoint(x: self.size.width/2, y: spacing * CGFloat(index))
            
            backgroundNode.addChild(node)
        }
        
        return backgroundNode
    }
    
    
}
