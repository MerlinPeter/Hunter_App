//
//  Poisonbush.swift
//  Hunter_App
//
//  Created by Peter on 3/12/17.
//  Copyright © 2017 peter. All rights reserved.
//

import Foundation
import SpriteKit

class Poisonbush: CommonSpriteNode {

    init() {
        let texture = SKTexture(imageNamed: "GrassObjects_32_19.png")
        // super.init(texture: texture, color: UIColor.clear, size: texture.size())
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 32, height: 62))
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //var pbushBody : SKPhysicsBody!
    
    func setup(){
        name="PoisonBush"
        color = UIColor.red
        colorBlendFactor = 1
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        
        physicsBody!.allowsRotation = false
        physicsBody!.linearDamping = 0.5
        physicsBody!.categoryBitMask = category_pbush
        physicsBody!.contactTestBitMask = category_fox
        physicsBody!.isDynamic = true
        ////walkingfox = SKSpriteNode(imageNamed: "fox_0.png")
    }
    
}
