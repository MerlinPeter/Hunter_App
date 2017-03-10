//
//  Camera.swift
//  Hunter_App
//
//  Created by Peter on 3/8/17.
//  Copyright © 2017 peter. All rights reserved.
//

import SpriteKit

class Camera : SKCameraNode {
   
    
    
   
    
    // MARK: -Init
    override init() {
       super.init()
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public func setup(walkingfox : SKSpriteNode, background : SKNode){
        
        
       /* let horizConstraint = SKConstraint.distance(SKRange(upperLimit: 50), to: walkingfox)
        
        let vertConstraint = SKConstraint.distance(SKRange(upperLimit: 100), to: walkingfox)
        
        
        let leftConstraint = SKConstraint.positionX(SKRange(lowerLimit: (position.x)))
        
        let rightConstraint = SKConstraint.positionX(SKRange(upperLimit: (background.frame.size.width - position.x)))
        
        let bottomConstraint = SKConstraint.positionY(SKRange(lowerLimit: position.y))
        
        let topConstraint = SKConstraint.positionX(SKRange(upperLimit: (background.frame.size.width - position.y)))
        
        constraints = [horizConstraint,vertConstraint,leftConstraint,bottomConstraint,rightConstraint,topConstraint]*/
        
        
        
    }
    
    
}
