//
//  CoreDataService.swift
//  Final_Project_Guray
//
//  Created by Guray Demirezen on 2022-04-14.
//

import Foundation
import CoreData
class CoreDataService{
    
    static var shared = CoreDataService()
    
    // inser data to the coreData
    func  insertCounrtyInCoreData(myCountry: String, myFlag: String, myIso2: String, myPopulation: Int32){
        let newCounrty = MyFavouriteCountry(context: persistentContainer.viewContext)
        // set the properties with the values
        newCounrty.country = myCountry
        newCounrty.flag = myFlag
        newCounrty.iso2 = myIso2
        newCounrty.population = myPopulation;
        saveContext()
    }
    // return the all data from coredata
    func getAllCounrtyFromStorage()->[MyFavouriteCountry] {
        var result = [MyFavouriteCountry]()
        let photoFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MyFavouriteCountry")
        do {
            result = try (persistentContainer.viewContext.fetch(photoFetch) as? [MyFavouriteCountry])!
            
            print( result.count)
        }catch {
            print (error)
            
        }
        return result
    }
    // partial search in coredata and return matching data
    func getCountryStartWith(text: String)->[MyFavouriteCountry] {
        
        var result = [MyFavouriteCountry]()
        let fetchRequest = MyFavouriteCountry.fetchRequest()
        // fetch the data that country name matching with the pattern
        fetchRequest.predicate = NSPredicate(format: "country BEGINSWITH [c] %@ " ,text as CVarArg)
        
        do{
            result = try  persistentContainer.viewContext.fetch(fetchRequest) as [MyFavouriteCountry]
        }catch {
            print(error)
        }
        return result
    }
    // delete the data from coredata
    func deleteFromStorage(favouriteCountry: MyFavouriteCountry){
        persistentContainer.viewContext.delete(favouriteCountry)
        saveContext()
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Final_Project_Guray")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
