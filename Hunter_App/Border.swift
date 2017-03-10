//
//  Border.swift
//  Hunter_App
//
//  Created by Peter on 3/8/17.
//  Copyright © 2017 peter. All rights reserved.
//

import SpriteKit

class Border : SKNode {
    // MARK: - Contact Variables 
    // should be taken to parent class
    let   category_fence:UInt32  = 0x1 << 3;
    let   category_bunny:UInt32  = 0x1 << 2;
    let   category_fox:UInt32    = 0x1 << 0;
    
    var borderBody : SKPhysicsBody!

    
    public func setup(border:SKNode){
        
    borderBody=SKPhysicsBody(edgeLoopFrom: border.frame)
        
    borderBody.friction = 1
    self.physicsBody = borderBody
    self.physicsBody?.categoryBitMask = category_fence
    self.physicsBody?.contactTestBitMask = category_fox
    borderBody.isDynamic=false

    
    }
    

}
