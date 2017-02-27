//
//  GameScene.swift
//  Hunter_App
//
//  Created by Peter on 2/23/17.
//  Copyright © 2017 peter. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            if node[0].name == "gamepreferLabel" {
                let prefScene = SKScene(fileNamed: "PreferenceScene") as! PreferenceScene
                prefScene.userData = NSMutableDictionary()
                prefScene.userData?.setObject("GameScene", forKey: "scrname"  as NSCopying)
                self.view?.presentScene(prefScene)
            }
            

        if node[0].name == "gameoverLabel" {
            let gameoverLabel = SKScene(fileNamed: "GameOver") as! GameOver
            
            self.view?.presentScene(gameoverLabel)
        }
 
            
            if node[0].name == "tickSprite" {
                let gamewin = SKScene(fileNamed: "GameWin") as! GameWin
                
                self.view?.presentScene(gamewin)
            }

        }
        
    }
    
    
    
    }
