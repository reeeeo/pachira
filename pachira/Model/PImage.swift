import UIKit

class PImage {
  var id: Int
  var path: String
  init(id: Int, path: String) {
    self.id = id
    self.path = path
  }
}

struct PImageManager {
  static func fetchPImages() -> [PImage] {
    let filePath = Bundle.main.path(forResource: "images", ofType: "plist")
    let dics = NSDictionary(contentsOfFile: filePath!)
    let ary = dics!["images"] as! [[String:Any]]
    return ary.map { PImage.init(id: $0["id"] as! Int, path: $0["path"] as! String) }
  }
  
  static func findPImage(by id: Int16) -> PImage {
    return self.fetchPImages().filter { $0.id == id }.first!
  }
}
