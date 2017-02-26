//
//  PreferenceScene.swift
//  Hunter_App
//
//  Created by Peter on 2/23/17.
//  Copyright © 2017 peter. All rights reserved.
//

import UIKit
import SpriteKit

class PreferenceScene: SKScene {
    
    

    override func didMove(to view: SKView) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
         
        let touch = touches.first
     
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
            if node[0].name == "exitLabel" {
                if let scrname = self.userData?.value(forKey: "scrname")  {
                    if (scrname as! String == "GameStart") {
                        let scene = SKScene(fileNamed: "GameStartScene") as! GameStart
                        self.view?.presentScene(scene)

                        
                    }else{
                        let scene = SKScene(fileNamed: "GameScene") as! GameScene
                        self.view?.presentScene(scene)

                        
                    }

                    
                }
              
                
              //  if let scene = SKScene(fileNamed: "GameStartScene") {
                
                


                
              
            }
        
                  }
    }
    
    
}
