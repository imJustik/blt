import SpriteKit

class SinglePauseMenu: SKNode {
    override init(){
        super.init()
        let fogging = SKSpriteNode(color: SKColor(red: 0.553, green: 0.2553, blue: 0.1702, alpha: 0.4), size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        fogging.removeAllChildren()
        fogging.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        fogging.zPosition = 10
        
        let pauseLabel = SKSpriteNode(imageNamed: "Score text")
        pauseLabel.position = CGPoint(x: 0, y: CGRectGetMidY(fogging.frame)/3)
        fogging.addChild(pauseLabel)
        
        let scoreLabel = SKLabelNode(text: String(States.sharedInstance.score))
        scoreLabel.position = CGPoint(x: pauseLabel.position.x - 50, y: pauseLabel.position.y - 45)
        scoreLabel.fontName = "Futura Md BT Bold"
        fogging.addChild(scoreLabel)
        
        let recordLabel = SKLabelNode(text: String(States.sharedInstance.highScore))
        recordLabel.position = CGPoint(x: pauseLabel.position.x + 45, y: pauseLabel.position.y - 45)
        recordLabel.fontName = "Futura Md BT Bold"
        fogging.addChild(recordLabel)
        
        let playButton = SKSpriteNode(imageNamed: "Play white")
        playButton.position = CGPoint(x: 0 , y: pauseLabel.position.y - 80)
        playButton.name = "PlayFromPause"
        fogging.addChild(playButton)
        
        let menuButton = SKSpriteNode(imageNamed: "Menu black")
        menuButton.position = CGPoint(x: 0 , y: playButton.position.y - 47)
        menuButton.name = "MenuFromPause"
        fogging.addChild(menuButton)
        
        
        addChild(fogging)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
