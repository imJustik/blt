import SpriteKit

class Singleplay: SKScene, SKPhysicsContactDelegate {
    private let background = Background()
    private let player = Player()
    private var timerCreateBolt: NSTimer? = nil
    private var gameOver: SingleGameOver? = nil
    private var bolt: Bolt? = nil
    private var maxHealth = 1
    private var currentHealth = 0
    private let hud = Hud()
    private let pauseMenu = SinglePauseMenu()
    private var bolts = [Bolt]()
    
    
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.size = view.bounds.size
        States.sharedInstance.score = 0
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        addChild(background)
        addChild(player)
        player.startGame()
        background.startAnimation()
        
        physicsWorld.contactDelegate = self
        
        currentHealth = maxHealth
        
        runAction(SKAction.sequence([ //подождем две секунды для "запуска" болтов
            SKAction.waitForDuration(2),
            SKAction.runBlock({
               self.repeatGame()
            })]))
    }
    
    
    func createBolt()
    {
        bolt = Bolt(pos: CGPoint(x:0, y:  self.frame.height - 100), impulse: CGVector(dx: 115, dy: 0))
        if States.sharedInstance.boltType == BoltTypes.Dick{
        bolt!.sprite.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(States.sharedInstance.dickFrames, timePerFrame: 0.075, resize: false, restore: false)), withKey: "dick")
            
        }
        addChild(bolt!)
        bolts.append(bolt!)
    }
    
    private func boltLeft() { // пропустил болт
        if gameOver == nil {
            currentHealth--
            
            hud.removeFromParent() //обновим количество жизней
            addChild(hud)
            hud.addHealth(currentHealth)
            
            if currentHealth == 0 {
                //background.closeGrid()
                States.sharedInstance.saveState() //сохраняем статистику
                States.sharedInstance.saveTotalBolts()
                timerCreateBolt?.invalidate()
                timerCreateBolt = nil
                
                States.sharedInstance.countLoose++ //Увеличиваем количество проигрышей(в синглтоне для того, что бы поражения в мультиплее тоже учитывались)
                
                hud.removeFromParent()
                
                //Удалим все болты с экрана и очистим массив
                cleanBolts()
                gameOver = SingleGameOver() //отобразим сцену проигрыша
                addChild(gameOver!)
                
                if  (States.sharedInstance.countLoose  == 5) {
                    //    Appodeal.showAd(AppodealShowStyle.Interstitial, rootViewController: self.view?.window?.rootViewController)
                    States.sharedInstance.countLoose = 0
                }
            }
        }
    }
    
    private func cleanBolts(){
        if bolts.count > 0 {
            for blt in bolts {
                blt.removeFromParent()
            }
            bolts = [Bolt]()
        }

    }
    
    private func repeatGame(){
        cleanBolts()
        if timerCreateBolt == nil {
            timerCreateBolt = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("createBolt"), userInfo: nil, repeats: true)
        }
        
        gameOver?.removeFromParent()
        gameOver = nil
        
        States.sharedInstance.score = 0
        currentHealth = maxHealth
        
        hud.removeFromParent()
        addChild(hud)
        hud.addHealth(currentHealth)
        hud.updateScore()
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        switch nodeAtPoint(touchLocation).name {
        case "pauseButton"?:
            addChild(pauseMenu)
            self.paused = true
            timerCreateBolt?.invalidate()
            timerCreateBolt = nil
        case "MenuFromPause"?:
            let scene = Start(size: size)
            self.view?.presentScene(scene)
        case "PlayFromPause"?:
            pauseMenu.removeFromParent()
            self.paused = false
            if timerCreateBolt == nil {
                timerCreateBolt = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("createBolt"), userInfo: nil, repeats: true)
            }
        case "RepeateFromGameOver"?:
            repeatGame()
        default:
            player.kick()
            }
        }
    
    func didBeginContact(contact: SKPhysicsContact){
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if (firstBody.categoryBitMask == BitMask.Bolt) && ( secondBody.categoryBitMask == BitMask.Foot) {
            if player.foot.actionForKey("move") != nil {
                let other = firstBody.node as! GameObjects
                other.collision(self)
            }
            //firstBody - bolt
            //secondBody - foot
        }
        
        if (firstBody.categoryBitMask == BitMask.Bolt) && ( secondBody.categoryBitMask == BitMask.upWall) {
            
        }
        
        if (firstBody.categoryBitMask == BitMask.Bolt) && ( secondBody.categoryBitMask == BitMask.ventTop) {
            if firstBody.node?.position.y < background.vent.top.position.y + 20 {
                firstBody.velocity = CGVector(dx: 100, dy: -30)
            }
        }
        
        if (firstBody.categoryBitMask == BitMask.Bolt) && ( secondBody.categoryBitMask == BitMask.v2) {
            States.sharedInstance.score++
            States.sharedInstance.totalBolts++
            hud.updateScore()
        }
        
        if (firstBody.categoryBitMask == BitMask.Bolt) && ( secondBody.categoryBitMask == BitMask.fl) {
            boltLeft()
        }
    
    }
}