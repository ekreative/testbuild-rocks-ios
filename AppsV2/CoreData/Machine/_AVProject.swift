// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AVProject.swift instead.

import CoreData

enum AVProjectAttributes: String {
    case created = "created"
    case descr = "descr"
    case id = "id"
    case identifier = "identifier"
    case lastUpdate = "lastUpdate"
    case name = "name"
}

enum AVProjectRelationships: String {
    case apps = "apps"
}

@objc
class _AVProject: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "Project"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _AVProject.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var created: String?

    // func validateCreated(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var descr: String?

    // func validateDescr(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var id: NSNumber?

    // func validateId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var identifier: String?

    // func validateIdentifier(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var lastUpdate: String?

    // func validateLastUpdate(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var name: String?

    // func validateName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var apps: NSSet

}

extension _AVProject {

    func addApps(objects: NSSet) {
        let mutable = self.apps.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.apps = mutable.copy() as! NSSet
    }

    func removeApps(objects: NSSet) {
        let mutable = self.apps.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.apps = mutable.copy() as! NSSet
    }

    func addAppsObject(value: AVApp!) {
        let mutable = self.apps.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.apps = mutable.copy() as! NSSet
    }

    func removeAppsObject(value: AVApp!) {
        let mutable = self.apps.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.apps = mutable.copy() as! NSSet
    }

}
