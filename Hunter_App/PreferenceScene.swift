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
    
    var fire_db = FireDB()
    var muteinitial: Bool = false


    override func didMove(to view: SKView) {
        let sound_label = self.childNode(withName: "sound") as? SKLabelNode
        
        if(!SharingManager.sharedInstance.muteinitial){
            sound_label?.text = "Sound On"
        }else{
            sound_label?.text = "Sound Muted"
            
        }
        let message_label = self.childNode(withName: "messagelabel") as? SKLabelNode
        
        if(!SharingManager.sharedInstance.message){
            message_label?.text = "Display Messages On"
        }else{
            message_label?.text = "Display Messages Off"
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let touch = touches.first
        
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            if node[0].name == "exitLabel" || node[0].name == "okLable" {
                if let scrname = self.userData?.value(forKey: "scrname")  {
                    if (scrname as! String == "GameStart") {
                        let scene = SKScene(fileNamed: "GameStartScene") as! GameStart
                        self.view?.presentScene(scene)
                        
                    }else if((scrname as! String == "GameWin")){
                        let scene = SKScene(fileNamed: "GameWin") as! GameWin
                        self.view?.presentScene(scene)
                    }else{
                        let scene = SKScene(fileNamed: "GameScene") as! GameScene
                        self.view?.presentScene(scene)
                        
                    }
                }
            }else if node[0].name == "reset" {
                show_reset_alert()
                
            }else if node[0].name == "mute" {
                
                show_sound_alert()

                
            }else if node[0].name == "achivment" {
                let prefScene = SKScene(fileNamed: "Acheivement") as! Achievements
                prefScene.userData = NSMutableDictionary()
                prefScene.userData?.setObject("Preference", forKey: "scrname"  as NSCopying)
                self.view?.presentScene(prefScene)
                
                
            }  else if node[0].name == "message" {
                show_message_alert()
           }
        
        }
    }

    

    func show_reset_alert() {
         let alert = UIAlertController(title: "Reset Acheivement", message: "You are going reset your hard earned achievments, but we know sometimes in life you have to start new", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Reset", style: UIAlertActionStyle.default)  { _ in
            self.fire_db.reset_acheivement()

         })
        alert.addAction(UIAlertAction(title: "Skip", style: UIAlertActionStyle.default)  { _ in
            
            
        })
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    func show_message_alert() {
        let message_label = self.childNode(withName: "messagelabel") as? SKLabelNode

        if(!SharingManager.sharedInstance.message){
            let alert = UIAlertController(title: "Supress Messages", message: "Game Messages will be turned off", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)  { _ in
                SharingManager.sharedInstance.message=true
                message_label?.text = "Display Messages Off"

            })
            alert.addAction(UIAlertAction(title: "Skip", style: UIAlertActionStyle.default)  { _ in
                
                
            })
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Supress Messages", message: "Game Messages  will be turned ON", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)  { _ in
                SharingManager.sharedInstance.message=false
                message_label?.text = "Display Messages ON"

                
            })
            alert.addAction(UIAlertAction(title: "Skip", style: UIAlertActionStyle.default)  { _ in
                
                
            })
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
       
    }
    
    
    func show_sound_alert() {
        
       let sound_label = self.childNode(withName: "sound") as? SKLabelNode

        if(!SharingManager.sharedInstance.muteinitial){
            let alert = UIAlertController(title: "Sound Control", message: "Game Sounds will be Muted", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)  { _ in
                SharingManager.sharedInstance.muteinitial=true
                sound_label?.text = "Sound Muted"
                
            })
            alert.addAction(UIAlertAction(title: "Skip", style: UIAlertActionStyle.default)  { _ in
                
                
            })
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Sound Control", message: "Game Sounds  will be turned ON", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)  { _ in
                SharingManager.sharedInstance.muteinitial=false
                sound_label?.text = "Sound On"

                
            })
            alert.addAction(UIAlertAction(title: "Skip", style: UIAlertActionStyle.default)  { _ in
                
                
            })
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func muteunmute() {
        
  
        if SharingManager.sharedInstance.muteinitial {
            //This runs if the user wants music
            print("The button will now turn on music.")
            muteinitial = false
            SharingManager.sharedInstance.muteinitial=false

          //  unmute_node?.alpha = 0
          //  mute_node?.alpha = 1
 
             //  backgroundMusic.run(self.backgroundMusic)
        } else {
            //This happens when the user doesn't want music
            print("the button will now turn off music.")
            muteinitial = true
            print(SharingManager.sharedInstance.muteinitial)
            SharingManager.sharedInstance.muteinitial=true
          //  mute_node?.alpha = 0
          //  unmute_node?.alpha = 1
 
            

            // backgroundMusic.
        }
        
    }
    
    
}
