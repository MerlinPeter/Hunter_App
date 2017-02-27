//
//  GameWin.swift
//  Hunter_App
//
//  Created by Peter on 2/26/17.
//  Copyright © 2017 peter. All rights reserved.
//

import UIKit
import SpriteKit

class GameWin: SKScene {

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let touch = touches.first
        
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
            if node[0].name == "playSprite" {
            let playButton = SKScene(fileNamed: "GameScene") as! GameScene
                
                self.view?.presentScene(playButton)
            }
           
        }
    }
    
    
            
}
