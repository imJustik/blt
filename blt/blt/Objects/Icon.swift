import SpriteKit

//enum Status:Int{
//    case select = 0
//    case locked = 1
//    case open = 2
//    case question = 3
//}
class Icon: SKSpriteNode {
    var status:Int = 0
    var image = String()
    var productId = String()
    var priceBolt = 999
    var priceMoney = 999
    var nameProduct = String()
    
    init(nameProduct:String, image: String, stat:Int, productId:String, priceBolt:Int, priceMoney:Int) {
        self.nameProduct = nameProduct
        self.status = stat
        self.productId = productId
        self.priceBolt = priceBolt
        self.priceMoney = priceMoney
        
        switch stat{
        case 1:
            self.image = image + " locked"
        case 0:
            self.image = image + " black"
        case 3:
            self.image = "Button question"
        default:
            self.image = image
        }
        let texture = SKTexture(imageNamed: self.image)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        
    }
    func selectMe(){
        self.removeFromParent()
        self.status = 0
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
