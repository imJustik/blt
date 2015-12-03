import SpriteKit

class ConnectMenu: SKNode {
    override init() {
        super.init()
        let menu = SKSpriteNode(color: SKColor(red: 0.553, green: 0.2553, blue: 0.1702, alpha: 0.4), size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
            menu.removeAllChildren()
        menu.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        menu.zPosition = 10
        
        let goLabel = SKLabelNode(fontNamed: "Futura Md BT Bold")
        goLabel.text = "CONNECTING"
        goLabel.position = CGPoint(x: 0, y: CGRectGetMidY(menu.frame)/3)
        menu.addChild(goLabel)
        
        let pauseLabel = SKSpriteNode(imageNamed: "Me enemy")
        pauseLabel.position = CGPoint(x: 0, y: goLabel.position.y - 30)
        menu.addChild(pauseLabel)
        
        let scoreLabel = SKLabelNode(text: "READY")
        scoreLabel.position = CGPoint(x: pauseLabel.position.x - 60, y: pauseLabel.position.y - 45)
        scoreLabel.fontSize = 25
        scoreLabel.fontName = "Futura Md BT Bold"
        menu.addChild(scoreLabel)
        
        let recordLabel = SKLabelNode(text: "...")
        recordLabel.position = CGPoint(x: pauseLabel.position.x + 55, y: pauseLabel.position.y - 45)
        recordLabel.fontName = "Futura Md BT Bold"
        menu.addChild(recordLabel)
                
        addChild(menu)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}