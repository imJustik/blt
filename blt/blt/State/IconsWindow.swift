/* для добавления нового:
1) добавить переменную
2) добавить ее в массив в функции returnBolt
3) добавить в функцию reload
4) добавить обрадотку нажатия в классе ChooseBuy
*/

struct IconsWindow {
    static var Moning = ["name":"Bg moning","unlocked":true,"productId":"11test"]
    static var Day = ["name":"Bg day","unlocked":true,"productId":"22test"]
    static var Night = ["name":"Bg night","unlocked":true,"productId":"33test"]
    
    //true - элемент разблокирован
    //false - элемент заблокирован
    
    static func returnWindow() -> [[String:AnyObject]] {
        let mass : [[String:AnyObject]] = [IconsWindow.Moning,IconsWindow.Day,IconsWindow.Night]
        return mass
    }
    
    static func reload() {
        Moning = ["name":"Bg moning","unlocked":true,"productId":"11test"]
        Day = ["name":"Bg day","unlocked":true,"productId":"22test"]
        Night = ["name":"Bg night","unlocked":true,"productId":"33test"]
        
        switch States.sharedInstance.bgType {
        case BoltTypes.Bolt:
            Moning["name"] = "Bg moning black"
        case BoltTypes.Psevdo:
            Day["name"] = "Bg day black"
        case BoltTypes.Dick:
            Night["name"] = "Bg night black"
        default: break
        }
    }
}