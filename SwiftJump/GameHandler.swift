//
//  GameHandler.swift
//  SwiftJump
//
//  Created by Boppo Technologies on 16/05/19.
//  Copyright © 2019 Boppo Technologies. All rights reserved.
//

import Foundation

class GameHandler {
    
    var score : Int
    
    var highScore : Int
    
    var flowers : Int
    
    var levelData : NSDictionary!
    
    class var sharedInstance : GameHandler{
        struct Singleton{
            static let instance = GameHandler()
        }
        
        return Singleton.instance
    }
    
    init(){
        
        score = 0
        highScore = 0
        flowers = 0
        
        // MARK:- User Defaults
        let userDefaults = UserDefaults.standard
        
        highScore = userDefaults.integer(forKey: "highScore")
        
        flowers = userDefaults.integer(forKey: "flowers")
        
        //Mark:-  Extracting data fromn Plist
        if let path = Bundle.main.path(forResource: "Level01", ofType: "plist"){
            
            if let level = NSDictionary(contentsOfFile: "path"){
                levelData = level
            }
        }
    }
    
    func saveGameState(){
        
        highScore = max(score,highScore)
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(highScore, forKey: "highScore")
        
        userDefaults.set(flowers, forKey: "flowers")
    }
}
