private var map: RKEntityMapping?
private var onceToken: dispatch_once_t = 0

@objc(AVProject)
class AVProject: _AVProject {
    
    class func mappingInStore(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        dispatch_once(&onceToken, {
            map = RKEntityMapping(forEntityForName: self.entityName(), inManagedObjectStore: managedObjectStore)
            
            map?.addAttributeMappingsFromArray(["id", "name", "identifier"])
            map?.addAttributeMappingsFromDictionary(["created_on":"created"])
            
            map?.identificationAttributes = ["id"]
        })
        return map!
    }
    
    class func removeAllProjects(){
        let context = RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext
        var request = NSFetchRequest(entityName: self.entityName())
        
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        var error:NSError?
        
        var projects = context.executeFetchRequest(request, error: &error) as! [AVProject]
        
        for project in projects{
            context.deleteObject(project)
        }
    }
    
}