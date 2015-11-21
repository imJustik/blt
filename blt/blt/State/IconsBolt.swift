/* для добавления нового:
1) добавить переменную
2) добавить ее в массив в функции returnBolt
3) добавить в функцию reload 
*/

class IconsBolt {
    static var Bolt : [String:Any] = ["name":"Bolt metal","image":"Bolt metal","status":ElementStatus.Bolt,"productId":"11test","costBolt":100, "costMoney": 5]
    static var Pink : [String:Any] = ["name":"Bolt metal","image":"Bolt pink","status":ElementStatus.Psevdo,"productId":"22test","costBolt":200, "costMoney": 5]
    static var Dick : [String:Any] = ["name":"Bolt metal","image":"Bolt dick","status":ElementStatus.Dick,"productId":"33test","costBolt":300, "costMoney": 5]

    
//true - элемент разблокирован
//false - элемент заблокирован

    static func returnBolts() -> [[String:Any]] {
        let mass : [[String:Any]] = [IconsBolt.Bolt,IconsBolt.Pink,IconsBolt.Dick]
    return mass
    }
    
    static func setSelect() {
         IconsBolt.Bolt["status"] = Status.open
         IconsBolt.Pink["status"] = Status.open
         IconsBolt.Dick["status"] = Status.locked
        switch States.sharedInstance.boltType {
        case BoltTypes.Bolt:
            IconsBolt.Bolt["status"] = Status.select
        case BoltTypes.Psevdo:
            IconsBolt.Pink["status"] = Status.select
        case BoltTypes.Dick:
           IconsBolt.Dick["status"] = Status.select
        default: break
        }

    }
}