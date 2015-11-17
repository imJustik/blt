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
        (controller.view as! SKView).presentScene(Singleplay())
        //        Appodeal.initializeWithApiKey("4d4cb52ea7677ed29775f394be7c413f365c257e31a808ee", types: AppodealAdType.All)
        window = UIWindow(frame: controller.view.bounds)
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        //Appodeal.showAd(AppodealShowStyle.BannerTop, rootViewController: controller)
        
        //        adBannerView = ADBannerView(frame: CGRectZero)
        //        adBannerView.delegate = self
        //        adBannerView.hidden = true
        //        controller.view.addSubview(adBannerView)
        //        controller.canDisplayBannerAds = true
        //
        controller.viewDidLoad()
        return true
    }
    
    
}




