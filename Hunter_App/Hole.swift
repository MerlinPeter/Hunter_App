//
//  Hole.swift
//  Hunter_App
//
//  Created by Peter on 3/17/17.
//  Copyright © 2017 peter. All rights reserved.
//

import Foundation
import  SpriteKit


class Hole: CommonSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "GrassObjects_32_05.png")
        // super.init(texture: texture, color: UIColor.clear, size: texture.size())
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 69, height: 32))
        
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}

    func setup(){
        name="Holetask"
        color = UIColor.red
        colorBlendFactor = 1
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody!.allowsRotation = false
        physicsBody!.linearDamping = 0.5
        physicsBody!.categoryBitMask = category_hole
        physicsBody!.contactTestBitMask =  category_fox
        physicsBody!.isDynamic = false
        
    }
    
    
    
}
