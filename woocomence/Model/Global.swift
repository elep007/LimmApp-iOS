class Global {
    //        static let baseUrl = "http://192.168.200.111:450/food/backend/"
    //        static let imageUrl = "http://192.168.200.111:450/food/backend/"
    static let baseUrl = "http://the-work-kw.com/limm/"
    static let imageUrl = "http://the-work-kw.com/limm/"
    
    static func validateImg(signString:String?,max:Int) -> Int {
        var temp = 0
        if signString != "" && signString != nil {
            temp = Int(signString!)!
        }
        if temp < 0 || temp > max {
            temp = 0
        }
        return temp
    }
}
