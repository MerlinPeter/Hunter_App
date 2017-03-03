//
//  GameScene.swift
//  Hunter_App
//
//  Created by Peter on 2/23/17.
//  Copyright © 2017 peter. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
  //  let  manager  = CMMotionManager()
    
    var Player = SKSpriteNode(imageNamed: "Fox.png" )
    
    var player: SKSpriteNode!

    
    
    override func sceneDidLoad() {
        Player.position = CGPoint(x:self.frame.size.width / 2, y:self.frame.size.height / 2)
        
        self.addChild(Player)

        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        // 2
        borderBody.friction = 1.5
        // 3
        self.physicsBody = borderBody

        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:50,y:100))
        let followLine = SKAction.follow(path, asOffset: true, orientToPath: false, duration: 3.0)
        let reversedLine = followLine.reversed()
        let square = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
        let followSquare = SKAction.follow(square.cgPath, asOffset: true, orientToPath: false, duration:5.0)
        
        //Player.run(SKAction.sequence([followLine, reversedLine,followSquare]))
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let touch = touches.first
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

        }
        
    }
    
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "fox.png")
        player.position = CGPoint(x: 96, y: 672)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody!.allowsRotation = false
        player.physicsBody!.linearDamping = 0.5
        
        player.physicsBody!.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody!.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
        player.physicsBody!.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    }
