import SpriteKit
/* 
select = 0
locked = 1
open = 2
question = 3
*/

class States {
    let defaults = NSUserDefaults.standardUserDefaults()
    var score: Int = 0
    var highScore: Int
    var enemyScore: Int = 0
    var enemyHealth: Int = 1
    var flag: Bool = false
    var enemyLoose = false
    var fragReady = false
    var firstStart = false
    var countLoose = 0
    var totalBolts = 0
    var structura = ElementStatus.self
    let keychain = KeychainSwift()
    var dict: [String : AnyObject]  = ["Bolt" : 2 , "Pink":1 , "Dick" : 1, "Moning":1, "Day": 2, "Night":1, "Snow":1, "Rain":1]
    var livesCount = 3
    var buyAds = false
    
    // Types
    var boltType: String = BoltTypes.Bolt
    var bgType: String = BgTypes.Day
    var officeType: String = OfficeTypes.Office
    var playerType: String = PlayerTypes.Girl
    
    //animation
    var typeFrames: [SKTexture] = []
    var rotationFrames: [SKTexture] = []
    var culerFrames: [SKTexture] = []
    var printerFrames: [SKTexture] = []
    var dickFrames:[SKTexture] = []
    var gridFrames:[SKTexture] = []
    var gridOpenFrames:[SKTexture] = []

    class var sharedInstance: States {
        struct Singleton {
            static let instance = States()
        }
        return Singleton.instance
    }
    
    init() {
        // Init
        score = 0
        highScore = 0
        addAnimation()
       // cleanStatus() //Расскоментируй это, что бы сбрасывать покупки перед запуском
        // Load game state
        if defaults.valueForKey("boltType") != nil {
           boltType = defaults.valueForKey("boltType") as! String
        }
        if defaults.valueForKey("bgType") != nil {
           bgType = defaults.valueForKey("bgType") as! String
        }
        highScore = defaults.integerForKey("highScore")
        firstStart = defaults.boolForKey("firstFlag")
        if keychain.get("totalBolts") != nil {
            totalBolts = Int(keychain.get("totalBolts")!)!
        }
        if defaults.dictionaryForKey("EStatus") != nil {
            dict = defaults.dictionaryForKey("EStatus")!
            print(dict["Bolt"] as! Int)
        }
        buyAds = defaults.boolForKey("removeAds")
        if defaults.integerForKey("livesCount") != 0 {
        livesCount = defaults.integerForKey("livesCount")
        }
    }
    func saveState() {
        // Update highScore if the current score is greater
        highScore = max(score, highScore)
        
        // Store in user defaults
        defaults.setInteger(highScore, forKey: "highScore")
        defaults.setValue(boltType, forKey: "boltType")
        defaults.setValue(bgType, forKey:"bgType")
        defaults.setBool(firstStart, forKey: "firstFlag")
        NSUserDefaults.standardUserDefaults().synchronize()
        defaults.setObject(dict, forKey: "EStatus")
        defaults.setBool(buyAds, forKey: "removeAds")
        defaults.setInteger(livesCount, forKey: "livesCount")
    }
    func saveTotalBolts(){
        keychain.delete("totalBolts")
        keychain.set(String(totalBolts), forKey: "totalBolts")
    }
    
    func addAnimation(){
        var numImages = 0
        //MARK: анимация печати
        if playerType == PlayerTypes.Men {
        let typeAtlas = SKTextureAtlas(named: "Type_small.atlas") //загружаем анимации портала
        numImages = typeAtlas.textureNames.count
        for var i=0; i<numImages; i++ {
            let typeTextureName = "Type_\(i).png"
            typeFrames.append(typeAtlas.textureNamed(typeTextureName))
        }
        } else if playerType == PlayerTypes.Girl {
            let typeAtlas = SKTextureAtlas(named: "Girl_cicle.atlas") //загружаем анимации портала
            numImages = typeAtlas.textureNames.count
            for var i=0; i<numImages; i++ {
                let typeTextureName = "Girl_cicle_\(i).png"
                typeFrames.append(typeAtlas.textureNamed(typeTextureName))
        }
        }
        
        //MARK: анимация поворота
        if playerType == PlayerTypes.Men {
        let rotationAtlas = SKTextureAtlas(named: "Rotation_small.atlas")
        numImages = rotationAtlas.textureNames.count
        for var i=0; i<numImages; i++ {
            let rotTextureName = "Rotation_small_\(i).png"
            rotationFrames.append(rotationAtlas.textureNamed(rotTextureName))
        }
        } else if playerType == PlayerTypes.Girl {
            let rotationAtlas = SKTextureAtlas(named: "Girl.atlas")
            numImages = rotationAtlas.textureNames.count
            for var i=0; i<numImages; i++ {
                let rotTextureName = "Girl_\(i).png"
                rotationFrames.append(rotationAtlas.textureNamed(rotTextureName))
            }

        }
        //MARK: анимация куллера
        let culerAtlas = SKTextureAtlas(named: "culer.atlas")
        numImages = culerAtlas.textureNames.count
        for var i=0; i<numImages; i++ {
            let culerTextureName = "Culer_\(i).png"
            culerFrames.append(culerAtlas.textureNamed(culerTextureName))
        }
        //MARK: анимация принтера
        let printerAtlas = SKTextureAtlas(named: "printer.atlas") //загружаем анимации портала
        numImages = printerAtlas.textureNames.count
        for var i=0; i<numImages; i++ {
            let printerTextureName = "Printer_\(i).png"
            printerFrames.append(printerAtlas.textureNamed(printerTextureName))
        }
        
        //MARK: dick's animation
        let dickAtlas = SKTextureAtlas(named: "dick.atlas")
        numImages = dickAtlas.textureNames.count
        for var i=0; i<numImages; i++ {
            let dickTextureName = "Bolt_\(i).png"
            dickFrames.append(dickAtlas.textureNamed(dickTextureName))
        }
        
        //Анимация решетки
        let gridAtlas = SKTextureAtlas(named:"Grid.atlas")
        numImages = gridAtlas.textureNames.count
        for var i=1; i<numImages;i++ {
            let gridTextureName = "Grid_\(i).png"
            gridFrames.append(gridAtlas.textureNamed(gridTextureName))
        }
        gridOpenFrames = gridFrames.reverse()
    }
        func cleanStatus(){
        defaults.removeObjectForKey("EStatus")
        defaults.removeObjectForKey("removeAds")
        boltType = BoltTypes.Bolt
        bgType = BgTypes.Day
        
        //IconsBolt.setSelect()
        //IconsBolt.setSelect()
        
    }

}