private var map: RKEntityMapping?
private var onceToken: dispatch_once_t = 0

@objc(AVApp)
class AVApp: _AVApp {

    class func mappingInStore(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        dispatch_once(&onceToken, {
            map = RKEntityMapping(forEntityForName: self.entityName(), inManagedObjectStore: managedObjectStore)
            
            map?.addAttributeMappingsFromArray(["id", "type","plist", "qrcode", "version", "build", "name"])
            map?.addAttributeMappingsFromDictionary(["iconurl":"icon", "createdName":"creator","bundleid":"bundle", "projectid":"projectId","date":"timeCreated"])
            
            map?.addConnectionForRelationship("project", connectedBy: ["projectId":"id"])
            
            map?.identificationAttributes = ["id"]
        })
        return map!
    }

}
