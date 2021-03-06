import SpriteKit
import StoreKit

class Settings: SKScene {
    private let window = SKSpriteNode(imageNamed: "Button windows")
    private let bolt = SKSpriteNode(imageNamed: "Button Bolt")
    private let person = SKSpriteNode(imageNamed: "Button Person")
    private var adsOff = SKSpriteNode(imageNamed:"Button Add off")
    private let life = SKSpriteNode(imageNamed:"Button Life")
    private let office = SKSpriteNode(imageNamed:"Button Location")
    private let fogging = SKSpriteNode(color: SKColor(red: 82/255, green: 51/255, blue: 41/255, alpha: 0.6),size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
    private let background = Background()
    
    
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.size = view.bounds.size
        let player = Player()
        addChild(background)
        addChild(player)
        player.typeAnimation()
        
        
        fogging.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        fogging.zPosition = 7
       addChild(fogging)
        
        let totalBolts = TotalBolts() //количество болтов
        fogging.addChild(totalBolts)
        
        let officeLabel = SKLabelNode(fontNamed: "Futura Md BT Bold") //надпись office
        officeLabel.text = "OFFICE"
        officeLabel.fontSize = 25 * Controller.xScale
        officeLabel.position = CGPoint(x: 0, y: 100 * Controller.yScale )
        fogging.addChild(officeLabel)
        
        let shopLabel = SKLabelNode(fontNamed: "Futura Md BT Bold") //надпись shop
        shopLabel.text = "SHOP"
        shopLabel.position = CGPoint(x: officeLabel.position.x, y: officeLabel.position.y - 100 * Controller.yScale )
        shopLabel.fontSize = 25 * Controller.xScale
        fogging.addChild(shopLabel)
//назад
        let backButton = SKSpriteNode(imageNamed: "Button Back") //конпка back
        Controller.changeSize(backButton)
        backButton.position = CGPoint(x: shopLabel.position.x, y: shopLabel.position.y - 100 * Controller.yScale)
        backButton.name = "BackFromSettings"
        fogging.addChild(backButton)
        
//болт
        Controller.changeSize(bolt)
        bolt.position = CGPoint(x: officeLabel.position.x * Controller.xScale, y: officeLabel.position.y - 40 * Controller.yScale)
        bolt.name = "bolt"
        fogging.addChild(bolt)
//окно
        Controller.changeSize(window)
        window.position = CGPoint(x: bolt.position.x - 70 * Controller.xScale, y: bolt.position.y)
        window.name = "window"
        fogging.addChild(window)
//персонаж
        Controller.changeSize(person)
        person.position = CGPoint(x: bolt.position.x + 70 * Controller.xScale, y: bolt.position.y)
        person.name = "person"
        fogging.addChild(person)
//жизни
        Controller.changeSize(life)
        life.position = CGPoint(x: shopLabel.position.x, y: shopLabel.position.y - 40 * Controller.yScale)
        life.name = "life"
        fogging.addChild(life)
 //выключение рекламы
        
        if States.sharedInstance.buyAds == true {
            adsOff = SKSpriteNode(imageNamed: "Button Add off black")
        }
        Controller.changeSize(adsOff)
        adsOff.position = CGPoint(x: life.position.x - 70 * Controller.xScale, y: life.position.y)
        adsOff.name = "adsOff"
        fogging.addChild(adsOff)
// офис
        Controller.changeSize(office)
        office.position = CGPoint(x: life.position.x + 70 * Controller.xScale, y: adsOff.position.y)
        office.name = "office"
        fogging.addChild(office)
    
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var type = ProductsType.Bolt
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        switch nodeAtPoint(touchLocation).name{
        case "BackFromSettings"?:
            let scene = Start(size:size)
            self.view?.presentScene(scene)
            
        case "bolt"?:
            let scene = ChooseBuy(type: ProductsType.Bolt, count: 12, size: size)
            view?.presentScene(scene)

        case "window"?:
            let scene = ChooseBuy(type: ProductsType.Window, count: 12, size: size)
            view?.presentScene(scene)

        case "person"?:
            //let scene = ChooseBuy(type: ProductsType.Person, count: 6, size: size)
            view?.presentScene(ComingSoon())
            
        case "adsOff"?:
            guard Controller.productArray.count>0 else{
                showAllertWithTitle("Error with get products", message:"Check your internet connection")
                return
            }
            if States.sharedInstance.buyAds == false {
                adsOff.removeFromParent()
                adsOff = SKSpriteNode(imageNamed:"Button Add off black")
                Controller.changeSize(adsOff)
                adsOff.position = CGPoint(x: life.position.x - 70 * Controller.xScale, y: life.position.y)
                fogging.addChild(adsOff)
                Controller.p = Controller.productArray[7]
                Controller.buyProduct(Controller.productArray[7])
            }
            
        case "life"?:
            guard Controller.productArray.count>0 else{
                showAllertWithTitle("Error with get products", message:"Check your internet connection")
                return
            }
            let scene = BuyLifes()
            view?.presentScene(scene)
        case "top"?:
            background.vent.closeGrid()
        default:
            print("miss")
        }
    }
    
    func showAllertWithTitle(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: { alertAction in alert.dismissViewControllerAnimated(true, completion: nil)
            let url: NSURL? = NSURL(string: UIApplicationOpenSettingsURLString)
            if url != nil {
                UIApplication.sharedApplication().openURL(url!)
            }
        }))
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: {aletAction in alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.view?.window?.rootViewController!.presentViewController(alert, animated: true, completion: nil)
    }
}

//     func lockAdsButton(){
//        adsOff.removeFromParent()
//        adsOff.position = CGPoint(x: life.position.x - 70, y: life.position.y)
//        adsOff.name = "adsOff"
//        fogging.addChild(adsOff)
//    }