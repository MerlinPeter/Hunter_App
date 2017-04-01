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
class FireDB {
    
    var  databaseRef : AnyObject
    var achivment_names = [String]()
    var reset_score :Int
    var score:Int

    
     init() {
     databaseRef = FIRDatabase.database().reference()
     reset_score = 0
     score=0
    }

    
    func fillTable() {
        
        
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
 //Game Table integration
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    func high_score() -> Int {
        return 100
    }
    
    
    func update_achievment(input_achivment:String)  {
        
        let disablefirebase = true //on off switch
        
        if (disablefirebase)
        {
            
            
            switch input_achivment {
            case "holejumper":
                let prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").child("holejumper")
                prntRef.updateChildValues(["done":true])
            case "bunnycatcher" :
                let prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").child("bunnycatcher")
                prntRef.updateChildValues(["done":true])
            case "speedhero":
                let prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").child("speedhero")
                prntRef.updateChildValues(["done":true])
            case "poisonfree":
                let prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").child("poisonfree")
                prntRef.updateChildValues(["done":true])
            case "score"://updated current score and update high score if needed
                let prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml")
                prntRef.updateChildValues(["Score":score])
                databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    
                    var HScore  = value?["HighScore"] as? Int
                    
                    if self.score > HScore! {
                        
                        HScore = self.score
                        prntRef.updateChildValues(["HighScore" : HScore!])
                        
                    }
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
            default :
                print("TBD")
                
            }
        }else{
            
            print("Firebase Not used")
            
        }
        
    }

    func reset_acheivement(){
        
         
        var prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").child("holejumper")
        prntRef.updateChildValues(["done":false])
            prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").child("bunnycatcher")
        prntRef.updateChildValues(["done":false])
           prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").child("speedhero")
        prntRef.updateChildValues(["done":false])
        prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").child("poisonfree")
        prntRef.updateChildValues(["done":false])
        prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").child("achieve").child("netcracker")
        prntRef.updateChildValues(["done":false])
        prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml")
        prntRef.updateChildValues(["Score":reset_score])
        prntRef  = databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml")
        prntRef.updateChildValues(["HighScore":reset_score])
        
    }
    
    
    
    
}

