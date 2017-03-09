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
        actor_setup()
        border_setup()
    }
    
    //MARK: - General Variables

    let category_fence:UInt32  = 0x1 << 3;
    let category_bunny:UInt32  = 0x1 << 2;
    let category_fox:UInt32    = 0x1 << 0;
    var motionManager: CMMotionManager!
    var lastTouchPosition: CGPoint?
    var touching: Bool = false
    var righttouches = 0 //: Int
    var lefttouches = 0 //: Int
    
    
    //MARK: - Actors Variables
    
    var  walkingfox  : SKSpriteNode!
    var  bunny  : SKSpriteNode!
    
    //MARK: - Animaton Variables
    
    var textureatlas = SKTextureAtlas()
    var texturearray = [SKTexture]()
    
    //MARK: - Cammera Variables
    
    let mycamera : SKCameraNode = SKCameraNode()
    
     //MARK: - BackGround & Border Variables
    private let border = Border()

    let background = SKSpriteNode(imageNamed: "background.png")
    let bgImage1 = SKSpriteNode(imageNamed: "background.png")
    let bgImage2 = SKSpriteNode(imageNamed: "background.png")
    let ground = SKSpriteNode()
    

    //MARK: - Setup
    
    func actor_setup(){
        
        walkingfox = Fox()
        walkingfox.position = CGPoint(x:self.frame.midX, y:walkingfox.size.height/2 + 10)
        self.addChild(walkingfox)
        
        bunny = Bunny()
        bunny.position = CGPoint(x:self.frame.midX + 200, y:self.size.height/5)
        self.addChild(bunny)
        
        self.camera=mycamera
        mycamera.position=CGPoint(x:self.frame.midX, y:walkingfox.size.height/2 + 10)
        
        let horizConstraint = SKConstraint.distance(SKRange(upperLimit: 50), to: walkingfox)
        
        let vertConstraint = SKConstraint.distance(SKRange(upperLimit: 100), to: walkingfox)
        

        let leftConstraint = SKConstraint.positionX(SKRange(lowerLimit: (camera?.position.x)!))
        
        let rightConstraint = SKConstraint.positionX(SKRange(upperLimit: (background.frame.size.width - (camera?.position.x)!)))
            
        let bottomConstraint = SKConstraint.positionY(SKRange(lowerLimit: (camera?.position.y)!))
        
        let topConstraint = SKConstraint.positionX(SKRange(upperLimit: (background.frame.size.width - (camera?.position.y)!)))
        
        mycamera.position = CGPoint(x:self.size.width/2, y:self.size.height/2)
        mycamera.constraints = [horizConstraint,vertConstraint,leftConstraint,bottomConstraint,rightConstraint,topConstraint]
        
        self.addChild(mycamera)
        
        
    }
 
    func border_setup(){
    
        border.setup()
        addChild(border)
    }
    
    func scene_setup(){
        background.position = CGPoint(x:0,y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        bgImage1.position = CGPoint(x:bgImage1.size.width,y: self.size.height/2)
        bgImage1.zPosition = 0
        //   self.addChild(bgImage1)
        bgImage2.position = CGPoint(x:-bgImage1.size.width,y: self.size.height/2)
        bgImage2.zPosition = 0
        // self.addChild(bgImage2)
        
    }
    
    func screen_tap_setup(view :SKView){
        //doubletab
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
    }
    //MARK: - SKScene functions
    
    override func didMove(to view: SKView) {
        
      
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        self.physicsWorld.contactDelegate = self
        
        screen_tap_setup(view: view)
        
        // code to load images
        
        textureatlas = SKTextureAtlas(named: "foxwalk")
        
        for i  in 0...(textureatlas.textureNames.count-1){
            
            let filename = "fox_\(i).png"
            texturearray.append(SKTexture(imageNamed: filename))
            
        }
        

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        super.update( currentTime)
     
 }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        
          if let touch = touches.first {
            let location = touch.location(in: self)
            lastTouchPosition = location
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /*
 [super touchesBegan:touches withEvent: event];
 
 static const NSTimeInterval kHugeTime = 9999.0;
 SKNode *character = [self childNodeWithName:@"Character"];
 
 
 
 for (UITouch *touch in touches) {
 if ([touch locationInNode:character.parent].x < character.position.x){
 leftTouches++;
 }
 else{
 rightTouches++;
 }
 }
 
 if ((leftTouches == 1) && (rightTouches == 0)){
 //move left
 character.xScale = -1.0*ABS(character.xScale);
 //SKAction *shuffleNoise = [SKAction playSoundFileNamed:@"shuffle" waitForCompletion:YES];
 //SKAction *repeatNoise = [SKAction rep*/
        
        super.touchesBegan(touches, with: event)
        
        for touch: UITouch in touches {
            if touch.location(in: walkingfox.parent!).x < walkingfox.position.x {
                lefttouches += 1
            }else{
                righttouches += 1
            }
            
        }
 
        if (walkingfox.hasActions()){
            walkingfox.removeAllActions()
         }else{
            walkingfox.run(SKAction.repeatForever(SKAction.animate(with: texturearray, timePerFrame: 0.1)))
            
        }
        
        if ((lefttouches == 1) && (righttouches == 0)){
            //SKAction leftMove = SKAction.move(by: CGVector, duration: )
             //   [SKAction moveBy:CGVectorMake(-1.0*kMoveSpeed*kHugeTime,0) duration:kHugeTime];

            
        }

      }

    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    //MARK: - Custom Functions
    
    func doubleTapped() {
        walkingfox.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 360))

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
        // 3
        if firstBody.categoryBitMask == category_fox && secondBody.categoryBitMask == category_bunny {
            print("Fox hit bunny. First contact has been made.")
            // let gamewin = SKScene(fileNamed: "GameWin") as! GameWin
            
            // self.view?.presentScene(gamewin)
            
            
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

 
 */




