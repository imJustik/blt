import SpriteKit
class Background: SKNode {
    private let culer = SKSpriteNode(imageNamed: "Culer.png")
    private let printer = SKSpriteNode(imageNamed: "Printer.png")
    private let bounds = UIScreen.mainScreen().bounds
    let vent = Vent()

    override init() {
        super.init()
        addOffice() //добавляет фон офиса
        addWindow() //Добавляет фон за окном
        addCulerAndPrinter() //Добавляет кулер и принтер
        addVent() //Добавляет вентиляцию
       addWalls()
       
    }
    private func addOffice(){
        let bg = SKSpriteNode(imageNamed: States.sharedInstance.officeType)
        bg.position = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
        bg.size = bounds.size
        bg.zPosition = 0
        addChild(bg)
    }
    
    private func addWindow(){
        let window = SKSpriteNode(imageNamed: States.sharedInstance.bgType)
        window.position = CGPoint(x: CGRectGetMidX(bounds) - 50, y: CGRectGetMidY(bounds) + 75)
        window.setScale(0.9)
        window.zPosition = -5
        addChild(window)
    }
    
    private func addCulerAndPrinter(){
        culer.position = CGPoint (x: CGRectGetMidX(bounds) + 74
            , y: CGRectGetMidY(bounds) - 35)
        printer.position = CGPoint(x: CGRectGetMidX(bounds) - 105
            , y: CGRectGetMidY(bounds)-55)
        addChild(culer)
        addChild(printer)
    }
    
    private func addVent(){
        addChild(vent)
    }
    func startAnimation(){
    culer.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(States.sharedInstance.culerFrames, timePerFrame: 0.075, resize: false, restore: false)), withKey: "culer")
        printer.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(States.sharedInstance.printerFrames, timePerFrame: 0.075, resize: false, restore: false)), withKey: "printer")
    }
    
    private func addWalls(){
        //MARK: левая стена низ
        let lWall = SKShapeNode(rect: CGRectMake(1, UIScreen.mainScreen().bounds.height/2.845, 1, UIScreen.mainScreen().bounds.height/2.845))
        lWall.position = CGPoint(x: CGRectGetMaxX(UIScreen.mainScreen().bounds), y: CGRectGetMinY(UIScreen.mainScreen().bounds) + lWall.frame.size.height/2)
        lWall.physicsBody = SKPhysicsBody(rectangleOfSize: lWall.frame.size)
        lWall.physicsBody?.categoryBitMask = BitMask.downWall
        lWall.physicsBody?.collisionBitMask = 0
        lWall.physicsBody?.contactTestBitMask = 0
        lWall.physicsBody!.dynamic = false
        self.addChild(lWall)
        
        //MARK: левая стена верх
        let lWallUp = SKShapeNode(rect: CGRectMake(1, UIScreen.mainScreen().bounds.height/10, 1, UIScreen.mainScreen().bounds.height/10))
        lWallUp.position = CGPoint(x: CGRectGetMaxX(UIScreen.mainScreen().bounds), y: CGRectGetMaxY(UIScreen.mainScreen().bounds) - 20)
        lWallUp.physicsBody = SKPhysicsBody(rectangleOfSize: lWallUp.frame.size)
        lWallUp.physicsBody?.categoryBitMask = BitMask.upWall
        lWallUp.physicsBody?.contactTestBitMask = BitMask.Bolt
        //lWallUp.physicsBody?.collisionBitMask = BitMask.Bolt
        lWallUp.physicsBody!.dynamic = false
        self.addChild(lWallUp)
        
        let floor = SKShapeNode(rect: CGRectMake(UIScreen.mainScreen().bounds.width, 1, UIScreen.mainScreen().bounds.width, 1))
        floor.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMinY(UIScreen.mainScreen().bounds))
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: floor.frame.size)
        floor.physicsBody?.categoryBitMask = BitMask.fl
        floor.physicsBody?.contactTestBitMask = BitMask.Bolt
        floor.physicsBody?.collisionBitMask = 0
        floor.physicsBody!.dynamic = false
        self.addChild(floor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}