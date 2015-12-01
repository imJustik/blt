
import SpriteKit

class TotalBolts: SKNode {
    override init() {
        super.init()
        let totalBolts = SKLabelNode(fontNamed: "Futura Md BT Medium")
        totalBolts.text = "TOTAL BOLTS"
        totalBolts.position =  CGPoint(x: 0, y: CGRectGetMidY(UIScreen.mainScreen().bounds)/1.5)
        totalBolts.fontSize = 20
        addChild(totalBolts)
        
        let countTotal = SKLabelNode(fontNamed: "Futura Md BT Bold")
        countTotal.text = String(States.sharedInstance.totalBolts)
        countTotal.position = CGPoint(x: totalBolts.position.x, y: totalBolts.position.y - 25*Controller.yScale)
        countTotal.fontSize = 23
        addChild(countTotal)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }

}
