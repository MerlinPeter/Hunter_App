//
//  GameScene.swift
//  Hunter_App
//
//  Created by Peter on 2/23/17.
//  Copyright © 2017 peter. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion;

class GameScene: SKScene {

    //let  manager  = CMMotionManager()
    var motionManager: CMMotionManager!
    var lastTouchPosition: CGPoint?

    var textureatlas = SKTextureAtlas()
    var texturearray = [SKTexture]()
    
    let ground = SKSpriteNode()
    //this is our actor
    var walkingfox = SKSpriteNode()
    
    let Player = SKSpriteNode(imageNamed: "Fox.png" )
    let mycamera : SKCameraNode = SKCameraNode()
    let bgImage = SKSpriteNode(imageNamed: "background.png")
    let bgImage1 = SKSpriteNode(imageNamed: "background.png")

    let bgImage2 = SKSpriteNode(imageNamed: "background.png")

    var touching: Bool = false

    override func didMove(to view: SKView) {
        
    // code to load images
        
        textureatlas = SKTextureAtlas(named: "foxwalk")
        
        for i  in 0...(textureatlas.textureNames.count-1){
            
            let filename = "fox_\(i).png"
            texturearray.append(SKTexture(imageNamed: filename))
            
        }
        
        walkingfox = SKSpriteNode(imageNamed: textureatlas.textureNames[0] )
        walkingfox.position=CGPoint(x:(self.size.width/2 ) , y:self.size.height/5)
        walkingfox.physicsBody=SKPhysicsBody(circleOfRadius: walkingfox.size.width/2)
        walkingfox.setScale( 2.0)
        walkingfox.physicsBody!.allowsRotation = false
        walkingfox.physicsBody!.linearDamping = 0.5
        
        self.addChild(walkingfox)
        
        
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
       self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)

        bgImage.position = CGPoint(x:0,y: self.size.height/2)
        // 1
        let borderBody = SKPhysicsBody(edgeLoopFrom : CGRect(x: -(1024), y: 0, width: 1024 * 3, height: 768))
        // 2
       borderBody.friction = 1
        // 3
       self.physicsBody = borderBody
        
        bgImage.zPosition = 0
        
        //self.addChild(bgImage)
        
        bgImage1.position = CGPoint(x:bgImage1.size.width,y: self.size.height/2)
        
        bgImage1.zPosition = 0
        
     //   self.addChild(bgImage1)
        
        bgImage2.position = CGPoint(x:-bgImage1.size.width,y: self.size.height/2)
        
        bgImage2.zPosition = 0
        
       // self.addChild(bgImage2)
        
        self.name = "Ground";

     
        Player.position = CGPoint(x:self.size.width * 9, y:self.size.height/5)
       
        Player.physicsBody = SKPhysicsBody(circleOfRadius: Player.size.width/2)
        Player.zPosition = 1
        
      // self.addChild(Player)
        
       self.addChild(mycamera)
        
       self.camera=mycamera
        
        mycamera.position = CGPoint(x:self.size.width/2, y:self.size.height/2)
        
        Player.physicsBody?.isDynamic = true
  
       createGround()
        //createRoof()
        
    

        
   
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
 //      walkingfox.position.x = walkingfox.position.x - 5
        
        mycamera.position.x = walkingfox.position.x
 
        
      // moveGrounds()
             #if (arch(i386) || arch(x86_64))
                if let currentTouch = lastTouchPosition {
                    let diff = CGPoint(x: currentTouch.x - walkingfox.position.x, y: currentTouch.y - walkingfox.position.y)
                    physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
                }
            #else
                if let accelerometerData = motionManager.accelerometerData {
                    physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
                }
            #endif
        
        
        //jump
        
    
        
        
        
        }
    
  
    
    func createGround(){
    
       
        for i in 0...10
        {
            let ground = SKSpriteNode(imageNamed: "groundtile.png")
            ground.name = "Ground"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: 50)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.isDynamic=false
            
           ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: 0)
            
            self.addChild(ground)
            print("ground created"  , CGFloat(i) * ground.size.width )
            
            
        }
    }
    func createRoof(){
        
        
      /*  for i in 0...10
        {
            let ground = SKSpriteNode(imageNamed: "groundtile.png")
            ground.name = "Ground"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: 50)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.isDynamic=false
            
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width + self.size.height, y: 0)
            
            self.addChild(ground)
            print("ground created"  , CGFloat(i) * ground.size.width )
            
            
        }*/
    }
    
    func moveGrounds(){
        
        self.enumerateChildNodes(withName: "Ground", using:({
            (node, error) in
            
            node.position.x-=2
        
            if node.position.x < (-(self.scene?.size.width)!)
            {
                
                node.position.x += (self.scene?.size.width)! * 3
                
            }
            
            
        })
        
        
        
        )
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        
       /* for touch: AnyObject in touches {
            let location = touch.location(in: self)
            Player.position.x = location.x
            Player.position.y = location.y
            
        }*/
    
        if let touch = touches.first {
            let location = touch.location(in: self)
            lastTouchPosition = location
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        walkingfox.run(SKAction.repeatForever(SKAction.animate(with: texturearray, timePerFrame: 0.1)))
        
        if touching {
            print("Go!")
            walkingfox.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 360))
        }
        touching = true

        
    
    /*   if let touch = touches.first {
            let location = touch.location(in: self)
            lastTouchPosition = location
        }
 */
        // Fox jump 

        
        
        
      /*  for touch: AnyObject in touches {
            let location = touch.location(in: self)
            Player.position.x = location.x
            Player.position.y = location.y
            
        }*/

        
      /*  let touch = touches.first
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            if node[0].name == "gamepreferLabel" {
                let prefScene = SKScene(fileNamed: "PreferenceScene") as! PreferenceScene
                prefScene.userData = NSMutableDictionary()
                prefScene.userData?.setObject("GameScene", forKey: "scrname"  as NSCopying)
                self.view?.presentScene(prefScene)
            }
            
            
            if node[0].name == "gameoverLabel" {
                let gameoverLabel = SKScene(fileNamed: "GameOver") as! GameOver
                
                self.view?.presentScene(gameoverLabel)
            }
            
            
            if node[0].name == "tickSprite" {
                let gamewin = SKScene(fileNamed: "GameWin") as! GameWin
                
                self.view?.presentScene(gamewin)
            }
            
         
            
        }*/
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //lastTouchPosition = nil
        
       // touching = false
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    
}
