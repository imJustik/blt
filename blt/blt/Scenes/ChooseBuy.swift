import SpriteKit

class ChooseBuy: SKScene {
    private var title = String()
    private var count = 0
    private var iconMass = Array<Array<SKSpriteNode>>()
    private var fogging = SKSpriteNode()
    private var type = Types()
  //  private var y: Types = Types.iconsBolt
    
    private let total = TotalBolts()
    init(title:String, count:Int, size:CGSize){
        super.init(size: size)
        self.count = count
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        let player = Player()
        let background = Background()
        fogging = SKSpriteNode(color: SKColor(red: 0.553, green: 0.2553, blue: 0.1702, alpha: 0.4),size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        fogging.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        fogging.zPosition = 7
        addChild(fogging)
        fogging.addChild(total)
        
        addChild(background)
        addChild(player)
        player.typeAnimation()
        
        generateIcons()
        
        let backButton = SKSpriteNode(imageNamed: "Button Back")
        backButton.position = CGPoint(x:iconMass[count/4][1].position.x, y: iconMass[count/4][1].position.y - 60)
        backButton.name = "BackFromChooseBuy"
        fogging.addChild(backButton)
        loadIcons()
        
    }
    private func generateIcons(){
        var massLine = [SKSpriteNode]()
        var position = CGPoint(x: -60, y: 50)
        for var i = 0; i<count/3; i++ {
            for var j = 0; j < 3; j++ {
                let node = SKSpriteNode(imageNamed: "Button question")
                node.position = position
                node.name = "question"
                fogging.addChild(node)
                position.x+=60
                massLine.append(node)
            }
            position.x = -60
            position.y -= 60
            iconMass.append(massLine)
            massLine = [SKSpriteNode]()
        }
        
    }
    private func loadIcons(){
        var imageName = ""
        var i = 0
        var j = 0
        if title == "window" {
        IconsWindow.reload()
        for elem in IconsWindow.returnWindow(){
            if (elem["unlocked"]) as! Bool == false
            {
                imageName = String(elem["name"]!) + " locked"
            }
            else {
                imageName = String(elem["name"]!)
            }
             iconMass[i][j].removeFromParent()
            
            let node = SKSpriteNode(imageNamed: imageName)
            node.position = iconMass[i][j].position
            node.name = imageName
            fogging.addChild(node)
            
            if j <= 3 {
                j++
            } else {
                j = 0
                i++
            }
        }
        } else if title == "bolt" {
            IconsBolt.reload()
            for elem in IconsBolt.returnBolts(){
                if (elem["unlocked"]) as! Bool == false
                {
                    imageName = String(elem["name"]!) + " locked"
                }
                else {
                    imageName = String(elem["name"]!)
                }
                iconMass[i][j].removeFromParent()
                
                let node = SKSpriteNode(imageNamed: imageName)
                node.position = iconMass[i][j].position
                node.name = imageName
                fogging.addChild(node)
                
                if j <= 3 {
                    j++
                } else {
                    j = 0
                    i++
                }
            }

        }
}

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        if nodeAtPoint(touchLocation).name != nil {
            print(nodeAtPoint(touchLocation).name)
        switch nodeAtPoint(touchLocation).name! {
        case "question": print("question")
        case "Bolt metal":
            States.sharedInstance.boltType = BoltTypes.Bolt
        case "Bolt pink":
            States.sharedInstance.boltType = BoltTypes.Psevdo
        case "Bolt dick":
            States.sharedInstance.boltType = BoltTypes.Dick
            
            
        case "BackFromChooseBuy":
            let scene = Settings(size:size)
            self.view?.presentScene(scene)
        default:
            let texture = ((nodeAtPoint(touchLocation)) as! SKSpriteNode).texture
            let scene = Buy(title: nodeAtPoint(touchLocation).name!, texture: texture!, boltCost: 100, moneyCost: 10,size: size)
            self.view?.presentScene(scene)
        }
            cleanScene()
            loadIcons()
    }
    
    }
    //очищает сцену
    private func cleanScene(){
        for var i = 0; i<count/3; i++ {
            for var j = 0; j < 3; j++ {
                iconMass[i][j].removeFromParent()
            }
            
        }
    }
}

//let texture = ((nodeAtPoint(touchLocation)) as! SKSpriteNode).texture
//let scene = Buy(title: nodeAtPoint(touchLocation).name!, texture: texture!, boltCost: 100, moneyCost: 10,size: size)
//self.view?.presentScene(scene)
