/* для добавления нового:
1) добавить переменную
2) добавить ее в массив в функции returnBolt
3) добавить в функцию reload 
*/

class IconsBolt:Types {
    static var Bolt = ["name":"Bolt metal","unlocked":true,"productId":"11test"]
    static var Pink = ["name":"Bolt pink","unlocked":true,"productId":"22test"]
    static var Dick = ["name":"Bolt dick","unlocked":false,"productId":"33test"]
    
//true - элемент разблокирован
//false - элемент заблокирован

    static func returnBolts() -> [[String:AnyObject]] {
        let mass : [[String:AnyObject]] = [IconsBolt.Bolt,IconsBolt.Pink,IconsBolt.Dick]
    return mass
    }
    
    static func reload() {
        Bolt = ["name":"Bolt metal","unlocked":true,"productId":"11test"]
        Pink = ["name":"Bolt pink","unlocked":true,"productId":"22test"]
        Dick = ["name":"Bolt dick","unlocked":false,"productId":"33test"]
        
        switch States.sharedInstance.boltType {
        case BoltTypes.Bolt:
            Bolt["name"] = "Bolt metal black"
        case BoltTypes.Psevdo:
            Pink["name"] = "Bolt pink black"
        case BoltTypes.Dick:
            Dick["name"] = "Bolt dick black"
        default: break
        }
    }
}