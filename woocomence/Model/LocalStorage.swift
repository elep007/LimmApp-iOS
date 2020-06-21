import Foundation

struct Defaults {
    static let PRODUCTID_KEY = "PRODUCTID_ARRAY"
    static let PRODUCTASIN_KEY = "PRODUCTASIN_ARRAY"
    static let PRODUCTNAME_KEY = "PRODUCTNAME_ARRAY"
    static let PRODUCTIMAGE_KEY = "PRODUCTIMAGE_ARRAY"
    static let PRODUCTPRICE_KEY = "PRODUCTPRICE_ARRAY"
    static let PRODUCTORPRICE_KEY = "PRODUCTORPRICE_ARRAY"
    static let PRODUCTRATING_KEY = "PRODUCTRATING_ARRAY"
    static let PRODUCTREVIEWS_KEY = "PRODUCTREVIEWS_ARRAY"
    static let PRODUCTANSWERS_KEY = "PRODUCTANSWERS_ARRAY"
    static let PRODUCTDESCRIPTION_KEY = "PRODUCTDESCRIPTION_ARRAY"
    static let PRODUCTEBOOK_KEY = "PRODUCTEBOOK_ARRAY"
    static let PRODUCTMANUAL_KEY = "PRODUCTMANUAL_ARRAY"
    static let PRODUCTVIDEO_KEY = "PRODUCTVIDEO_ARRAY"
    static let PRODUCTAMAZON_KEY = "PRODUCTAMAZON_ARRAY"
    
    static func save(_ value: String, with key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getNameAndValue(_ key: String)-> String {
        return (UserDefaults.standard.value(forKey: key) as? String) ?? ""
    }
    static func clearUserData(_ key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }
}
