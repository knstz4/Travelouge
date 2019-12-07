import CoreData
import UIKit

@objc(Entry)
public class Entry: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    
    var image: UIImage? {
        get {
            if let imageData = rawImage as Data? {
                return UIImage(data: imageData)
            }
            return nil
        }
        set {
            let imageData = newValue!.pngData() as NSData?
            rawImage = imageData
        }
    }
    
    convenience init?(title: String?, content: String?, date: Date, image: UIImage?) {
        let appDelegate  = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Entry.entity(), insertInto: managedContext)
        
        self.title = title
        self.content = content
        self.date = date
        self.image = image
    }
}
