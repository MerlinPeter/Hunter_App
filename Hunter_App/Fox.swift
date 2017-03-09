//
//  Fox.swift
//  Hunter_App
//
//  Created by Merlin Ahila on 3/6/17.
//  Copyright © 2017 peter. All rights reserved.
//

import SpriteKit

class Fox : CommonSpriteNode{
  
    
    // MARK: -Init
    init() {
        let texture = SKTexture(imageNamed: "fox_0.png")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
       // self.name = "walkingfox"
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
         physicsBody=SKPhysicsBody(circleOfRadius: self.size.width/2)
         // walkingfox.setScale( 2.0)
         physicsBody!.allowsRotation = false
         physicsBody!.linearDamping = 0.5
         physicsBody!.categoryBitMask = category_fox
         physicsBody!.contactTestBitMask = category_fence | category_bunny
         //    walkingfox.physicsBody!.collisionBitMask = category_bunny
         physicsBody!.usesPreciseCollisionDetection = true
        ////walkingfox = SKSpriteNode(imageNamed: "fox_0.png")
    }
    
    
    
    
}
