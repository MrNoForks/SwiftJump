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
        
        let levelData = GameHandler.sharedInstance.levelData!
        
        
        background = createBackground()
        
        addChild(background)
        
        midground = createMidground()
        addChild(midground)
        
        foreground = SKNode()
        addChild(foreground)
        
        player = createPlayer()
        foreground.addChild(player)
        
        //MARK:- Extracting data from NSDictionary of plist that was in GameHandler
        //Dictionary
        let platforms = levelData["Platforms"] as! NSDictionary
        //Dictionary
        let platformPatterns = platforms["Patterns"] as! NSDictionary
        //Array which contains dictionary so [NSDictionary]
        let platformPositions = platforms["Positions"] as! [NSDictionary]
        
        //iterating through array of Positions
        for platformPosition in platformPositions{
            
            // element["x"] of array which is number
            let x = platformPosition["x"] as! Float
            
            // element["y"] of array which is number
            let y = platformPosition["y"] as! Float
            
            // element["pattern"] of array which is String
            let pattern = platformPosition["pattern"] as! String
            
            
            // getting  Pattern["String"] i.e. value through key  e.g. Pattern["Single"]
            let platformPattern = platformPatterns[pattern] as! [NSDictionary]
            
            // Iterating Pattern["String"] array
            for platformPoint in platformPattern{
                
                // element["x"] of array which is number
                let xValue = platformPoint["x"] as! Float
                
                // element["y"] of array which is number
                let yValue = platformPoint["y"] as! Float
                
                // element["type"] of array which is number
                let type = PlatformType(rawValue: platformPoint["type"] as! Int)
                
                let xPosition = CGFloat(xValue + x)
                
                let yPosition = CGFloat(yValue + y)
                
                let platformNode = createPlatformAtPosition(position: CGPoint(x:xPosition,y:yPosition), ofType: type!)
                foreground.addChild(platformNode)
                
                
            }
            
        }
        
        //Dictionary
        let flower = levelData["Flowers"] as! NSDictionary
        //Dictionary
        let flowerPatterns = flower["Patterns"] as! NSDictionary
        //Array which contains dictionary so [NSDictionary]
        let flowerPositions = flower["Positions"] as! [NSDictionary]
        
        //iterating through array of Positions
        for flowerPosition in flowerPositions{
            
            // element["x"] of array which is number
            let x = flowerPosition["x"] as! Float
            
            // element["y"] of array which is number
            let y = flowerPosition["y"] as! Float
            
            // element["pattern"] of array which is String
            let pattern = flowerPosition["pattern"] as! String
            
            
            // getting  Pattern["String"] i.e. value through key  e.g. Pattern["Single"]
            let flowerPattern = flowerPatterns[pattern] as! [NSDictionary]
            
            // Iterating Pattern["String"] array
            for flowerPoint in flowerPattern{
                
                // element["x"] of array which is number
                let xValue = flowerPoint["x"] as! Float
                
                // element["y"] of array which is number
                let yValue = flowerPoint["y"] as! Float
                
                // element["type"] of array which is number
                let type = FlowerType(rawValue: flowerPoint["type"] as! Int)
                
                let xPosition = CGFloat(xValue + x)
                
                let yPosition = CGFloat(yValue + y)
                
                let flowerNode = createFlowerAtPosition(position: CGPoint(x: xPosition, y: yPosition), ofType: type!)
                foreground.addChild(flowerNode)
                
                
            }
            
        }
        
        
//        let platform = createPlatformAtPosition(position: CGPoint(x: 160, y: 320), ofType: .normalBrick)
//        foreground.addChild(platform)
        
//        let flower =  createFlowerAtPosition(position: CGPoint(x: 160, y: 220), ofType: .SpecialFlower)
//        foreground.addChild(flower)
        
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
