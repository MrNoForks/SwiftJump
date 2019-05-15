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


class GameScene: SKScene {
    
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
        
        background = createBackground()
        
        
        addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
