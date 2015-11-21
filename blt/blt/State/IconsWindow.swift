/* для добавления нового:
1) добавить переменную
2) добавить ее в массив в функции returnBolt
3) добавить в функцию reload
4) добавить обрадотку нажатия в классе ChooseBuy
*/

struct IconsWindow {
    static var Moning:[String:Any] = ["name":"Moning","image":"Bg moning","status":ElementStatus.Moning,"productId":"00test","costBolt":100, "costMoney": 5]

    static var Day:[String:Any] = ["name":"Day","image":"Bg day","status":ElementStatus.Day,"productId":"01test","costBolt":900, "costMoney": 5]

    static var Night:[String:Any] = ["name":"Nught","image":"Bg night","status":ElementStatus.Night,"productId":"02test","costBolt":800, "costMoney": 6]

    
    //true - элемент разблокирован
    //false - элемент заблокирован
    
    static func returnWindow() -> [[String:Any]] {
        let mass : [[String:Any]] = [IconsWindow.Moning,IconsWindow.Day,IconsWindow.Night]
        return mass
    }
    
    static func setSelect() {
         IconsWindow.Moning["status"] = Status.open
         IconsWindow.Day["status"] = Status.open
         IconsWindow.Night["status"] = Status.open
        switch States.sharedInstance.bgType {
        case BgTypes.Moning:
            Moning["status"] = Status.select
        case BgTypes.Day:
            Day["status"] = Status.select
        case BgTypes.Night:
            Night["status"] = Status.select
        default: break
        }
    }
}