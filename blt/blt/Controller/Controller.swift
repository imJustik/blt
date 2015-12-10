import Foundation
import UIKit
import SpriteKit
import GameKit
import StoreKit

class Controller: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver, EasyGameCenterDelegate
    {
    static var p = SKProduct()
    var skView: SKView? = nil
    static var elem: Icon? = nil
    static var timerCreateBolt: NSTimer? = nil
    var window: UIWindow?
    let productIdentifiers = Set(["com.treedeo.remove","com.treedeo.pink","com.treedeo.dick","com.treedeo.night","com.treedeo.moning","com.treedeo.fivebolt","com.treedeo.god","com.treedeo.onebolt","com.treedeo.tenbolts"])
    var product: SKProduct?
    static var productArray = Array<SKProduct>()
    static var xScale:CGFloat = 0
    static var yScale:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        EasyGameCenter.sharedInstance(self)
        EasyGameCenter.debugMode = false
        requestProductData()
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        Controller.xScale = UIScreen.mainScreen().bounds.width / CGFloat(320.0)
        Controller.yScale = UIScreen.mainScreen().bounds.height / CGFloat(568.0)
//        switch UIScreen.mainScreen().bounds.height {
//        case 667: Controller.scaleImpulse = 0.925
//        case 736: Controller.scaleImpulse = 0.86
//        default: Controller.scaleImpulse = 1
//        }
    }
    class func changeSize(node:SKSpriteNode){
        node.size.height *= yScale
        node.size.width *= xScale
    }
    override func viewDidAppear(animated: Bool) {
        EasyGameCenter.delegate = self
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func easyGameCenterAuthentified() {
        print("\n[AuthenticationActions] Player Authentified\n")
        
    }
    
    
    func easyGameCenterNotAuthentified() {
        print("\n[AuthenticationActions] Player not authentified\n")
    }
    
    func easyGameCenterInCache() {
        print("\n[AuthenticationActions] GkAchievement & GKAchievementDescription in cache\n")
    }
    
    /**
     Match Start, Delegate Func of Easy Game Center
     */
    func easyGameCenterMatchStarted() {
        print("\n[MultiPlayerActions] Match Started !")
        (self.view as! SKView).presentScene(Multiplay())
        }
    /**
     Match Recept Data, Delegate Func of Easy Game Center
     */
    
    func easyGameCenterMatchRecept(match: GKMatch, didReceiveData data: NSData, fromPlayer playerID: String) {
        print("\n[MultiPlayerActions] Recept Data from Match !")
        
        /*
        Справочник по индексам пакетов:
        0 - противник пропустил болт
        1 - противник забил гол
        2 - противник вышел/проиграл
        3 - противник готов в игре
        */
        
        let autre =  Packet.unarchive(data)
        switch autre.index {
        case 0:
            if States.sharedInstance.enemyHealth > 0 {
                States.sharedInstance.flag = false //Флаг нужен для того, что бы не отображать сцену победы несколько раз
                States.sharedInstance.enemyHealth--
                Multiplay.changeEnemyHealth()
            } else {
               
            }
        case 1:
            States.sharedInstance.enemyScore++
            Hud.enemyScore.text =  String(States.sharedInstance.enemyScore)
            
        case 2:
           States.sharedInstance.enemyHealth = 0
            States.sharedInstance.flag = false
        case 3:
            print("Start game") // удаляем экран загрузки и начинаем
            States.sharedInstance.fragReady = true
        default: print("Oops")
        }
   }
    /**
     Match End / Error (No NetWork example), Delegate Func of Easy Game Center
     */
    func easyGameCenterMatchEnded() {
        print("\n[MultiPlayerActions] Match Ended !")
    }
    /**
     Match Cancel, Delegate Func of Easy Game Center
     */
    func easyGameCenterMatchCancel() {
        print("\n[MultiPlayerActions] Match cancel")
    }
    
    func EGCMatchEnded() {
        print("Match Ended")
    }
    /**
     Match Cancel, Delegate Func of Easy Game Center
     */
    func EGCMatchCancel() {
        print("Match Cancel")
    }

    func requestProductData(){
        if SKPaymentQueue.canMakePayments() {
            let request = SKProductsRequest(productIdentifiers: self.productIdentifiers)
            request.delegate = self
            request.start()
        } else {
            let alert = UIAlertController(title: "In-App Purchases Not Enabled", message: "Please enable In App Purchase in Settings", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: { alertAction in alert.dismissViewControllerAnimated(true, completion: nil)
                let url: NSURL? = NSURL(string: UIApplicationOpenSettingsURLString)
                if url != nil {
                    UIApplication.sharedApplication().openURL(url!)
                }
            }))
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {aletAction in alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        var products = response.products
        if products.count != 0 {
            for var i = 0; i < products.count; i++ {
                product = products[i]
                Controller.productArray.append(product!)
            }
        } else {
            print("No products found")
        }
    }
    
    // **********BUY PRODUCT************
    class func buyProduct(product: SKProduct){
        let payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment);
        Controller.p = product
    }
    
    
     func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("Received Payment Transaction Response from Apple");
        
        for transaction:AnyObject in transactions {
            let prodId = Controller.p.productIdentifier 
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .Purchased:
                    print("Product Purchased");
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                     (self.view as! SKView).presentScene(Settings())
                    switch prodId{
                    case "com.treedeo.remove":
                        States.sharedInstance.buyAds = true
                        States.sharedInstance.saveState()
                        (self.view as! SKView).presentScene(Settings())
                    case "com.treedeo.pink":
                        States.sharedInstance.dict["Pink"] = 2
                        ElementStatus.Psevdo = 2
                        States.sharedInstance.saveState()
                    case "com.treedeo.dick":
                        States.sharedInstance.dict["Dick"] = 2
                        ElementStatus.Dick = 2
                    case "com.treedeo.moning":
                        States.sharedInstance.dict["Moning"] = 2
                        ElementStatus.Moning = 2
                        States.sharedInstance.saveState()
                    case "com.treedeo.night":
                        States.sharedInstance.dict["Night"] = 2
                        ElementStatus.Night = 2
                        States.sharedInstance.saveState()
                    case "com.treedeo.onebolt":
                        States.sharedInstance.livesCount++
                        States.sharedInstance.saveState()
                    case "com.treedeo.fivebolt":
                        States.sharedInstance.livesCount+=5
                        States.sharedInstance.saveState()
                    case "com.treedeo.tenbolts":
                        States.sharedInstance.livesCount+=10
                        States.sharedInstance.saveState()
                    case "com.treedeo.god": States.sharedInstance.livesCount = 9999
                    default : print("не то купили")
                    }
                    Controller.elem?.status = 2
                    break;
                case .Failed:
                    let alert = UIAlertController(title: "Purchased Failed", message: "Transaction is canceled", preferredStyle: UIAlertControllerStyle.Alert)
                                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {aletAction in alert.dismissViewControllerAnimated(true, completion: nil)
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                    (self.view as! SKView).presentScene(Settings())
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    break;
                    // case .Restored:
                    //[self restoreTransaction:transaction];
                default:
                    break;
                }
            }
        }
    }
}
