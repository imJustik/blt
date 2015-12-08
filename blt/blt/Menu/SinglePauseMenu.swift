import SpriteKit

class SinglePauseMenu: SKNode {
    override init(){
        super.init()
        let fogging = SKSpriteNode(color: SKColor(red: 82/255, green: 51/255, blue: 41/255, alpha: 0.6), size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        fogging.removeAllChildren()
        fogging.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        fogging.zPosition = 10
        
        let pauseLabel = SKSpriteNode(imageNamed: "Score text")
        Controller.changeSize(pauseLabel)
        pauseLabel.position = CGPoint(x: 0, y: CGRectGetMidY(fogging.frame)/3)
        fogging.addChild(pauseLabel)
        
        let scoreLabel = SKLabelNode(text: String(States.sharedInstance.score))
        scoreLabel.position = CGPoint(x: pauseLabel.position.x - 50*Controller.xScale, y: pauseLabel.position.y - 45*Controller.yScale)
        scoreLabel.fontSize *= Controller.xScale
        scoreLabel.fontName = "Futura Md BT Bold"
        fogging.addChild(scoreLabel)
        
        let recordLabel = SKLabelNode(text: String(States.sharedInstance.highScore))
        recordLabel.position = CGPoint(x: pauseLabel.position.x + 45*Controller.xScale, y: pauseLabel.position.y - 45*Controller.yScale)
        recordLabel.fontSize *= Controller.xScale
        recordLabel.fontName = "Futura Md BT Bold"
        fogging.addChild(recordLabel)
        
        let playButton = SKSpriteNode(imageNamed: "Play white")
        Controller.changeSize(playButton)
        playButton.position = CGPoint(x: 0 , y: pauseLabel.position.y - 80 * Controller.yScale)
        playButton.name = "PlayFromPause"
        fogging.addChild(playButton)
        
        let menuButton = SKSpriteNode(imageNamed: "Menu black")
        Controller.changeSize(menuButton)
        menuButton.position = CGPoint(x: 0 , y: playButton.position.y - 47 * Controller.yScale)
        menuButton.name = "MenuFromPause"
        fogging.addChild(menuButton)
        
        
        addChild(fogging)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
