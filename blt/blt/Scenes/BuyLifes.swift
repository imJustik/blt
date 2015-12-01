//Задал тут все на прямую в лоб копипастом, не стал усложнять.
import SpriteKit

class BuyLifes: SKScene {
    private let player  = Player()
    private let bg = Background()
    private let total = TotalBolts()
    
    private var oneLife = SKSpriteNode(imageNamed: "Button 1 life")
    private var fiveLife = SKSpriteNode(imageNamed: "Button 5 life")
    private var tenLife = SKSpriteNode(imageNamed: "Button 10 life")
    private var godLife = SKSpriteNode(imageNamed: "Button life")
    
    private let dash = SKSpriteNode(imageNamed: "dash")
    private let dash1 = SKSpriteNode(imageNamed: "dash")
    private let dash2 = SKSpriteNode(imageNamed: "dash")
    private let dash3 = SKSpriteNode(imageNamed: "dash")
    
    
    private var oneCost = SKSpriteNode(imageNamed: "Button money")
    private var fiveCost = SKSpriteNode(imageNamed: "Button money")
    private var tenCost = SKSpriteNode(imageNamed: "Button money")
    private var godCost = SKSpriteNode(imageNamed: "Button money")
    
    private var select  = false
    
    let fogging = SKSpriteNode(color: SKColor(red: 82/255, green: 51/255, blue: 41/255, alpha: 0.6),size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))

    
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.size = view.bounds.size
        
        fogging.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        fogging.zPosition = 7
        addChild(bg)
        addChild(player)
        player.typeAnimation()
        addChild(fogging)
        //количество болтов
        oneLife.name = "oneLife"
        oneLife.position = CGPoint(x: -66, y: 130)
        fogging.addChild(oneLife)
        
        fiveLife.name = "fiveLife"
        fiveLife.position = CGPoint(x: oneLife.position.x, y: oneLife.position.y - 75)
        fogging.addChild(fiveLife)
        
        tenLife.name = "tenLife"
        tenLife.position = CGPoint(x: fiveLife.position.x, y: fiveLife.position.y - 75)
        fogging.addChild(tenLife)
        
        godLife.name = "godLife"
        godLife.position = CGPoint(x: tenLife.position.x, y: tenLife.position.y - 75)
        fogging.addChild(godLife)
        
         //палочки
        dash.position = CGPoint(x: oneLife.position.x + 60, y: oneLife.position.y)
        fogging.addChild(dash)
        
        dash1.position = CGPoint(x: fiveLife.position.x + 60, y: fiveLife.position.y)
        fogging.addChild(dash1)
        
        dash2.position = CGPoint(x: tenLife.position.x + 60, y: tenLife.position.y)
        fogging.addChild(dash2)
        
        dash3.position = CGPoint(x: godLife.position.x + 60, y: godLife.position.y)
        fogging.addChild(dash3)
        
        //стоймость
        
        oneCost.position = CGPoint(x: dash.position.x + 60, y: dash.position.y)
        oneCost.name  = "oneLife"
        fogging.addChild(oneCost)
        
        fiveCost.position = CGPoint(x: dash1.position.x + 60, y: dash1.position.y)
        fiveCost.name = "fiveLife"

        fogging.addChild(fiveCost)
        
        tenCost.position = CGPoint(x: dash2.position.x + 60, y: dash2.position.y)
        tenCost.name = "tenLife"

        fogging.addChild(tenCost)
        
        
        godCost.position = CGPoint(x: dash3.position.x + 60, y: dash3.position.y)
        godCost.name = "godLife"
  
        fogging.addChild(godCost)
        
        let back = SKSpriteNode(imageNamed: "Button back")
        back.position = CGPoint(x: dash3.position.x, y: dash3.position.y * 2)
        back.name = "back"
        fogging.addChild(back)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        if select == false {
        switch nodeAtPoint(touchLocation).name {
        case "oneLife"?:
            //oneLife.removeFromParent()
            oneCost.removeFromParent()
            oneLife = SKSpriteNode(imageNamed: "Button 1 life black")
            oneCost = SKSpriteNode(imageNamed: "Button money black")
            oneLife.position = CGPoint(x: -66, y: 130)
           // fogging.addChild(oneLife)
            
            oneCost.position = CGPoint(x: dash.position.x + 60, y: dash.position.y)
            fogging.addChild(oneCost)
            Controller.p = Controller.productArray[5]
            Controller.buyProduct(Controller.productArray[5])
            select = true
            
            
        case "fiveLife"?:
            //oneLife.removeFromParent()
            fiveCost.removeFromParent()
            fiveLife = SKSpriteNode(imageNamed: "Button 1 life black")
            fiveCost = SKSpriteNode(imageNamed: "Button money black")
            fiveLife.position = CGPoint(x: -66, y: 130)
            // fogging.addChild(oneLife)
            fiveCost.position = CGPoint(x: dash1.position.x + 60, y: dash1.position.y)
            fogging.addChild(fiveCost)
            Controller.p = Controller.productArray[1]
            Controller.buyProduct(Controller.productArray[1])
            select = true
        case "tenLife"?:
            //oneLife.removeFromParent()
            tenCost.removeFromParent()
            tenLife = SKSpriteNode(imageNamed: "Button 1 life black")
            tenCost = SKSpriteNode(imageNamed: "Button money black")
            tenLife.position = CGPoint(x: -66, y: 130)
            // fogging.addChild(oneLife)
            
            tenCost.position = CGPoint(x: dash2.position.x + 60, y: dash2.position.y)
            fogging.addChild(tenCost)
            Controller.p = Controller.productArray[8]
            Controller.buyProduct(Controller.productArray[8])
            select = true
        case "godLife"?:
            //oneLife.removeFromParent()
            godCost.removeFromParent()
            godLife = SKSpriteNode(imageNamed: "Button 1 life black")
            godCost = SKSpriteNode(imageNamed: "Button money black")
            godLife.position = CGPoint(x: -66, y: 130)
            // fogging.addChild(oneLife)
            
            godCost.position = CGPoint(x: dash3.position.x + 60, y: dash3.position.y)
            fogging.addChild(godCost)
            Controller.p = Controller.productArray[2]
            Controller.buyProduct(Controller.productArray[2])
            select = true
            
        case "back"?:
            self.view?.presentScene(Settings())
        default: break;
            }
        }
    }
}