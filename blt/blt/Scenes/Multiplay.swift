import SpriteKit

class Multiplay: SKScene, SKPhysicsContactDelegate {
    
    private let background = Background()
    private let player = Player()
    private var win: MultiplayerEnd? = nil
    private var bolt: Bolt? = nil
    private var maxHealth = 3
    private var currentHealth = 0
    static let hud = Hud()
    private let pauseMenu = SinglePauseMenu()
    private var bolts = [Bolt]()
    private let waitMenu = ConnectMenu()
    
    
    
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.size = view.bounds.size
        Controller.timerCreateBolt?.invalidate()
        Controller.timerCreateBolt = nil
        States.sharedInstance.score = 0
        States.sharedInstance.enemyHealth = maxHealth
        States.sharedInstance.enemyScore = 0
        physicsWorld.gravity = CGVector(dx: 0, dy: -2 * Controller.yScale)
        addChild(background)
        addChild(player)
        player.startGame()
        background.startAnimation()
        
        physicsWorld.contactDelegate = self
        
        currentHealth = maxHealth
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("appBecomeActive:"), name:UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("willResignActive:"), name:UIApplicationWillResignActiveNotification, object: nil)
        
        //Отправляем пакет,сообщяюший что игнрок загрузился
        let myStruct = Packet(name: "ready", index: 3, numberOfPackets: 1)
        EasyGameCenter.sendDataToAllPlayers(myStruct.archive(), modeSend: .Reliable)
        
        addChild(waitMenu)
        
           }
    
    
    func createBolt()
    {
        bolt = Bolt(pos: CGPoint(x:0, y:  self.frame.height - (100*Controller.xScale)), impulse: CGVector(dx:
            115 * Controller.xScale, dy: 0))
        if States.sharedInstance.boltType == BoltTypes.Dick{
            bolt!.sprite.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(States.sharedInstance.dickFrames, timePerFrame: 0.075, resize: false, restore: false)), withKey: "dick")
            
        }
        addChild(bolt!)
        bolts.append(bolt!)
    }

    private func boltLeft() { // пропустил болт
        if win == nil {
            currentHealth--
            
            Multiplay.hud.removeFromParent() //обновим количество жизней
            addChild(Multiplay.hud)
            Multiplay.hud.addHealth(currentHealth)
            
            //Отправили информацию что пропустили ботл
            let myStruct = Packet(name: "EnemyLooseBolt", index: 0, numberOfPackets: 1)
            EasyGameCenter.sendDataToAllPlayers(myStruct.archive(), modeSend: .Reliable)
            
            if currentHealth == 0 {
                //background.closeGrid()
                States.sharedInstance.saveState() //сохраняем статистику
                States.sharedInstance.saveTotalBolts()
                Controller.timerCreateBolt?.invalidate()
                Controller.timerCreateBolt = nil
                
                States.sharedInstance.countLoose++ //Увеличиваем количество проигрышей(в синглтоне для того, что бы поражения в мультиплее тоже учитывались)
                
                Multiplay.hud.removeFromParent()
                
                //Удалим все болты с экрана и очистим массив
                cleanBolts()
                win = MultiplayerEnd(flag: false) //отобразим сцену проигрыша
                addChild(win!)
                
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
        if Controller.timerCreateBolt == nil {
            Controller.timerCreateBolt = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("createBolt"), userInfo: nil, repeats: true)
        }
        
        win?.removeFromParent()
        win = nil
        
        States.sharedInstance.score = 0
        currentHealth = maxHealth
        
        Multiplay.hud.removeFromParent()
        addChild(Multiplay.hud)
        Multiplay.hud.addScoreForMultiplay()
        Multiplay.hud.addHealth(currentHealth)
        Multiplay.hud.addHealthForMultiplay(States.sharedInstance.enemyHealth)
        Multiplay.hud.updateScore()
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        switch nodeAtPoint(touchLocation).name {
        case "pauseButton"?:
                if win == nil{
                    win = MultiplayerEnd(flag: false) //отобразим сцену победы
                    Controller.timerCreateBolt?.invalidate()
                    Controller.timerCreateBolt = nil
                    Multiplay.hud.removeFromParent()
                    addChild(win!)
                    let myStruct = Packet(name: "enemyExit", index: 2, numberOfPackets: 1)
                    EasyGameCenter.sendDataToAllPlayers(myStruct.archive(), modeSend: .Reliable)
            }
        case "MenuFromPause"?:
            let scene = Start(size: size)
            self.view?.presentScene(scene)
                    
        case "MenuFromGameOver"?:
            let scene = Start(size: size)
            self.view?.presentScene(scene)
            
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
            Multiplay.hud.updateScore()
            
            //Отправили информацию что забили гол
            let myStruct = Packet(name: "AddEmptyScore", index: 1, numberOfPackets: 1)
            EasyGameCenter.sendDataToAllPlayers(myStruct.archive(), modeSend: .Reliable)
        }
        
        if (firstBody.categoryBitMask == BitMask.Bolt) && ( secondBody.categoryBitMask == BitMask.fl) {
            boltLeft()
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        if States.sharedInstance.fragReady == true {
            States.sharedInstance.fragReady = false
            waitMenu.removeFromParent()
            
            runAction(SKAction.sequence([ //подождем две секунды для "запуска" болтов
                SKAction.waitForDuration(2),
                SKAction.runBlock({
                    self.repeatGame()
                })]))
        }
    
        if States.sharedInstance.enemyHealth <= 0 && States.sharedInstance.flag == false {
            if win == nil{
            win = MultiplayerEnd(flag: true) //отобразим сцену победы
            Controller.timerCreateBolt?.invalidate()
            Controller.timerCreateBolt = nil
            cleanBolts()
            Multiplay.hud.removeFromParent()
            addChild(win!)
            }
        }
        
    }
    func appBecomeActive(notification : NSNotification) {
        if win == nil {
            win = MultiplayerEnd(flag: false) //отобразим сцену победы
            Controller.timerCreateBolt?.invalidate()
            Controller.timerCreateBolt = nil
            Multiplay.hud.removeFromParent()
            addChild(win!)
            let myStruct = Packet(name: "enemyExit", index: 2, numberOfPackets: 1)
            EasyGameCenter.sendDataToAllPlayers(myStruct.archive(), modeSend: .Reliable)
        }
    }
    
    func willResignActive(notification : NSNotification){
        if win == nil {
            win = MultiplayerEnd(flag: false) //отобразим сцену победы
            Controller.timerCreateBolt?.invalidate()
            Controller.timerCreateBolt = nil
            Multiplay.hud.removeFromParent()
            addChild(win!)
            let myStruct = Packet(name: "enemyExit", index: 2, numberOfPackets: 1)
            EasyGameCenter.sendDataToAllPlayers(myStruct.archive(), modeSend: .Reliable)
        }
    }

    
    class func changeEnemyHealth(){
        hud.removeEnemyHealth()
        hud.addHealthForMultiplay(States.sharedInstance.enemyHealth)
    }
}