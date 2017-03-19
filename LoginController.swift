//
//  LoginController.swift
//  Hunter_App
//
//  Created by Peter on 3/14/17.
//  Copyright © 2017 peter. All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase

class LoginController: UIViewController {
    
    @IBOutlet var Email: UITextField!
    
    @IBOutlet var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    print(" login controller")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateAccount(_ sender: Any) {
       
        
                
        //var post : [String  : AnyObject] = [ "Player" : player as AnyObject , "Score" : score as AnyObject]
        
             // databaseRef.child("game_score").childByAutoId().setValue(post)
        
       
        
        /*databaseRef.child("game_score").child("-KfKxh3vPVJ82oX5_iml").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
           
            let username = value?["Player"] as? String ?? ""
            let Score  = value?["Score"] as? Int
            print(username,Score!)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }*/
        /*FIRAuth.auth()?.createUser(withEmail: Email.text!, password: Password.text!, completion: {
            user,Error in
            
            if Error != nil {
                
               self.login()
            }
            else{
                print("User Created")
                self.login()
            }
            
        })*/
        
    }
    
    func login(){
        FIRAuth.auth()?.signIn(withEmail: Email.text!, password: Password.text!, completion: {
        user, Error in
            
            if Error != nil{
                print("Incorrect")
                
            }
            else{
                print("AHHAAA")
            }
        
        })
        
    }



}

