//
//  GameScene.swift
//  Hunter_App
//
// 
//

import SpriteKit
import GameplayKit
import CoreMotion
import MotionHUD


class GameScene: MHMotionHUDScene ,SKPhysicsContactDelegate{
    
    //MARK: -- Init
    
    override init(size: CGSize ) {
        super.init(size: size)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        border_setup()

        actor_setup()
        animate_setup()

    }
    
    //MARK: - General Variables

    let category_fence:UInt32  = 0x1 << 3;
    let category_bunny:UInt32  = 0x1 << 2;
    let category_fox:UInt32    = 0x1 << 0;
    var motionManager: CMMotionManager!
    var lastTouchPosition: CGPoint?
    var touching: Bool = false
    var righttouches :Int = 0 //: Int
    var lefttouches :Int = 0 //: Int
    var kMoveSpeed : Double = 200.0;
    var jump = 0
    
    
    
    //MARK: - Actors Variables
    
    var  walkingfox =  Fox()
    var  bunny = Bunny()
    var  bunny1 = Bunny()
    
    //MARK: - Animaton Variables
    
    var textureatlas = SKTextureAtlas()
    var texturearray = [SKTexture]()
    var textureatlas2 = SKTextureAtlas()
    var texturearray2 = [SKTexture]()
    var walkAnimation = SKAction()
    var walkAnimation2 = SKAction()
    var jumpAnimation = SKAction()
    
    
    //MARK: - Cammera Variables
    
    var front_camera :SKNode!

   // var mycammera = Camera()
    
     //MARK: - BackGround & Border Variables
     let border = Border()
    var background_node:SKNode!

      let ground = SKSpriteNode()
    

    //Emitter variable
    
    
    //MARK: - Setup
    
    func actor_setup(){
        
       
        walkingfox.position = CGPoint(x: -184 , y: 0)
        self.addChild(walkingfox)
        
        
        bunny.position = CGPoint(x: 200, y:0)
        self.addChild(bunny)
        
        bunny1.position = CGPoint(x: -300, y:0)
        self.addChild(bunny1)
        
        
        
    }
    func animate_setup(){
        
        textureatlas = SKTextureAtlas(named: "foxwalk")
        
        for i  in 0...(textureatlas.textureNames.count-1){
            
            let filename = "fox_\(i).png"
            texturearray.append(SKTexture(imageNamed: filename))
            
        }
        walkAnimation = SKAction.repeatForever(SKAction.animate(with: texturearray, timePerFrame: 0.1))
        
        textureatlas2 = SKTextureAtlas(named: "foxwalk2")
        
        for i  in 0...(textureatlas2.textureNames.count-1){
            
            let filename = "fox2_\(i).png"
            texturearray2.append(SKTexture(imageNamed: filename))
            
        }
        walkAnimation2 = SKAction.repeatForever(SKAction.animate(with: texturearray2, timePerFrame: 0.1))
        texturearray2.removeAll()
        textureatlas2 = SKTextureAtlas(named: "foxjump")
        
        for i  in 0...(textureatlas2.textureNames.count-1){
            
            let filename = "fox_3_\(i).png"
            texturearray2.append(SKTexture(imageNamed: filename))
            
        }
        jumpAnimation = SKAction.animate(with: texturearray2, timePerFrame: 0.1)
        

    }
    func border_setup(){
        
        background_node = self.childNode(withName: "background")
 
        
        border.setup(border: background_node)
        
        
        addChild(border)
        let barra = SKShapeNode(rectOf: CGSize(width: 300, height: 100))
        barra.name = "bar"
        barra.fillColor = SKColor.white
        barra.position = CGPoint(x: 0, y: self.size.height/10)
       
        
        //self.addChild(barra)
    }
    
    func scene_setup(){
        
    }
    
    func screen_tap_setup(view :SKView){
        //doubletab
        //let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        //tap.numberOfTapsRequired = 2
       // view.addGestureRecognizer(tap)
        
    }
    //MARK: - SKScene functions
    
    override func didMove(to view: SKView) {
        
      
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        self.physicsWorld.contactDelegate = self
        
        screen_tap_setup(view: view)
        //let zeroRange = SKRange(constantValue: 0)
       // let foxConst = SKConstraint.distance(zeroRange, to: self.background_node)
        
        front_camera = self.childNode(withName: "front_camera")
        let horizConstraint = SKConstraint.distance(SKRange(upperLimit: 100), to: walkingfox)
        

        let vertConstraint = SKConstraint.distance(SKRange(upperLimit: 50), to: walkingfox)
        
        print(front_camera.position.x)
         let leftConstraint = SKConstraint.positionX(SKRange(lowerLimit: front_camera.position.x))
        let bottomConstraint = SKConstraint.positionY(SKRange(lowerLimit: front_camera.position.y))
        //    id rightConstraint = [SKConstraint positionX:[SKRange rangeWithUpperLimit:(tiles.exitSign.position.x + 200 - camera.position.x)]];

        let rightConstraint = SKConstraint.positionX(SKRange(upperLimit:184))//TBD how to get this no  dynamic
     
        print(self.frame.size.width - background_node.frame.size.width)
      let topConstraint = SKConstraint.positionX(SKRange(upperLimit: (background_node.frame.size.width - front_camera.position.y)))
        

        //camera constraint
        front_camera.constraints = [horizConstraint, vertConstraint, leftConstraint , bottomConstraint, rightConstraint, topConstraint]
        
        //Cliff block
        let sprites = spritesCollection(xposition: -11,yposition: 30)
        
          for sprite in sprites {
           addChild(sprite)
         }

         let sprite1 = spritesCollection(xposition: 350,yposition: 72)
        for sprite in sprite1 {
            addChild(sprite)
        }
    
    }
 

 
    override func update(_ currentTime: TimeInterval) {
 
        super.update( currentTime)

       // mycammera.position.x = walkingfox.position.x

 
 }
 
 
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
 
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let  kHugeTime : TimeInterval = 9999.0;
        super.touchesBegan(touches, with: event)
        
        for touch: UITouch in touches {
            print(touch.location(in: walkingfox.parent!).x)
            print(walkingfox.position.x)
            if touch.location(in: walkingfox.parent!).x < walkingfox.position.x {
                
                lefttouches += 1
            }else{
                righttouches += 1
            }
            
        }
 
       /* if (walkingfox.hasActions()){
            walkingfox.removeAllActions()
         }else{
            
        }*/
        
        if ((lefttouches == 1) && (righttouches == 0)){
            
            let leftMove = SKAction.move(by: CGVector(dx:-1.0 * kHugeTime * kMoveSpeed, dy:0), duration: kHugeTime )
            walkingfox.run(leftMove, withKey :"MoveAction")
            walkingfox.run(walkAnimation,withKey:"walkingAnimation")
            //mycammera.position = walkingfox.position

            
        }else if ((lefttouches == 0) && (righttouches == 1)){
            let rightMove = SKAction.move(by: CGVector(dx:1.0 * kHugeTime * kMoveSpeed, dy:0), duration: kHugeTime )
            walkingfox.run(rightMove, withKey :"MoveAction")
            walkingfox.run(walkAnimation2,withKey:"walkingAnimation")
         //   mycammera.position = walkingfox.position
            
        }
        
        else if ((lefttouches + righttouches) > 1){
            //jump
            
            let jump = SKAction.applyImpulse(CGVector(dx: 0, dy: 1000), duration: 0.3)
                
            walkingfox.run(jump)
            walkingfox.run(jumpAnimation,withKey:"jumpAnimation")

            print("jump")
        }
        
        print("touchbegin")
    print(lefttouches)
    print(righttouches)
        
        
    }
    
    
    
    
    func reduceTouches(_ touches: Set<UITouch>?, with event: UIEvent?){
        
        
        for touch: UITouch in touches! {
            
            if touch.location(in: walkingfox.parent!).x < walkingfox.position.x {
                lefttouches -= 1
            }else{
                righttouches -= 1
            }
            
        }

        while((lefttouches < 0) || (righttouches < 0)){
            
            if (lefttouches < 0){
                righttouches += lefttouches;
                  lefttouches = 0
            }
            if (righttouches < 0){
                lefttouches += righttouches
                righttouches = 0
            }
            
        }
        
        if((lefttouches + righttouches) <= 0){
            print("stop")

            walkingfox.removeAction(forKey: "walkingAnimation")
            walkingfox.removeAction(forKey: "MoveAction")
  
        }
        print("reeduce")
        print(lefttouches)
        print(righttouches)
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
      super.touchesCancelled(touches!, with: event)
      self.reduceTouches(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>?, with event: UIEvent?) {
       super.touchesEnded(touches!, with: event)
       self.reduceTouches(touches, with: event)
        
    
   
    }
    
    //MARK: - Custom Functions
    
    func doubleTapped() {
//        walkingfox.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 360))

    }
    //MARK: -- Cliff blocks
    //sprite.position = CGPoint(x: x, y: 30.0)
    private func spritesCollection(xposition: Int,yposition: Int) -> [SKSpriteNode] {
        var sprites = [SKSpriteNode]()
        textureatlas = SKTextureAtlas(named: "Cliffblocks.atlas")
        let incrvar = CGFloat(57.319)
        var x = CGFloat(xposition)
        var y = CGFloat(yposition)
  

         for i  in 1...(textureatlas.textureNames.count-1){
         
            let sprite = SKSpriteNode(imageNamed: "grass_0\(i).png")
            // skipping the physicsBody stuff for now as it is not part of the question
            // giving the sprites a random position
            sprite.size = CGSize(width: 63, height: 49)
            sprite.position = CGPoint(x: x, y: y)
            sprites.append(sprite)
            x = x + incrvar
        }
        return sprites
        //
            }
    
    func createGround(){
        
        
        for i in 0...10
        {
            let ground = SKSpriteNode(imageNamed: "groundtile.png")
            ground.name = "Ground"
            ground.size = CGSize(width: (self.scene?.size.width)!, height: 35)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.isDynamic=false
            
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: 0)
            
            self.addChild(ground)
            
            
        }
    }

    
    //MARK: - Contact Delegate functions

    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        
        var secondBody: SKPhysicsBody
        // 2
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        let  actionAudioExplode = SKAction.playSoundFileNamed("fox_hit.mp3",waitForCompletion: false)
        
         //(SKAction  playSoundFileNamed : "fox_hit.mp3"  waitForCompletion:NO)
        let path = Bundle.main.path(forResource: "FireParticle", ofType: "sks")
        let fireParticle = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        
        // 3
        if firstBody.categoryBitMask == category_fox && secondBody.categoryBitMask == category_bunny {
            print("Fox hit bunny. First contact has been made.")
         
            // let gamewin = SKScene(fileNamed: "GameWin") as! GameWin
            
            // self.view?.presentScene(gamewin)
            
            //Particle Emitter
            fireParticle.position = (contact.bodyB.node?.position)!
            contact.bodyB.node?.removeFromParent()
            fireParticle.name = "FIREParticle"
            fireParticle.targetNode = self.scene
           // fireParticle.particleBirthRate = 150
            fireParticle.particleLifetime = 0.5
           // let actionExplodeSequence = SKAction.sequence([actionAudioExplode])
   
            walkingfox.run(actionAudioExplode)
            
            self.addChild(fireParticle)

        }
    
    }
    
}


//code for accelmetor function

/*   
 
 #if (arch(i386) || arch(x86_64))
 if let currentTouch = lastTouchPosition {
 let diff = CGPoint(x: currentTouch.x - walkingfox.position.x, y: currentTouch.y - walkingfox.position.y)
 physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
 }
 #else
 if let accelerometerData = motionManager.accelerometerData {
 print("upate")
 super.update(currentTime)
 physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
 }
 #endif
 
 button code
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
 //APPLE CODE
 let zeroRange = SKRange(constantValue: 0.0)
 let foxConst = SKConstraint.distance(zeroRange, to: self.walkingfox)
 
 let boardNode = self.childNode(withName: "background")
 let boardContentRect = boardNode?.calculateAccumulatedFrame()
 
 // get the scene size as scaled by `scaleMode = .AspectFill`
 let scaledSize = CGSize(width: size.width * front_camera.xScale, height: size.height * front_camera.yScale)
 
 
 // inset that frame from the edges of the level
 // inset by `scaledSize / 2 - 100` to show 100 pt of black around the level
 // (no need for `- 100` if you want zero padding)
 // use min() to make sure we don't inset too far if the level is small
 let xInset = min((scaledSize.width / 2) - 200.0, (boardContentRect?.width)! / 2)
 let yInset = min((scaledSize.height / 2) - 200.0, (boardContentRect?.height)! / 2)
 let insetContentRect = boardContentRect?.insetBy(dx: xInset, dy: yInset)
 
 // use the corners of the inset as the X and Y range of a position constraint
 let xRange = SKRange(lowerLimit: (insetContentRect?.minX)!, upperLimit: (insetContentRect?.maxX)!)
 let yRange = SKRange(lowerLimit: (insetContentRect?.minY)!, upperLimit: (insetContentRect?.maxY)!)
 let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
 levelEdgeConstraint.referenceNode = boardNode
 
 
 
 */




