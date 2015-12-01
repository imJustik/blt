/* для добавления нового:
1) добавить переменную
2) добавить ее в массив в функции returnBolt
3) добавить в функцию reload 
*/

class IconsBolt {
    static var Bolt : [String:AnyObject] = ["name":"Bolt metal","image":"Bolt metal","status":(States.sharedInstance.dict["Bolt"]) as! Int,"productId":"11test","costBolt":0, "costMoney": 1]
    static var Pink : [String:AnyObject] = ["name":"Bolt pink","image":"Bolt pink","status":(States.sharedInstance.dict["Pink"]) as! Int,"productId":"22test","costBolt":200, "costMoney": 1]
    static var Dick : [String:AnyObject] = ["name":"Bolt dick","image":"Bolt dick","status":(States.sharedInstance.dict["Dick"]) as! Int,"productId":"33test","costBolt":200, "costMoney": 1]

    
//true - элемент разблокирован
//false - элемент заблокирован

    static func returnBolts() -> [[String:AnyObject]] {
        let mass : [[String:AnyObject]] = [IconsBolt.Bolt,IconsBolt.Pink,IconsBolt.Dick]
    return mass
    }
    
    static func setSelect() {
         IconsBolt.Bolt["status"] = ElementStatus.Bolt
         IconsBolt.Pink["status"] = ElementStatus.Psevdo
         IconsBolt.Dick["status"] = ElementStatus.Dick
        switch States.sharedInstance.boltType {
        case BoltTypes.Bolt:
            IconsBolt.Bolt["status"] = 0
        case BoltTypes.Psevdo:
            IconsBolt.Pink["status"] = 0
        case BoltTypes.Dick:
           IconsBolt.Dick["status"] = 0
        default: break
        }

    }
}