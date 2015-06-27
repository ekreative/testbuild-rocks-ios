//
//  AVRestKit.swift
//  AppsV2
//
//  Created by Device Ekreative on 6/27/15.
//  Copyright (c) 2015 Sergei Polishchuk. All rights reserved.
//

import Foundation
import UIKit

@objc class AVRestKit {
    class var sharedRestkit: AVRestKit {
        struct Static {
            static let instance = AVRestKit()
        }
        return Static.instance
    }
    
    let API_URL = API_BASE_URL
    
    lazy var managedObjectContext = RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext
    var pathToPersistentStore = RKApplicationDataDirectory().stringByAppendingPathComponent("AppsV2.sqlite")
    
    init(){
        let managedObjectStore = RKManagedObjectStore(managedObjectModel: NSManagedObjectModel.mergedModelFromBundles(nil))
        var error: NSError?
        if !RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error) {
            NSLog("Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error!)
            abort()
        }
        var persistentStore = managedObjectStore.addSQLitePersistentStoreAtPath(pathToPersistentStore, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: nil, error: &error)
        if persistentStore == nil {
            NSLog("Failed adding persistent store at path '%@': %@", pathToPersistentStore, error!)
            NSLog("Recreating store")
            if (!NSFileManager.defaultManager().removeItemAtPath(pathToPersistentStore, error: &error)) {
                NSLog("Failed to remove persistent store at path %@: %@", pathToPersistentStore, error!);
                abort()
            }
            
            persistentStore = managedObjectStore.addSQLitePersistentStoreAtPath(pathToPersistentStore, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: nil, error: &error)
            if persistentStore == nil {
                NSLog("Really failed adding persistent store at path '%@': %@", pathToPersistentStore, error!);
                abort();
            }
        }
        
        managedObjectStore.createManagedObjectContexts()
        
        let manager = RKObjectManager(baseURL: NSURL(string: API_URL))
        manager.managedObjectStore = managedObjectStore
        manager.requestSerializationMIMEType = RKMIMETypeJSON
        
        manager.addResponseDescriptor(RKResponseDescriptor(mapping:AVUser.mappingInStore(managedObjectStore), method: RKRequestMethod.POST, pathPattern: "login", keyPath: "user", statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful)))
        
        manager.addResponseDescriptor(RKResponseDescriptor(mapping:AVProject.mappingInStore(managedObjectStore), method: RKRequestMethod.GET, pathPattern: "api/projects.json", keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful)))
        
//        manager.addResponseDescriptor(RKResponseDescriptor(mapping:AVApp.mappingInStore(managedObjectStore), method: RKRequestMethod.GET, pathPattern: "/builds/:id.json", keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful)))
        
        manager.router.routeSet.addRoute(RKRoute(name: "api/builds/:id/ios", pathPattern: "api/builds/:id/ios", method: RKRequestMethod.GET))
        manager.addResponseDescriptor(RKResponseDescriptor(mapping: AVApp.mappingInStore(managedObjectStore), method: RKRequestMethod.GET, pathPattern: "api/builds/:id/ios", keyPath: "apps", statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful)))
        
    }
    
    func save() {
        var error: NSError?
        if !managedObjectContext.save(&error) {
            NSLog("Failed save context %@, %@", error!, error!.userInfo!);
            abort();
        }
    }
    
    class func saveContext() {
        let error = NSErrorPointer()
        RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext.saveToPersistentStore(error)
        if (error != nil) {
            println ("Save error : \(error)")
        }
    }
}
