import UIKit
import SpriteKit

class Bolt: GameObjects {
    let sprite = SKSpriteNode(imageNamed: States.sharedInstance.boltType)
    var xScaleFactor = UIScreen.mainScreen().bounds.width / 320.0
    var yScaleFactor = UIScreen.mainScreen().bounds.height / 568.0
    init(pos: CGPoint, impulse: CGVector){
        super.init()
        changeSize(sprite)
        var mas: CGFloat = 0
        addChild(sprite)
        position = pos
        zPosition = 3
        zRotation = rand(0, max: 89)
        if States.sharedInstance.boltType != BoltTypes.Dick {
            physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height / (2 * Controller.yScale))}
        else {
            physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height / (4 * Controller.yScale))
            sprite.setScale(0.92)
        }
        self.physicsBody!.velocity = impulse
        //physicsBody?.allowsRotation = false
//        switch States.sharedInstance.boltType {
//        case BoltTypes.Bolt: mas = -50
//        case BoltTypes.Psevdo: mas = -45
//        case BoltTypes.Dick: mas = -49
//        default: mas = -50
//        }
        sprite.physicsBody?.mass = mas
        physicsBody!.categoryBitMask = BitMask.Bolt
        physicsBody!.collisionBitMask =  BitMask.Foot | BitMask.downWall
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func collision(obj: SKNode) -> Bool {
        //self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 2.5))
        self.physicsBody?.applyImpulse(CGVector(dx: 0.5 * Controller.xScale, dy: 1.45 * Controller.yScale ))
        return true
        }
    //self.physicsBody?.applyImpulse(CGVector(dx: 3.2, dy: 4))
    
    func rand() -> CGFloat
    {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        
    }
    func rand(min: CGFloat, max: CGFloat) -> CGFloat
    {
        return rand() * (max-min) + min
    }
    func changeSize(node: SKSpriteNode) { //Функция увеличиват спрайты пропорционально экрану
        node.size.width *= xScaleFactor
        node.size.height *= yScaleFactor
    }
    
    
}
