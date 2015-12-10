import UIKit
import SpriteKit
//import Appodeal
import iAd
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ADBannerViewDelegate  {
    var window: UIWindow?
    var adBannerView: ADBannerView!
    
    let controller = Controller()
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        controller.view = RootView(frame: UIScreen.mainScreen().bounds)
        controller.viewDidLoad()
        (controller.view as! SKView).presentScene(Start())
        //        Appodeal.initializeWithApiKey("4d4cb52ea7677ed29775f394be7c413f365c257e31a808ee", types: AppodealAdType.All)
        window = UIWindow(frame: controller.view.bounds)
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        if States.sharedInstance.buyAds == false {
            print("************ПОКАЗ РЕКЛАМЫ*******************")
        }
        //Appodeal.showAd(AppodealShowStyle.BannerTop, rootViewController: controller)
        
        //        adBannerView = ADBannerView(frame: CGRectZero)
        //        adBannerView.delegate = self
        //        adBannerView.hidden = true
        //        controller.view.addSubview(adBannerView)
        //        controller.canDisplayBannerAds = true
        //
        return true
    }
    
//    func applicationDidEnterBackground(application: UIApplication) { //свернули
//        if (controller.view as! SKView).scene is Singleplay {
//        Controller.timerCreateBolt?.invalidate()
//        Controller.timerCreateBolt = nil
//        }
//    }
//    
//    func applicationWillEnterForeground(application: UIApplication) { // развернули
//        if (controller.view as! SKView).scene is Singleplay {
//        (controller.view as! SKView).scene!.paused = true
//    }
//    }
//    
//    func applicationDidBecomeActive(application: UIApplication) {
//        print("n")
//
//    }
    
    func applicationWillResignActive(application: UIApplication) {
        if Controller.timerCreateBolt != nil {
        Controller.timerCreateBolt?.invalidate()
        Controller.timerCreateBolt = nil
        }
    }
    
 
}





