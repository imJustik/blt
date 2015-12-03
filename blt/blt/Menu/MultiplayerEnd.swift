import SpriteKit
class MultiplayerEnd: SKNode {
    init(flag:Bool) {  //false для поражения и true для победы
        super.init()
        let menu = SKSpriteNode(color: SKColor(red: 82/255, green: 51/255, blue: 41/255, alpha: 0.6), size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        menu.removeAllChildren()
        menu.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        menu.zPosition = 10
        
        let goLabel = SKLabelNode(fontNamed: "Futura Md BT Bold")
        if flag{
            goLabel.text = "YOU WIN"
        }
        else {
            goLabel.text = "YOU LOSE" }
        
        goLabel.position = CGPoint(x: 0, y: CGRectGetMidY(menu.frame)/3)
        menu.addChild(goLabel)
        
        let pauseLabel = SKSpriteNode(imageNamed: "Me enemy")
        pauseLabel.position = CGPoint(x: 0, y: goLabel.position.y - 30)
        menu.addChild(pauseLabel)
        
        let scoreLabel = SKLabelNode(text: String(States.sharedInstance.score))
        scoreLabel.position = CGPoint(x: pauseLabel.position.x - 50, y: pauseLabel.position.y - 45)
        scoreLabel.fontName = "Futura Md BT Bold"
        menu.addChild(scoreLabel)
        
        let recordLabel = SKLabelNode(text: String(States.sharedInstance.enemyScore))
        recordLabel.position = CGPoint(x: pauseLabel.position.x + 45, y: pauseLabel.position.y - 45)
        recordLabel.fontName = "Futura Md BT Bold"
        menu.addChild(recordLabel)
        
        let menuButton = SKSpriteNode(imageNamed: "Menu black")
        menuButton.position = CGPoint(x: 0 , y: pauseLabel.position.y - 80)
        menuButton.name = "MenuFromGameOver"
        menu.addChild(menuButton)
        
        addChild(menu)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}