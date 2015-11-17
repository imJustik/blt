import SpriteKit

class Player: GameObjects {
    private var sprite = SKSpriteNode(imageNamed: "TypeMen")
    let foot = SKSpriteNode(imageNamed: "foot v2-1")
    private let foot2 = SKSpriteNode(imageNamed: "foot v2-2")
    private let bounds = UIScreen.mainScreen().bounds
    override init(){
       super.init()
        position = CGPoint(x: CGRectGetMidX(bounds)-65, y: CGRectGetMidY(bounds)-129)
        addChild(sprite)
    }
    func typeAnimation(){
        sprite.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(States.sharedInstance.typeFrames, timePerFrame: 0.075, resize: false, restore: false)), withKey: "type")
    }
    
    func startGame(){
        sprite.removeActionForKey("type")
        sprite.runAction(SKAction.sequence([
            SKAction.repeatAction(SKAction.animateWithTextures(States.sharedInstance.rotationFrames, timePerFrame: 0.075, resize: false, restore: false),count:1),
            SKAction.runBlock({
            self.sprite = SKSpriteNode(imageNamed: "Menv2")
            self.sprite.position = CGPoint(x: 0, y: 0)
            self.addChild(self.sprite)
            self.addFoot()
            }),
            SKAction.removeFromParent()
            ]))
    }
    
    private func addFoot(){
        foot.position = CGPoint(x: 38, y: -16.3)//  для (1,1)
        //foot.position = CGPoint(x: 55, y: -30) //для (0.5 , 1)
        // foot.position = CGPoint(x: 53, y: -39) для (0,1)
        foot.zPosition = 1
        foot.zRotation = 42.5 / 180 * CGFloat(M_PI)
        foot.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: foot.size.width - 10, height: foot.size.height - 10), center: CGPoint(x: -2, y: -25))
        foot.physicsBody?.dynamic = false
        foot.anchorPoint = CGPoint(x: 0.5, y: 1)
        foot.physicsBody?.mass = 5
        
        foot2.position = CGPoint(x: 16, y: -48)
        foot2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: foot2.size.width - 25, height: foot2.size.height - 10), center: CGPoint(x: -15, y: 2))
        foot2.physicsBody?.dynamic = false
        foot2.zPosition = 1
        foot.addChild(foot2)
        
        addChild(foot)
        
        foot.physicsBody!.categoryBitMask = BitMask.Foot
        foot.physicsBody!.contactTestBitMask = BitMask.Bolt
        foot.physicsBody!.collisionBitMask = 0

    }
    
    func kick() {
        if self.foot.actionForKey("move")  == nil {
            self.foot.runAction(SKAction.sequence([
                SKAction.rotateByAngle(0.8, duration: 0.1),
                SKAction.waitForDuration(0.15),
                SKAction.rotateToAngle(42.5 / 180 * CGFloat(M_PI), duration: 0.2)]), withKey: "move")
            self.foot.runAction(SKAction.sequence([
                SKAction.moveByX(0, y: -5, duration: 0.1),
                SKAction.waitForDuration(0.15),
                SKAction.moveByX(0, y: 5, duration: 0.2)]
                ))
            self.foot2.runAction(SKAction.sequence([
                SKAction.rotateByAngle(0.2, duration: 0.1),
                SKAction.moveBy(CGVectorMake(0, 2), duration: 0.1),
                SKAction.waitForDuration(0.15),
                SKAction.moveBy(CGVectorMake(0, -2), duration: 0.1),
                SKAction.rotateToAngle(0, duration: 0.1)
                ]), withKey: "move")
        }
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
