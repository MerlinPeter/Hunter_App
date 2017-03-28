//
//  GoldenTrophy.swift
//  Hunter_App
//
//  Created by Peter on 3/19/17.
//  Copyright © 2017 peter. All rights reserved.
//

import Foundation
import SpriteKit

class GoldenTrophy: CommonSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "GreenButton-Active.png")
        // super.init(texture: texture, color: UIColor.clear, size: texture.size())
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 47, height: 46))
        
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        name="GoldenTrophy"
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width)
        physicsBody!.allowsRotation = false
        physicsBody!.linearDamping = 0.5
        physicsBody!.categoryBitMask = category_golden_trophy
        physicsBody!.contactTestBitMask =  category_fox
        physicsBody!.isDynamic = true
        
       }

}
