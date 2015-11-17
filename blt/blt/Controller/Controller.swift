import Foundation
import UIKit
import SpriteKit
import GameKit
import StoreKit

class Controller: UIViewController, EasyGameCenterDelegate, SKProductsRequestDelegate
    {
    var skView: SKView? = nil
    var window: UIWindow?
    let productIdentifiers = Set(["com.treedeo.remove"])
    var product: SKProduct?
    var productArray = Array<SKProduct>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EasyGameCenter.sharedInstance(self)
        EasyGameCenter.debugMode = true
        requestProductData()
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
                States.sharedInstance.flag = false
                States.sharedInstance.enemyHealth--
            } else {
                //конец игры
            }
        case 1: States.sharedInstance.enemyScore++
            
        case 2:
            States.sharedInstance.enemyLoose = true
            //конец игры
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
                self.product = products[i]
                self.productArray.append(product!)
            }
        } else {
            print("No products found")
        }
    }
    
}


