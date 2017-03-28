//
//  GameWin.swift
//  Hunter_App
//
//  Created by Peter on 2/26/17.
//  Copyright © 2017 peter. All rights reserved.
//

import UIKit
import SpriteKit
import FirebaseDatabase
class GameWin: SKScene {

    var score : Int=0;
    var username : String!
    var tableView: UITableView  =   UITableView()
    var items: [String] = ["Viper", "X", "Games"]
    var gameTableView = GameRoomTableView()

    override func didMove(to view: SKView) {
        
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
              let username = value?["Player"] as? String ?? ""
             let score  = value?["Score"] as? Int
             let highscore  = value?["HighScore"] as? Int
            
            let high_score_node = self.childNode(withName: "highscore") as! SKLabelNode
            high_score_node.text = String(describing: highscore!)
            let score_node = self.childNode(withName: "score") as! SKLabelNode
            score_node.text = String(describing: score!)
            
            
        
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)

        let touch = touches.first
        
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
            if node[0].name == "playback" {
                let playButton = SKScene(fileNamed: "GameScene") as! GameScene
                
                self.view?.presentScene(playButton)
            }
            if node[0].name == "leader_board" {
                let playButton = SKScene(fileNamed: "LeaderBord") as! LeaderBoard
                
                self.view?.presentScene(playButton)
                
                
            }
            if node[0].name == "acheivement" {
                //let playButton = SKScene(fileNamed: "Acheivement") as! Achievements
                
                //self.view?.presentScene(playButton)
                let prefScene = SKScene(fileNamed: "Acheivement") as! Achievements
                prefScene.userData = NSMutableDictionary()
                prefScene.userData?.setObject("GameWin", forKey: "scrname"  as NSCopying)
                self.view?.presentScene(prefScene)
                
                
                
            }
            if node[0].name == "options" {
                let prefScene = SKScene(fileNamed: "PreferenceScene") as! PreferenceScene
                prefScene.userData = NSMutableDictionary()
                prefScene.userData?.setObject("GameWin", forKey: "scrname"  as NSCopying)
                self.view?.presentScene(prefScene)

                
                
                
            }
            
        }
    }
    
            
}
