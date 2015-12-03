//score, pauseButton, count health
import SpriteKit

class Hud: SKNode {
    private var lblScore = SKLabelNode()
    private var health = [SKSpriteNode]()
    private var enemyHealth = [SKSpriteNode]() //для multiplay
    static var enemyScore = SKLabelNode(fontNamed: "Futura Md BT Bold")
    override init(){
      super.init()
      addPauseButton()
      addScore()
    }
    private func addPauseButton(){ //кнопка паузы
        let pauseButton = SKSpriteNode(imageNamed: "Pause black") //кнопка паузы
        Controller.changeSize(pauseButton)
        pauseButton.removeFromParent()
        pauseButton.position = CGPoint(x: CGRectGetMaxX(UIScreen.mainScreen().bounds) - 54 * Controller.xScale, y: CGRectGetMinY(UIScreen.mainScreen().bounds) + 24 * Controller.yScale)
        pauseButton.zPosition = 4
        pauseButton.name = "pauseButton"
        addChild(pauseButton)
    }
    
    private func addScore() { //добавляем счет
        lblScore = SKLabelNode(fontNamed: "Futura Md BT Bold") //счет
        lblScore.fontSize = 40
        lblScore.fontColor = SKColor.whiteColor()
        lblScore.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds)+180*Controller.yScale)
        lblScore.text = String(States.sharedInstance.score)
        addChild(lblScore)
    }
    
    func addScoreForMultiplay(){
        lblScore.removeFromParent()
        
        lblScore = SKLabelNode(fontNamed: "Futura Md BT Bold") //счет
        lblScore.fontSize = 40
        lblScore.fontColor = SKColor.whiteColor()
        lblScore.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds) - 50 * Controller.xScale, y: CGRectGetMidY(UIScreen.mainScreen().bounds)+180*Controller.yScale)
        lblScore.text = String(States.sharedInstance.score)
        addChild(lblScore)

        Hud.enemyScore = SKLabelNode(fontNamed: "Futura Md BT Bold")
        Hud.enemyScore.fontSize = 40
        Hud.enemyScore.fontColor = SKColor.whiteColor()
        Hud.enemyScore.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds) + 50 * Controller.xScale, y: CGRectGetMidY(UIScreen.mainScreen().bounds)+180*Controller.yScale)
        Hud.enemyScore.text = String(States.sharedInstance.enemyScore)
        addChild(Hud.enemyScore)
        
        
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
            Controller.changeSize(health[i])
            health[i].position = CGPoint(x: lblScore.position.x - CGFloat(firstXPosition) , y: lblScore.position.y - 10)
            health[i].zPosition = 10
            addChild(health[i])
            firstXPosition -= indent
        }

    }
    
    func removeEnemyHealth(){
        if enemyHealth.count != 0 {
            for hl in enemyHealth {
                hl.removeFromParent()
            }
        }
    }
    
    func addHealthForMultiplay(cnt: Int){ //добавляет жизни врага в мультлее
        var firstXPosition: Int = 0
        let indent = 10
        
        if cnt % 2 == 0 {  //Посчитаем смещение отноcительно Счета.
            firstXPosition = cnt / 2 * 10 - 5
        }
        else {
            firstXPosition = cnt / 2 * 10
        }
        
        removeEnemyHealth()
        enemyHealth = [SKSpriteNode]()
        
        for var i = 0; i<cnt; i++ {
            enemyHealth.append(SKSpriteNode(imageNamed: "health"))
            Controller.changeSize(enemyHealth[i])
            enemyHealth[i].position = CGPoint(x:  Hud.enemyScore.position.x - CGFloat(firstXPosition) , y:  Hud.enemyScore.position.y - 10)
            enemyHealth[i].zPosition = 10
            addChild(enemyHealth[i])
            firstXPosition -= indent
        }
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
