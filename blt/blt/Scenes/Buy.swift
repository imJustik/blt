import SpriteKit
import StoreKit

class Buy: SKScene {
    private let background = Background()
    private let player = Player()
    private let total = TotalBolts()
    private var title = String()
    private var texture = SKTexture()
    private var boltCost = 999
    private var moneyCost = 999
    private var productId = String()
    private var elem: Icon? = nil
    
    private var fogging = SKSpriteNode()
    
    private var icon = SKSpriteNode()
    private var empyButton = SKSpriteNode(imageNamed: "Button empty")
    private var moneyButton = SKSpriteNode(imageNamed: "Button money")
    
    private var boltCostButton = SKLabelNode(fontNamed: "Futura Md BT Medium")
    private var moneyCostButton = SKLabelNode(fontNamed: "Futura Md BT Medium")
    
    private var flag :Bool? = nil //false - болты true - деньги
    
    var transactionInProgress = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(element:Icon, size:CGSize){
        super.init(size: size)
        self.title = element.nameProduct
        self.texture = element.texture!
        self.boltCost = element.priceBolt
        self.moneyCost = element.priceMoney
        self.productId = element.productId
        self.elem = element
        Controller.elem = element
    }

   
    
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.size = view.bounds.size
        
        fogging = SKSpriteNode(color: SKColor(red: 82/255, green: 51/255, blue: 41/255, alpha: 0.6),size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
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
                        if States.sharedInstance.totalBolts >= elem?.priceBolt {
                            States.sharedInstance.totalBolts -= (elem?.priceBolt)!
                            switch elem?.nameProduct{
                                case "Bolt pink"?:
                                    States.sharedInstance.dict["Pink"] = 2
                                    ElementStatus.Psevdo = 2
                                    States.sharedInstance.saveState()
                                case "Bolt dick"?:
                                    States.sharedInstance.dict["Dick"] = 2
                                    ElementStatus.Dick = 2
                                    States.sharedInstance.saveState()
                                case "Moning"?:
                                    States.sharedInstance.dict["Moning"] = 2
                                    ElementStatus.Moning = 2
                                    States.sharedInstance.saveState()
                                case "Night"?:
                                    States.sharedInstance.dict["Night"] = 2
                                    ElementStatus.Night = 2
                                    States.sharedInstance.saveState()
                                default : print("takie dela")
                            }
                            elem!.status = 2
                            let scene = Settings(size:size)
                            self.view?.presentScene(scene)
                        }
                    } else {
                        //покупка за деньги
                        switch elem?.nameProduct{
                        case "Bolt pink"?:
                          Controller.buyProduct(Controller.productArray[6])
                        case "Bolt dick"?:
                           Controller.buyProduct(Controller.productArray[0])
                        case "Moning"?:
                            Controller.buyProduct(Controller.productArray[3])
                        case "Night"?:
                            Controller.buyProduct(Controller.productArray[4])
                        default : print("takie dela")
                            
                        }
                        
                    }
                }
            default: print("def")

        }
    }

}
