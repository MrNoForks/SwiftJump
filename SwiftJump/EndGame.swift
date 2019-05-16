//
//  EndGame.swift
//  SwiftJump
//
//  Created by Boppo Technologies on 16/05/19.
//  Copyright © 2019 Boppo Technologies. All rights reserved.
//

import SpriteKit

class EndGame : SKScene{
   override init(size : CGSize){
        super.init(size: size)
    
    let flower = SKSpriteNode(imageNamed: "flower")
    
    flower.position = CGPoint(x: 25, y: self.size.height - 30)
    
    addChild(flower)
    
    
    let flowerLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    flowerLabel.fontSize = 30
    flowerLabel.fontColor = SKColor.white
    flowerLabel.position = CGPoint(x: 50, y: self.size.height-40)
    flowerLabel.horizontalAlignmentMode = .left
    flowerLabel.text = " \(GameHandler.sharedInstance.flowers)"
    addChild(flowerLabel)
    
    
    let scorelabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    scorelabel.fontSize = 30
    scorelabel.fontColor = SKColor.white
    scorelabel.position = CGPoint(x: self.size.width/2, y: 300)
    scorelabel.horizontalAlignmentMode = .center
    scorelabel.text = "\(GameHandler.sharedInstance.score)"
    addChild(scorelabel)
    
    let highScorelabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    highScorelabel.fontSize = 30
    highScorelabel.fontColor = SKColor.red
    highScorelabel.position = CGPoint(x: self.size.width/2, y: 450)
    highScorelabel.horizontalAlignmentMode = .center
    highScorelabel.text = "\(GameHandler.sharedInstance.highScore)"
    addChild(highScorelabel)
    
    let tryAgainLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    tryAgainLabel.fontSize = 30
    tryAgainLabel.fontColor = SKColor.white
    tryAgainLabel.position = CGPoint(x: self.size.width/2, y: 50)
    tryAgainLabel.horizontalAlignmentMode = .center
    tryAgainLabel.text = "Tap to Play Again"
    addChild(tryAgainLabel)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameScene = GameScene(size: size)
        self.view?.presentScene(gameScene,transition: transition)
    }
}
