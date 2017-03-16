//
//  GameOver.swift
//  Hunter_App
//
//  Created by Peter on 2/24/17.
//  Copyright © 2017 peter. All rights reserved.
//

import UIKit
import SpriteKit

class GameOver: SKScene {
    
    
    override func didMove(to view: SKView) {
        var labelNode: SKLabelNode!
        
        labelNode = self.childNode(withName: "game_over") as! SKLabelNode!

        if let scrname = self.userData?.value(forKey: "scrname")  {
            if (scrname as! String == "timer") {
               
                 labelNode.text = "Game over: Timer Elapsed  35 Seconds";
                
                
            }else{
                
                 labelNode.text = "Game over: Oh No!! You Hit Poision Bush";

                
                
            }

      }
    }
    

     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
            if node[0].name == "overnewLabel" {
                let overnewgame = SKScene(fileNamed: "GameScene") as! GameScene
                self.view?.presentScene(overnewgame)
        }
    }

    
 }

}
