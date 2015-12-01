/* для добавления нового:
1) добавить переменную
2) добавить ее в массив в функции returnBolt
3) добавить в функцию reload
4) добавить обрадотку нажатия в классе ChooseBuy
*/

struct IconsWindow {
    static var Day:[String:AnyObject] = ["name":"Day","image":"Bg day","status":(States.sharedInstance.dict["Day"]) as! Int,"productId":"01test","costBolt":0, "costMoney": 1]
    
    static var Moning:[String:AnyObject] = ["name":"Moning","image":"Bg moning","status":(States.sharedInstance.dict["Moning"]) as! Int,"productId":"00test","costBolt":200, "costMoney": 1]

    static var Night:[String:AnyObject] = ["name":"Night","image":"Bg night","status":(States.sharedInstance.dict["Night"]) as! Int,"productId":"02test","costBolt":220, "costMoney": 1]
    
    static var Snow:[String:AnyObject] = ["name":"Snow","image":"Bg snow","status":(States.sharedInstance.dict["Snow"]) as! Int,"productId":"00test","costBolt":0, "costMoney": 2]
    
    static var Rain:[String:AnyObject] = ["name":"Rain","image":"Bg rain","status":(States.sharedInstance.dict["Rain"]) as! Int,"productId":"01tes4","costBolt":0, "costMoney": 2]

    
    //true - элемент разблокирован
    //false - элемент заблокирован
    
    static func returnWindow() -> [[String:AnyObject]] {
        let mass : [[String:AnyObject]] = [IconsWindow.Day,IconsWindow.Moning,IconsWindow.Night,IconsWindow.Snow,IconsWindow.Rain]
        return mass
    }
    
    static func setSelect() {
         IconsWindow.Moning["status"] = ElementStatus.Moning
         IconsWindow.Day["status"] = ElementStatus.Day
         IconsWindow.Night["status"] = ElementStatus.Night
        switch States.sharedInstance.bgType {
        case BgTypes.Moning:
            Moning["status"] = 0
        case BgTypes.Day:
            Day["status"] = 0
        case BgTypes.Night:
            Night["status"] = 0
        default: break
        }
    }
}