//
//  Camera.swift
//  Hunter_App
//
//  Created by Peter on 3/8/17.
//  Copyright © 2017 peter. All rights reserved.
//

import SpriteKit

class MyCamera :SKCameraNode{
    
   public var walkingfox : SKSpriteNode!
   public var background_node : SKNode!
    
    
    public func setup( ){
        
        position = CGPoint(x: -184 , y: 0)
        let horizConstraint = SKConstraint.distance(SKRange(upperLimit: 100), to: walkingfox)
        let vertConstraint = SKConstraint.distance(SKRange(upperLimit: 50), to: walkingfox)
        let leftConstraint = SKConstraint.positionX(SKRange(lowerLimit: position.x))
        let bottomConstraint = SKConstraint.positionY(SKRange(lowerLimit: position.y))
        let rightConstraint = SKConstraint.positionX(SKRange(upperLimit:184))//TBD this no need to dynamic
    //    let topConstraint = SKConstraint.positionY(SKRange(upperLimit: (background_node.frame.size.width - position.y)))
        let topConstraint = SKConstraint.positionY(SKRange(upperLimit: (0)))//tBD
        

            //(upperLimit: (background_node.frame.size.width - position.y)))
        constraints = [horizConstraint, vertConstraint, leftConstraint , bottomConstraint, rightConstraint,topConstraint]
        
        
    }
    
    
}
