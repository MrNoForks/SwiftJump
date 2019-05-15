//
//  GameElements.swift
//  SwiftJump
//
//  Created by Boppo Technologies on 15/05/19.
//  Copyright © 2019 Boppo Technologies. All rights reserved.
//

//what is anchor point
//https://developer.apple.com/documentation/spritekit/skspritenode/using_the_anchor_point_to_move_a_sprite
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
    
    func createMidground() -> SKNode{
        
        let midgroundNode = SKNode()
        
        var anchor : CGPoint!
        
        var xPos : CGFloat!
        
        
        
        for index in 0 ... 19 {
            
            var name : String!
            
            let randomNumber = arc4random() % 2
            
            if randomNumber > 0 {
                
                name = "cloudLeft"
                
                anchor = CGPoint(x: 0, y: 0.5)
                
                xPos = 0
            }
            else{
                
                name = "cloudRight"
                
                anchor = CGPoint(x: 1, y: 0.5)
                
                xPos = self.size.width
                
            }
            
            let cloudNode = SKSpriteNode(imageNamed: name)
            
            cloudNode.anchorPoint = anchor
            
            cloudNode.position = CGPoint(x: xPos, y: 500 * CGFloat(index))
            
            midgroundNode.addChild(cloudNode)
        }
        return midgroundNode
    }
    
    
    func createPlayer() -> SKNode{
        
        let playerNode = SKNode()
        
        playerNode.position = CGPoint(x: self.size.width / 2, y: 80)
        
        
        
        let sprite = SKSpriteNode(imageNamed: "Player")
        
        playerNode.addChild(sprite)
        
        // Adding Physics
        
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        
        //affected by gravity so we are setting it to dynamic
        playerNode.physicsBody?.isDynamic =  true
        
        // disabling rotation caused by physic
        playerNode.physicsBody?.allowsRotation = false
        
        // for letting node not lose its momentum
        playerNode.physicsBody?.restitution = 1
        
        playerNode.physicsBody?.friction = 0
        playerNode.physicsBody?.angularDamping = 0
        playerNode.physicsBody?.linearDamping = 0
        
        playerNode.physicsBody?.usesPreciseCollisionDetection = true
        
        playerNode.physicsBody?.categoryBitMask = CollisionBitMask.Player
        
        //This says spriteKit we dont want to simulate any collision for the player
        playerNode.physicsBody?.collisionBitMask = 0
        
        playerNode.physicsBody?.contactTestBitMask = CollisionBitMask.Flower | CollisionBitMask.Brick
        
        return playerNode
    }
    
    func createPlatformAtPosition(position : CGPoint , ofType type : PlatformType ) -> PlatformNode{
       
        let node = PlatformNode()
        
        node.position = CGPoint(x: position.x * scaleFactor, y: position.y )
        
        node.position = position
        
        node.name = "PLATFORMNODE"
        
        node.platformType = type
        
        
        
        
        var sprite : SKSpriteNode
        
        if type == .normalBrick{
            sprite = SKSpriteNode(imageNamed: "Platform")
        }
        else{
            sprite = SKSpriteNode(imageNamed: "PlatformBreak")
        }
        
        node.addChild(sprite)
        
        
        
        //Physics
        node.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionBitMask.Brick
        
        node.physicsBody?.categoryBitMask = 0
        
        return node
    }
}

