import SpriteKit


class Start: SKScene {
    private var singlePlayButton = SKSpriteNode(imageNamed: "Singleplay white")
    private var multiPlayButton = SKSpriteNode(imageNamed: "Multiplay white")
    private var settingsButton = SKSpriteNode(imageNamed: "Settings white")
    private var exit = SKSpriteNode(imageNamed: "Exit")
    private let player = Player()
    private let background = Background()
    private var touchedNodeBegan:SKNode? = nil
    
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.size = view.bounds.size
         let fogging = SKSpriteNode(color: SKColor(red: 0.553, green: 0.2553, blue: 0.1702, alpha: 0.4),size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
          fogging.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        fogging.zPosition = 7
        addChild(fogging)
        addChild(background)
        addChild(player)
        player.typeAnimation()
        
        //Add buttons
        createSinglePlayButton(false)
        createMultyplayButton(false)
        createSettingsButton(false)
        createButtonExit()
    }
    

    // true что бы создать черную, false что бы создать белую
    private func createSinglePlayButton(flag: Bool)
    {
        if flag { singlePlayButton = SKSpriteNode(imageNamed: "Singleplay black") } else {
            singlePlayButton = SKSpriteNode(imageNamed: "Singleplay white")
        }
        singlePlayButton.removeFromParent()
        singlePlayButton.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds) * 1.4)
        singlePlayButton.name = "singlePlayButton"
        singlePlayButton.zPosition = 8
        addChild(singlePlayButton)
    }
    
    private func createMultyplayButton(flag: Bool){
        if flag { multiPlayButton = SKSpriteNode(imageNamed: "Multiplay black") }else {
            multiPlayButton = SKSpriteNode(imageNamed: "Multiplay white")
        }
        multiPlayButton.removeFromParent()
        multiPlayButton.position = CGPoint(x: singlePlayButton.position.x, y: singlePlayButton.position.y - 50)
        multiPlayButton.name = "multiPlayButton"
        multiPlayButton.zPosition = 8
        addChild(multiPlayButton)
    }
    
   private func createSettingsButton(flag: Bool){
        if flag { settingsButton = SKSpriteNode(imageNamed: "Settings black") }else {
            settingsButton = SKSpriteNode(imageNamed: "Settings white")
        }
        settingsButton.removeFromParent()
        settingsButton.position = CGPoint(x: multiPlayButton.position.x, y: multiPlayButton.position.y - 50)
        settingsButton.name = "settingsButton"
        settingsButton.zPosition = 8
        addChild(settingsButton)
    }
    private func createButtonExit(){
        exit.position = CGPoint(x: settingsButton.position.x, y: settingsButton.position.y - 50)
        exit.name = "exitButton"
        exit.zPosition = 8
        addChild(exit)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        touchedNodeBegan = self.nodeAtPoint(touchLocation)
        if let tNode = touchedNodeBegan {
            switch tNode.name{
            case "singlePlayButton"?:
                createSinglePlayButton(true)
            case "multiPlayButton"?:
                createMultyplayButton(true)
                // case "aboutMenu"?: startMenu.createAboutButtonButton(true)
            case "exitButton"?: UIControl().sendAction(Selector("suspend"), to: UIApplication.sharedApplication(), forEvent: nil)
            case "settingsButton"?:
                createSettingsButton(true)
            default: print("miss klick")
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        if let tNode = touchedNodeBegan {
            switch tNode.name{
            case "singlePlayButton"?:
                createSinglePlayButton(false)
                runAction(SKAction.sequence([
                    SKAction.waitForDuration(0.3),
                    SKAction.runBlock({
                        let scene = Singleplay(size: self.size)
                        self.view?.presentScene(scene)
                    })]))
                
            case "multiPlayButton"?:
                createMultyplayButton(false)
                runAction(SKAction.sequence([
                    SKAction.waitForDuration(0.3),
                    SKAction.runBlock({EasyGameCenter.findMatchWithMinPlayers(2, maxPlayers: 2)})
                    ]))
                
            case "settingsButton"?:
                createSettingsButton(false)
                let scene = Settings(size:size)
                self.view?.presentScene(scene)
            default: print("def")
            }

        }
    }
}

extension SKSpriteNode {
    func getImageName() -> String {
        let description = self.texture?.description
        var result = ""
        var index = [Int]()
        var i = 0
        for c in description!.characters { //определим индексы одинарных ковычек
            if c == "'" {
                index.append(i)
            }
            i++
        }
        for var j = index[0]+1; j < index[1]; j++ {
            result += String(description![description!.startIndex.advancedBy(j)])
        }
        return result
    }
    
}
