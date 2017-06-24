import Foundation
import UIKit

class UCNibManager : Any {
    var registeredNibs = [AnyHashable: UINib]()
    
    static let sharedInstance = UCNibManager()
    
    init() {
        registeredNibs = [AnyHashable: Any]() as! [AnyHashable : UINib]
    }
    
    func nibRegistered(forKey key: String) -> UINib {
        var nib: UINib? = nil
        let lockQueue = DispatchQueue(label: "registeredNibs()")
        lockQueue.sync {
            nib = registeredNibs[key]
        }
        return nib!
    }
    
    func register(_ nib: UINib, forKey key: String) {
        let lockQueue = DispatchQueue(label: "registeredNibs()")
        lockQueue.sync {
            registeredNibs[key] = nib
        }
    }
    
    func deregisterKey(_ key: String) {
        assert(key != "", "Invalid parameter not satisfying: key != ",file: "")
        let lockQueue = DispatchQueue(label: "registeredNibs()")
        lockQueue.sync {
            registeredNibs[key] = nil
        }
    }
}
