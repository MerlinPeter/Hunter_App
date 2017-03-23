//
//  GameViewController.swift
//  Hunter_App
//
//  Created by Peter on 2/23/17.
//  Copyright © 2017 peter. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
//import AVFoundation

class GameViewController: UIViewController {
    
    //var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("this is working")
        
        //music
       /* do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample(1)", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }*/
        
        
       if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'

 
               if let scene = SKScene(fileNamed: "GameScene") {
                 // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            //view.showsPhysics = true
            

        }
    
        
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
