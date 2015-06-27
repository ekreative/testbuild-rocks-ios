private var map: RKEntityMapping?
private var onceToken: dispatch_once_t = 0

@objc(AVUser)
class AVUser: _AVUser {

    class func mappingInStore(managedObjectStore: RKManagedObjectStore) -> RKEntityMapping {
        dispatch_once(&onceToken, {
            map = RKEntityMapping(forEntityForName: self.entityName(), inManagedObjectStore: managedObjectStore)
            
            map?.addAttributeMappingsFromArray(["email", "id"])
            map?.addAttributeMappingsFromDictionary([
                "firstName":"firstname",
                "lastName":"lastname",
                "username":"login",
                "createdAt":"created",
                "lastLoginAt":"lastActive",
                "apiKey":"apiKey"
            ])
            map?.identificationAttributes = ["id"]
        })
        return map!
    }

    class func logIn(apiKey:String){
        Lockbox.setString(apiKey, forKey: "apiKey")
        Helper.setKey(apiKey)
    }
    
    class func logout(){
        RKObjectManager.sharedManager().HTTPClient.setDefaultHeader("", value: HEADER_TOKEN_KEY)
        Lockbox.setString(nil, forKey: "apiKey")
        
        Helper.setKey(nil)
        
        AVProject.removeAllProjects()
        AVUser.removeAllUsers()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.showLoginScreen()
    }
    
    class func isLoggedIn() -> Bool{
        
        var apiKey = Lockbox.stringForKey("apiKey")
        
        if apiKey != nil {
            if apiKey != "" {
                RKObjectManager.sharedManager().HTTPClient.setDefaultHeader(HEADER_TOKEN_KEY, value: apiKey!)
                return true
            }
        }
        
        return false
    }
    
    class func getCurrentUser() -> AVUser{
        var apikey = Lockbox.stringForKey("apiKey")
        
        let user = getUserByApiKey(apikey)
        
        return user
    }
    
    class func getUserByApiKey(apiKey:String) -> AVUser{
        let context = RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext
        var request = NSFetchRequest(entityName: self.entityName())
        
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        request.predicate = NSPredicate(format: "apiKey CONTAINS %@", apiKey)
        
        var error:NSError?
        
        
        var users = context.executeFetchRequest(request, error: &error) as! [AVUser]
        
        return users.last!
    }
    
    class func removeAllUsers(){
        let context = RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext
        var request = NSFetchRequest(entityName: self.entityName())
        
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        var error:NSError?
        
        var projects = context.executeFetchRequest(request, error: &error) as! [AVUser]
        
        for project in projects{
            context.deleteObject(project)
        }
    }
}
