//
//  ComengSoon.swift
//  blt
//
//  Created by Илья on 26.11.15.
//  Copyright © 2015 treedeo. All rights reserved.

import SpriteKit
private let total = TotalBolts()
private let bg = Background()
private let player = Player()
class ComingSoon: SKScene {
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFill
        self.size = view.bounds.size
        let fogging = SKSpriteNode(color: SKColor(red: 82/255, green: 51/255, blue: 41/255, alpha: 0.6),size: CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        fogging.position = CGPoint(x: CGRectGetMidX(UIScreen.mainScreen().bounds), y: CGRectGetMidY(UIScreen.mainScreen().bounds))
        fogging.zPosition = 7
       

        addChild(bg)
        addChild(player)
        player.typeAnimation()
         addChild(fogging)
        fogging.addChild(total)
        
        let titleLabel = SKLabelNode(fontNamed: "Futura Md BT Bold") //надпись shop
        titleLabel.text = "COMING"
        titleLabel.position = CGPoint(x: 0, y: -70 * Controller.yScale )
        titleLabel.fontSize = 32 * Controller.xScale
        fogging.addChild(titleLabel)
        
        let titleLabel1 = SKLabelNode(fontNamed: "Futura Md BT Bold") //надпись shop
        titleLabel1.text = "SOON"
        titleLabel1.position = CGPoint(x: 0, y: -100 * Controller.yScale )
        titleLabel1.fontSize = 32 * Controller.xScale
        fogging.addChild(titleLabel1)
        
        let icon = SKSpriteNode(imageNamed: "Button question")
        Controller.changeSize(icon)
        icon.position = CGPoint(x: 0, y: CGRectGetMidY(fogging.frame) / 3)
        fogging.addChild(icon)

        let back = SKSpriteNode(imageNamed: "Button back")
        Controller.changeSize(back)
        back.position = CGPoint(x: titleLabel1.position.x, y: titleLabel1.position.y * 2)
        back.name = "back"
        fogging.addChild(back)

        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        switch self.nodeAtPoint(touchLocation).name {
        case "back"?:
            let scene = Settings()
            self.view?.presentScene(scene)
        default: break
        }

    }
}
