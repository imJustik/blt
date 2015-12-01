
import SpriteKit

class Vent: GameObjects {
    let vent = SKSpriteNode(imageNamed: "Vent_05")
    let vent1 = SKSpriteNode(imageNamed: "Vent_06")
    let top = SKSpriteNode(imageNamed: "top")
    var xScaleFactor = UIScreen.mainScreen().bounds.width / 320.0
    var yScaleFactor = UIScreen.mainScreen().bounds.height / 568.0
    private var flag = false //состояние решетки
    override init() {
        super.init()
        let offsetX = vent.frame.size.width * vent.anchorPoint.x;
        let offsetY = vent.frame.size.height * vent.anchorPoint.y;
        let path = CGPathCreateMutable()
        
        //Создается физическое тело по форме верха форточки
        CGPathMoveToPoint(path, nil, 3 - offsetX, 78 - offsetY);
        CGPathAddLineToPoint(path, nil, 73 - offsetX, 120 - offsetY);
        CGPathAddLineToPoint(path, nil, 73 - offsetX, 115 - offsetY);
        CGPathAddLineToPoint(path, nil, 3 - offsetX, 73 - offsetY);
        
        CGPathCloseSubpath(path);
        
        vent.position = CGPoint(x: CGRectGetMaxX(UIScreen.mainScreen().bounds) - 30 * xScaleFactor, y: CGRectGetMaxY(UIScreen.mainScreen().bounds) - 130 * yScaleFactor)
        vent.zPosition = 2
        vent.physicsBody = SKPhysicsBody(polygonFromPath: path)
        vent.physicsBody?.categoryBitMask = BitMask.ventTop
        vent.physicsBody?.collisionBitMask = 0
        vent.physicsBody?.contactTestBitMask = 0 //BitMask.Bolt
        vent.physicsBody?.dynamic = false
        changeSize(vent)
        
        //Задняя часть форточки, имеет zPos больше для создания эфекта залетания
        vent1.position = CGPoint(x: 29 * xScaleFactor, y: 0 * yScaleFactor)
        vent1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: 70), center: CGPoint(x: 3, y: 0))
        vent1.physicsBody?.categoryBitMask = BitMask.v2
        vent1.physicsBody?.collisionBitMask = 0
        vent1.physicsBody?.contactTestBitMask = BitMask.Bolt
        vent1.physicsBody?.dynamic = false
        vent1.zPosition = 4
        changeSize(vent1)
        vent.addChild(vent1)
        addChild(vent)
        
        top.position = CGPoint(x: vent.position.x-12 * xScaleFactor, y: vent.position.y+21 * yScaleFactor)
        top.name = "top"
        top.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: top.frame.size.width/10, height: top.frame.size.height), center: CGPoint(x: CGRectGetMidX(top.frame), y: CGRectGetMidY(top.frame)))
        top.physicsBody?.dynamic = false
        top.zPosition = 7
        addChild(top)
    }
    func closeGrid(){
        if !top.hasActions() {
        if flag == false {
        flag = true
        top.runAction(SKAction.repeatAction(SKAction.animateWithTextures(States.sharedInstance.gridFrames, timePerFrame: 0.075, resize: false, restore: false), count: 1))
        } else {
            flag = false
            top.runAction(SKAction.repeatAction(SKAction.animateWithTextures(States.sharedInstance.gridOpenFrames, timePerFrame: 0.075, resize: false, restore: false), count: 1))
            }
        }
    }
    private func changeSize(node: SKSpriteNode) { //Функция увеличиват спрайты пропорционально экрану
        node.size.width *= xScaleFactor
        node.size.height *= yScaleFactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
