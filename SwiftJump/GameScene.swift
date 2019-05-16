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
    
    var startButton = SKSpriteNode(imageNamed: "TapToStart")
    
    var endOfGamePosition = 0
    
    let motionManager = CMMotionManager()
    
    var xAcceleration : CGFloat = 0.0
    
    var scorelabel : SKLabelNode!
    var flowerLabel : SKLabelNode!
    
    var playersMaxY:Int!
    
    var gameOver = false 
    
    
    
    var currentMaxY : Int!
    
    override init(size : CGSize){
        super.init(size : size)
        
        backgroundColor = SKColor.white
        
        //scaleFactor = size of screen width / size of image width
        scaleFactor = self.size.width / 320
        
        let levelData = GameHandler.sharedInstance.levelData!
        
        currentMaxY = 80
        GameHandler.sharedInstance.score = 0
        gameOver = false
        
        endOfGamePosition = levelData["EndOfLevel"] as! Int

        
        background = createBackground()
        
        addChild(background)
        
        midground = createMidground()
        addChild(midground)
        
        foreground = SKNode()
        addChild(foreground)
        
        player = createPlayer()
        foreground.addChild(player)
        
        hud = SKNode()
        
        addChild(hud)
        
        startButton.position = CGPoint(x: self.size.width/2, y: 180)
        
        hud.addChild(startButton)
        
        
        
        let flower = SKSpriteNode(imageNamed: "flower")
        
        flower.position = CGPoint(x: 25, y: self.size.height - 30)
        
        hud.addChild(flower)
        
        
        flowerLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        flowerLabel.fontSize = 30
        flowerLabel.fontColor = SKColor.white
        flowerLabel.position = CGPoint(x: 50, y: self.size.height-40)
        flowerLabel.horizontalAlignmentMode = .left
        
        flowerLabel.text = " \(GameHandler.sharedInstance.flowers)"
        hud.addChild(flowerLabel)
        
        
        scorelabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        scorelabel.fontSize = 30
        scorelabel.fontColor = SKColor.white
        scorelabel.position = CGPoint(x: self.size.width-20, y: self.size.height-40)
        scorelabel.horizontalAlignmentMode = .right
        
        scorelabel.text = "0"
        hud.addChild(scorelabel)
        
        
        
        
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
        let flowers = levelData["Flowers"] as! NSDictionary
        //Dictionary
        let flowerPatterns = flowers["Patterns"] as! NSDictionary
        //Array which contains dictionary so [NSDictionary]
        let flowerPositions = flowers["Positions"] as! [NSDictionary]
        
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
        
        var updateHUD = false
        
        var otherNode : SKNode!
        
        if contact.bodyA.node != player{
            otherNode = contact.bodyA.node
        }
        else{
            otherNode = contact.bodyB.node
        }
        
        updateHUD = (otherNode as! GenericNode).collisionWithPlayer(player: player)
        
        if updateHUD{
            flowerLabel.text = " \(GameHandler.sharedInstance.flowers)"
            scorelabel.text = "\(GameHandler.sharedInstance.score)"
        }
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if player.physicsBody!.isDynamic{return}
        
        startButton.removeFromParent()
        
        player.physicsBody?.isDynamic = true
        
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
    }
    

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        foreground.enumerateChildNodes(withName: "PLATFORMNODE") { (node, stop) in
            
            let platform = node as! PlatformNode
            
            platform.shouldRemoveNode(playerY: self.player.position.y)
        }
        
        foreground.enumerateChildNodes(withName: "FLOWERNODE") { (node, stop) in
            
            let flower = node as! FlowerNode
            
            flower.shouldRemoveNode(playerY: self.player.position.y)
        }
        
        
        if player.position.y > 200{
            // Different divides for parallel effect so all layers move in different speed
            background.position = CGPoint(x: 0, y: -(player.position.y - 200)/10)
            midground.position = CGPoint(x: 0, y: -(player.position.y - 200)/4)
            foreground.position = CGPoint(x: 0, y: -(player.position.y - 200))
        }
        
        if Int(player.position.y) > currentMaxY {
            GameHandler.sharedInstance.score += Int(player.position.y) - currentMaxY
            currentMaxY = Int(player.position.y)
            
            scorelabel.text = "\(GameHandler.sharedInstance.score)"
        }
        
        if Int(player.position.y) > endOfGamePosition{
            endGame()
        }
        
        if Int(player.position.y) < currentMaxY - 800 {
            endGame()
        }
        
        
    }
    
    func endGame(){
        gameOver = true
        GameHandler.sharedInstance.saveGameStats()
        
        let transtion = SKTransition.fade(withDuration: 0.5)
        let endGameScene = EndGame(size : self.size)
        
        self.view?.presentScene(endGameScene,transition: transtion)
        
    }
}
