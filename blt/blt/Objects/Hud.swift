//score, pauseButton, count health
import SpriteKit

class Hud: SKNode {
    private var lblScore = SKLabelNode()
    private var health = [SKSpriteNode]()
    override init(){
      super.init()
      addPauseButton()
      addScore()
    }
    private func addPauseButton(){ //кнопка паузы
        let pauseButton = SKSpriteNode(imageNamed: "Pause black") //кнопка паузы
        pauseButton.removeFromParent()
        pauseButton.position = CGPoint(x: CGRectGetMaxX(UIScreen.mainScreen().bounds) - 54, y: CGRectGetMinY(UIScreen.mainScreen().bounds) + 24)
        pauseButton.zPosition = 4
        pauseButton.name = "pauseButton"
        addChild(pauseButton)
    }
    
    private func addScore() { //добавляем счет
        lblScore = SKLabelNode(fontNamed: "Futura Md BT Bold") //счет
        lblScore.fontSize = 40
        lblScore.fontColor = SKColor.whiteColor()
        lblScore.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds)+180)
        lblScore.text = String(States.sharedInstance.score)
        addChild(lblScore)
    }
     func updateScore(){
        lblScore.text = String(States.sharedInstance.score)
    }
    
    func addHealth(cnt: Int){
        var firstXPosition: Int = 0
        let indent = 10
        
        if cnt % 2 == 0 {  //Посчитаем смещение отночительно lblScore.
            firstXPosition = cnt / 2 * 10 - 5
        }
        else {
            firstXPosition = cnt / 2 * 10
        }
        
        if health.count != 0 {  //Если массив уже содержит элементы, то удалим их с экрана
            for hl in health {
                hl.removeFromParent()
            }
        }
        health = [SKSpriteNode]() //Очистим массив
        
        for var i = 0; i<cnt; i++ {
            health.append(SKSpriteNode(imageNamed: "health"))
            health[i].position = CGPoint(x: lblScore.position.x - CGFloat(firstXPosition) , y: lblScore.position.y - 10)
            health[i].zPosition = 10
            addChild(health[i])
            firstXPosition -= indent
        }

    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}