//
//  Bunny.swift
//  Hunter_App
//
//  Created by Merlin Ahila on 3/7/17.
//  Copyright © 2017 peter. All rights reserved.
//

import SpriteKit

class Bunny : CommonSpriteNode{
    
     // MARK: -Init
    init() {
        let texture = SKTexture(imageNamed: "bunny.png")
       // super.init(texture: texture, color: UIColor.clear, size: texture.size())
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 82, height: 51))
        
         setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        name="Bunny"
        physicsBody=SKPhysicsBody(circleOfRadius: self.size.width/3)
        // walkingfox.setScale( 2.0)
        physicsBody!.allowsRotation = false
        physicsBody!.linearDamping = 0.5
        physicsBody!.categoryBitMask = category_bunny
        physicsBody!.contactTestBitMask = category_fence | category_fox
         physicsBody!.isDynamic = true
        ////walkingfox = SKSpriteNode(imageNamed: "fox_0.png")
    }
    
 
    
    
}

