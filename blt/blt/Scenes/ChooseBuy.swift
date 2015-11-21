import SpriteKit

class ChooseBuy: SKScene {
    private var title = String()
    private var count = 0
    private var iconMass = Array<Array<Icon>>()
    private var fogging = SKSpriteNode()
    private var type : ProductsType = ProductsType.Bolt
  //  private var y: Types = Types.iconsBolt
    
    private var i = 0
    private var j = 0
    
    private let total = TotalBolts()
    init(type: ProductsType, count:Int, size:CGSize){
        super.init(size: size)
        self.count = count
        self.type = type
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
        var massLine = [Icon]()
        var position = CGPoint(x: -60, y: 50)
        for var i = 0; i<count/3; i++ {
            for var j = 0; j < 3; j++ {
                let node = Icon(nameProduct: "", image: "Button question", stat: Status.question, productId: "0", priceBolt: 0, priceMoney: 0)
                node.position = position
                node.name = "question"
                fogging.addChild(node)
                position.x+=60
                massLine.append(node)
            }
            position.x = -60
            position.y -= 60
            iconMass.append(massLine)
            massLine = [Icon]()
        }
        
    }
    
    func loadIcons() {
        if type == ProductsType.Bolt {
            IconsBolt.setSelect()
            for elem in IconsBolt.returnBolts(){
                load(elem)
            }
            
        } else if type == ProductsType.Window {
            IconsWindow.setSelect()
            for elem in IconsWindow.returnWindow(){
                load(elem)
            }
          }
        i = 0
        j = 0
    }
    
    func load(elem: [String:Any]) {
        let node = Icon(nameProduct: String(elem["name"]!), image: String(elem["image"]!), stat: (elem["status"] as! Status), productId: String(elem["productId"]), priceBolt: (elem["costBolt"] as! Int), priceMoney: (elem["costMoney"] as! Int))
        node.position = iconMass[i][j].position
        node.name = String(elem["image"]!)
        iconMass[i][j].removeFromParent()
        fogging.addChild(node)
        if j <= 3 {
            j++
        } else {
            j = 0
            i++
        }

    }
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        if nodeAtPoint(touchLocation).name != nil {
            print(nodeAtPoint(touchLocation).name)
            if nodeAtPoint(touchLocation).name == "BackFromChooseBuy" {
                let scene = Settings(size:size)
                self.view?.presentScene(scene)
                return
            }
            if (nodeAtPoint(touchLocation) as! Icon).status != Status.locked {
                switch nodeAtPoint(touchLocation).name! {
                    case "question": print("question")
                    case "Bolt metal":
                        States.sharedInstance.boltType = BoltTypes.Bolt
                        loadIcons()
                    case "Bolt pink":
                        States.sharedInstance.boltType = BoltTypes.Psevdo
                        loadIcons()
                    case "Bolt dick":
                        States.sharedInstance.boltType = BoltTypes.Dick
                        loadIcons()
                    case "Bg day":
                        States.sharedInstance.bgType = BgTypes.Day
                        loadIcons()
                    case "Bg moning":
                        States.sharedInstance.bgType = BgTypes.Moning
                        loadIcons()
                    case "Bg night":
                        States.sharedInstance.bgType = BgTypes.Night
                        loadIcons()
                    default: print("tyt ne bolt")
                }
            } else {
                if let nd = nodeAtPoint(touchLocation) as? Icon {
                let scene = Buy(title: nd.nameProduct, texture: nd.texture!, boltCost: nd.priceBolt, moneyCost: nd.priceMoney, productId: nd.productId, size: size)
                self.view?.presentScene(scene)
                }
            }
            
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
