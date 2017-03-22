//
//  GameStart.swift
//  Hunter_App
//
//  Created by Peter on 2/23/17.
//  Copyright © 2017 peter. All rights reserved.
//

import UIKit
import SpriteKit


class GameStart: SKScene {
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let view = self.view as! SKView? {
             if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
        }

        
    }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
            if node[0].name == "startLabel" {
             //   let transition = SKTransition.flipHorizontal(withDuration: 0.5)
              //  let gameScene = GameScene(size: self.size)
                //self.view!.presentScene(gameScene)
                let gameStart = SKScene(fileNamed: "GameScene") as! GameScene
           
                self.view?.presentScene(gameStart)
            }
            
            if node[0].name == "preferLabel" {
                let prefScene = SKScene(fileNamed: "PreferenceScene") as! PreferenceScene
                prefScene.userData = NSMutableDictionary()
                prefScene.userData?.setObject("GameStart", forKey: "scrname"  as NSCopying)
                self.view?.presentScene(prefScene)
                
                
             }
            
            if node[0].name == "achivment" {
                let prefScene = SKScene(fileNamed: "Acheivement") as! Achievements
                prefScene.userData = NSMutableDictionary()
                prefScene.userData?.setObject("GameStart", forKey: "scrname"  as NSCopying)
                self.view?.presentScene(prefScene)
                
                
            }
        }
    }
 
 
}
