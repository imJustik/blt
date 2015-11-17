struct BitMask {
    static let None: UInt32 = 0b0
    static let Bolt: UInt32 = 0b1 //1
    static let Foot: UInt32 = 0b10 //2
    static let upWall: UInt32 = 0b11
    static let downWall: UInt32 = 0b100
    static let ventTop: UInt32 = 0b101
    static let v2: UInt32 = 0b1000
    static let fl: UInt32 = 0b1001
    static let vv: UInt32 = 0b1010
}