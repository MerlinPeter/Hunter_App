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
class LeaderBoard: SKScene {
    
    var score : Int=0;
    var username : String!
    var tableView: UITableView  =   UITableView()
    var gameTableView = GameRoomTableView()
    var leader_names = [String]()

    override func didMove(to view: SKView) {
 
         fillTable()
 
    }
    
    func fillTable() {
        
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("game_score").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let dvalue = rest.value as? NSDictionary
                let score:Int! = dvalue!.value(forKey: "HighScore") as? Int
                let Player:String! = dvalue!.value(forKey: "Player") as? String
                     self.leader_names.append( Player + " Points : " + String(score)   )
                    
                //TBD -sort it
                
            }
            self.gameTableView = GameRoomTableView()
            self.gameTableView.setitems(i_items: self.leader_names)
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
                
                gameTableView.removeFromSuperview()
                let playButton = SKScene(fileNamed: "GameWin") as! GameWin
                
                self.view?.presentScene(playButton)

                
            }
            
        }
    }
    
    

    
}
class GameRoomTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
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
