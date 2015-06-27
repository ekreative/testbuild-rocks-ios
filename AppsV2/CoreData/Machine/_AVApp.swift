// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AVApp.swift instead.

import CoreData

enum AVAppAttributes: String {
    case build = "build"
    case bundle = "bundle"
    case creator = "creator"
    case icon = "icon"
    case id = "id"
    case name = "name"
    case plist = "plist"
    case projectId = "projectId"
    case qrcode = "qrcode"
    case timeCreated = "timeCreated"
    case type = "type"
    case url = "url"
    case version = "version"
}

enum AVAppRelationships: String {
    case project = "project"
}

@objc
class _AVApp: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "App"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _AVApp.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var build: String?

    // func validateBuild(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var bundle: String?

    // func validateBundle(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var creator: String?

    // func validateCreator(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var icon: String?

    // func validateIcon(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var id: NSNumber?

    // func validateId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var name: String?

    // func validateName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var plist: String?

    // func validatePlist(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var projectId: NSNumber?

    // func validateProjectId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var qrcode: String?

    // func validateQrcode(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var timeCreated: NSNumber?

    // func validateTimeCreated(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var type: String?

    // func validateType(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var url: String?

    // func validateUrl(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var version: String?

    // func validateVersion(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var project: AVProject?

    // func validateProject(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

}

