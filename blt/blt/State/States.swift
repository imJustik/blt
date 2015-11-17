import SpriteKit

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
    
    // Types 
    var boltType: String = BoltTypes.Bolt
    var bgType: String = BgTypes.Day
    var officeType: String = OfficeTypes.Office
    var playerType: String = PlayerTypes.Men
    
    //animation
    var typeFrames: [SKTexture] = []
    var rotationFrames: [SKTexture] = []
    var culerFrames: [SKTexture] = []
    var printerFrames: [SKTexture] = []
    var dickFrames:[SKTexture] = []
    var gridFrames:[SKTexture] = []

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
        
        // Load game state
        if defaults.valueForKey("boltType") != nil {
           boltType = defaults.valueForKey("boltType") as! String
        }
        if defaults.valueForKey("bgType") != nil {
           bgType = defaults.valueForKey("bgType") as! String
        }
        highScore = defaults.integerForKey("highScore")
        firstStart = defaults.boolForKey("firstFlag")
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
    }
    
    func addAnimation(){
        //MARK: анимация печати
        let typeAtlas = SKTextureAtlas(named: "Type_small.atlas") //загружаем анимации портала
        var numImages = typeAtlas.textureNames.count
        for var i=0; i<numImages; i++ {
            let typeTextureName = "Type_\(i).png"
            typeFrames.append(typeAtlas.textureNamed(typeTextureName))
        }
        
        //MARK: анимация поворота
        let rotationAtlas = SKTextureAtlas(named: "Rotation_small.atlas")
        numImages = rotationAtlas.textureNames.count
        for var i=0; i<numImages; i++ {
            let rotTextureName = "Rotation_small_\(i).png"
            rotationFrames.append(rotationAtlas.textureNamed(rotTextureName))
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
    }
    

}