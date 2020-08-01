
import Foundation

extension JSONDecoder {
  public class func data(fromJSONFile filename: String) -> Data? {
    do {
      if let path = Bundle.main.path(forResource: filename, ofType: "json") {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
      }
    } catch let error {
      print(error)
    }
    return nil
  }
  
  public class func object<T: Codable>(
    _ type: T.Type,
    fromJSONFile filename: String) -> T? {
    do {
      if let data = data(fromJSONFile: filename) {
        let object = try JSONDecoder().decode(type, from: data)
        return object
      }
    } catch let error {
      print(error)
    }
    return nil
  }
}
