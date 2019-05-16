//
//  GameScene.swift
//  SwiftJump
//
//  Created by Boppo Technologies on 15/05/19.
//  Copyright © 2019 Boppo Technologies. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion


class GameScene: SKScene ,SKPhysicsContactDelegate{
    
    var background : SKNode!
    var midground  : SKNode!
    var foreground : SKNode!
    
    //hud to displaay all of necessary information to player
    var hud : SKNode!
    
    
    
    
    var player : SKNode!
    
    var scaleFactor : CGFloat!
    
    var startButton = SKSpriteNode(fileNamed: "TapToStart")
    
    var endOfGamePosition = 0
    
    let motionManager = CMMotionManager()
    
    var xAcceleration : CGFloat = 0.0
    
    var scorelabel : SKLabelNode!
    var flowerLabel : SKLabelNode!
    
    var playersMaxY:Int!
    
    var gameOver = false 
    
    
    override init(size : CGSize){
        super.init(size : size)
        
        backgroundColor = SKColor.white
        
        //scaleFactor = size of screen width / size of image width
        scaleFactor = self.size.width / 320
        
        let levelData = GameHandler.sharedInstance.levelData
        
        
        background = createBackground()
        
        addChild(background)
        
        midground = createMidground()
        addChild(midground)
        
        foreground = SKNode()
        addChild(foreground)
        
        player = createPlayer()
        foreground.addChild(player)
        
        let platform = createPlatformAtPosition(position: CGPoint(x: 160, y: 320), ofType: .normalBrick)
        foreground.addChild(platform)
        
        let flower =  createFlowerAtPosition(position: CGPoint(x: 160, y: 220), ofType: .SpecialFlower)
        foreground.addChild(flower)
        
        //speed of gravity
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        
        physicsWorld.contactDelegate = self
        
        motionManager.accelerometerUpdateInterval = 0.2
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            
            if let accelerometerData = data{
                    let acceleration = accelerometerData.acceleration
                
                    self.xAcceleration = (CGFloat(acceleration.x) * 0.75 + (self.xAcceleration * 0.25))
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Tells your app to peform any necessary logic after physics simulations are performed. for acceleration
    override func didSimulatePhysics() {
        
        player.physicsBody?.velocity = CGVector(dx: xAcceleration * 400, dy: player.physicsBody!.velocity.dy)
        
        if player.position.x < -20{
            player.position = CGPoint(x: self.size.width + 20, y: player.position.y)
        }
        else if(player.position.x > self.size.width + 20){
            player.position = CGPoint(x: -20, y: player.position.y)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var otherNode : SKNode!
        
        if contact.bodyA.node != player{
            otherNode = contact.bodyA.node
        }
        else{
            otherNode = contact.bodyB.node
        }
        
        
        (otherNode as! GenericNode).collisionWithPlayer(player: player)
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        player.physicsBody?.isDynamic = true
        
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
    }
    

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
