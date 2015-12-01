import SpriteKit

class About: SKScene {
    let treedeo = SKSpriteNode(imageNamed: "logo Treedeo")
    let escimo = SKSpriteNode(imageNamed: "logo Escimo")
    let hud = SKSpriteNode(imageNamed: "BG text")
    let exit = SKSpriteNode(imageNamed: "About exit")
    var xScaleFactor = UIScreen.mainScreen().bounds.width / 320.0
    var yScaleFactor = UIScreen.mainScreen().bounds.height / 568.0
    var clickCounter = 0
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.size = view.bounds.size
        
                let menu = SKSpriteNode(imageNamed: "fon")
                menu.size.height *= yScaleFactor
                menu.size.width *= xScaleFactor
                menu.removeAllChildren()
                menu.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
                menu.zPosition = 10
                menu.name = "aboutFon"
                addChild(menu)
                
                hud.name = "hud"
                hud.setScale(0.7)
                hud.position = CGPoint(x: 0, y: 20 * yScaleFactor)
                changeSize(hud)
                
                menu.addChild(hud)
                treedeo.position = CGPoint(x: 0, y: -45*yScaleFactor)
                treedeo.name = "logoTreedeo"
                treedeo.zPosition = 2
                treedeo.setScale(0.35)
                changeSize(treedeo)
                menu.addChild(treedeo)
                
                escimo.position = CGPoint(x: treedeo.position.x, y: treedeo.position.y - 65 * yScaleFactor)
                escimo.name = "logoEscimo"
                escimo.zPosition = 2
                escimo.setScale(0.35)
                changeSize(escimo)
                menu.addChild(escimo)
                
                exit.position = CGPoint(x: 130 * xScaleFactor, y: -255 * yScaleFactor)
                exit.name = "exit"
                exit.zPosition = 2
                exit.setScale(0.65)
                changeSize(exit)
                menu.addChild(exit)
                //CGPoint(x: CGRectGetMaxX(menu.frame) - 150, y: CGRectGetMinY(menu.frame) + 150)
            }
    
            func changeSize(node: SKSpriteNode) { //Функция увеличиват спрайты пропорционально экрану
                node.size.width *= xScaleFactor
                node.size.height *= yScaleFactor
            }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        switch nodeAtPoint(touchLocation).name {
        case "logoTreedeo"?:
            UIApplication.sharedApplication().openURL(NSURL(string: "http://treedeo.ru")!)
        case "logoEscimo"?:
            UIApplication.sharedApplication().openURL(NSURL(string: "http://eskimodesign.ru")!)
        case "exit"?:
            let scene = Start()
            self.view?.presentScene(scene)
        default:
            if clickCounter >= 7 {
                clickCounter = 0
                let alert = UIAlertController(title: "Iliya Kuznetsov", message: "vk.com/justkim", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: { alertAction in
                    alert.dismissViewControllerAnimated(true, completion: nil)
                }))
                self.view?.window?.rootViewController!.presentViewController(alert, animated: true, completion: nil)
            } else { clickCounter++ }
        }
}
        //CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        
        

}