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
class Achievements: SKScene {
    
     var username : String!
    var tableView: UITableView  =   UITableView()
    var gameTableView : AchievementTableView!// = AchievementTableView()
    var achivment_names = [String]()
    
    
    override func didMove(to view: SKView) {
 
        self.fillTable()
 
        self.score_display()
        
    }
    
    func score_display () {
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
             let highscore  = value?["HighScore"] as? Int
            
            let high_score_node = self.childNode(withName: "highscore") as! SKLabelNode
            high_score_node.text = String(describing: highscore!)
            
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    func fillTable() {
    
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let dvalue = rest.value as? NSDictionary
                let score:Int! = dvalue!.value(forKey: "score") as? Int
                let done:Bool! = dvalue!.value(forKey: "done") as? Bool
                if (done==true){
                    self.achivment_names.append(rest.key + " Points : " + String(score) + " UnLocked !!! "   )
                }else{
                    self.achivment_names.append(rest.key + " Points : " + String(score) + " Locked "   )
                }
                
                /* for (key, value) in dvalue! {
                 print("Property: \"\(key as! String)\"")
                 print("Value: \"\(value as! AnyObject)\"")
                 }*/
                
            }
            self.gameTableView = AchievementTableView()
            self.gameTableView.setitems(i_items: self.achivment_names)
            self.gameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.gameTableView.frame=CGRect(x:20,y:65,width:380,height:250)
            self.gameTableView.reloadData()
            self.scene?.view?.addSubview(self.gameTableView)
            
            
            
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
            
            
            if node[0].name == "game_win" {
                
                
                if let scrname = self.userData?.value(forKey: "scrname")  {
                    if (scrname as! String == "GameStart") {
                        let scene = SKScene(fileNamed: "GameStartScene") as! GameStart
                        self.view?.presentScene(scene)
                        
                        
                    } else if (scrname as! String == "GameWin") {
                        let scene = SKScene(fileNamed: "GameWin") as! GameWin
                        self.view?.presentScene(scene)
                        
                        
                    }  else if (scrname as! String == "Preference") {
                        let prefScene = SKScene(fileNamed: "PreferenceScene") as! PreferenceScene
                        prefScene.userData = NSMutableDictionary()
                        prefScene.userData?.setObject("GameScene", forKey: "scrname"  as NSCopying)
                        self.view?.presentScene(prefScene)
                        
                        
                  }
                    gameTableView.removeFromSuperview()
                    
                    
                }
                
            }
        }
        
    }
    

    
}
class AchievementTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    var items = [String]()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    
    func setitems(i_items:[String]){
        self.items = i_items
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          return "*****************"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
