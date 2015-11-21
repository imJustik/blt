import SpriteKit

enum Status{
    case select
    case locked
    case open
    case question
}
class Icon: SKSpriteNode {
    var status = Status.open
    var image = String()
    var productId = String()
    var priceBolt = 999
    var priceMoney = 999
    var nameProduct = String()
    
    init(nameProduct:String, image: String, stat:Status, productId:String, priceBolt:Int, priceMoney:Int) {
        self.nameProduct = nameProduct
        self.status = stat
        self.productId = productId
        self.priceBolt = priceBolt
        self.priceMoney = priceMoney
        
        switch stat{
        case Status.locked:
            self.image = image + " locked"
        case Status.select:
            self.image = image + " black"
        case Status.question:
            self.image = "Button question"
        default:
            self.image = image
        }
        let texture = SKTexture(imageNamed: self.image)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        
    }
    func selectMe(){
        self.removeFromParent()
        self.status = Status.select
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
