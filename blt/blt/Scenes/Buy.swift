import SpriteKit

class Buy: SKScene {
    private let background = Background()
    private let player = Player()
    private let total = TotalBolts()
    private var title = String()
    private var texture = SKTexture()
    private var boltCost = 999
    private var moneyCost = 999
    private var productId = String()
    
    private var fogging = SKSpriteNode()
    
    private var icon = SKSpriteNode()
    private var empyButton = SKSpriteNode(imageNamed: "Button empty")
    private var moneyButton = SKSpriteNode(imageNamed: "Button money")
    
    private var boltCostButton = SKLabelNode(fontNamed: "Futura Md BT Medium")
    private var moneyCostButton = SKLabelNode(fontNamed: "Futura Md BT Medium")
    
    private var flag :Bool? = nil //false - болты true - деньги
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title: String, texture: SKTexture, boltCost: Int, moneyCost: Int, productId:String, size: CGSize){
        super.init(size: size)
        self.title = title
        self.texture = texture
        self.boltCost = boltCost
        self.moneyCost = moneyCost
        self.productId = productId
    }

   
    
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.size = view.bounds.size
        
        fogging = SKSpriteNode(color: SKColor(red: 0.553, green: 0.2553, blue: 0.1702, alpha: 0.4),size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        fogging.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        fogging.zPosition = 7
        addChild(fogging)
        
        fogging.addChild(total) //счет
        
        addChild(background) //фон
        addChild(player) //игрок
        player.typeAnimation()
        
        let titleLabel = SKLabelNode(fontNamed: "Futura Md BT Medium") //надпись shop
        titleLabel.text = title
        titleLabel.position = CGPoint(x: CGRectGetMinX(fogging.frame), y: CGRectGetMidY(fogging.frame)/3 )
        titleLabel.fontSize = 25
        fogging.addChild(titleLabel)
        
        icon = SKSpriteNode(texture: texture)
        icon.position = CGPoint(x: titleLabel.position.x, y: titleLabel.position.y - icon.frame.size.height/1.25)
        fogging.addChild(icon)
        
         //надпись shop
        boltCostButton.text = "BOLTS"
        boltCostButton.position = CGPoint(x: icon.position.x - 60, y: icon.position.y - 100 )
        boltCostButton.fontSize = 13
        fogging.addChild(boltCostButton)
        
        
         //надпись shop
        moneyCostButton.text = "MONEY"
        moneyCostButton.position = CGPoint(x: icon.position.x + 60, y: boltCostButton.position.y)
        moneyCostButton.fontSize = 13
        fogging.addChild(moneyCostButton)
        
        createBoltButton(false)
        createMoneyButton(false)
        addButtons()
       

    }
     private func createBoltButton(flag: Bool){
        empyButton.removeFromParent()
        if flag { empyButton = SKSpriteNode(imageNamed: "Button empty black") } else {
            empyButton = SKSpriteNode(imageNamed: "Button empty")
        }
        
        empyButton.position = CGPoint(x: boltCostButton.position.x, y: boltCostButton.position.y - 30)
        empyButton.name = "emptyButton"
        empyButton.zPosition = 8
        
        let textCostBolt = SKLabelNode(fontNamed: "Futura Md BT Bold") //надпись shop
        textCostBolt.position = CGPoint(x: 0, y: -7)
        textCostBolt.fontSize = 17
        textCostBolt.name = "emptyButton"
        textCostBolt.text = String(boltCost)
        empyButton.addChild(textCostBolt)
        fogging.addChild(empyButton)
        
    }
    
    private func createMoneyButton(flag: Bool){
        moneyButton.removeFromParent()
        if flag { moneyButton = SKSpriteNode(imageNamed: "Button money black") } else {
            moneyButton = SKSpriteNode(imageNamed: "Button money")
        }
        
            moneyButton.position = CGPoint(x: moneyCostButton.position.x, y: moneyCostButton.position.y - 30)
            moneyButton.name = "moneyButton"
            moneyButton.zPosition = 8
            
            let textMoneyBolt = SKLabelNode(fontNamed: "Futura Md BT Bold") //надпись shop
            textMoneyBolt.position = CGPoint(x: 8, y: -7)
            textMoneyBolt.fontSize = 17
            textMoneyBolt.name = "moneyButton"
            textMoneyBolt.text = String(moneyCost)
            moneyButton.addChild(textMoneyBolt)
            fogging.addChild(moneyButton)
        }
    
    private func addButtons(){
        let buyButton = SKSpriteNode(imageNamed: "Button buy")
        buyButton.position = CGPoint(x: icon.position.x, y: empyButton.position.y * 1.65)
        buyButton.name = "BuyButton"
        fogging.addChild(buyButton)
        
        let back = SKSpriteNode(imageNamed: "Button back")
        back.position = CGPoint(x: buyButton.position.x, y: buyButton.position.y * 1.7)
        back.name = "back"
        fogging.addChild(back)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
            switch self.nodeAtPoint(touchLocation).name {
            case "back"?:
                let scene = Settings()
                self.view?.presentScene(scene)
            case "emptyButton"?:
                empyButton.removeFromParent()
                createBoltButton(true)
                createMoneyButton(false)
                flag = false
            case "moneyButton"?:
                moneyButton.removeFromParent()
                createBoltButton(false)
                createMoneyButton(true)
                flag = true
            case "BuyButton"?:
                if let fl = flag {
                    if fl == false {
                        //покупка за болты
                        print("купили за болты")
                    } else {
                        //покупка за деньги
                        print("купили за деньги")
                    }
                }
            default: print("def")

        }
    }

}
