//
//  FavoritsDelegate.swift
//  Test1
//
//  Created by Данила Бердников on 27.08.2022.
//

import UIKit
import CoreData

class FavoritsDelegate {
    
    static let shared = FavoritsDelegate()
    
    var request: [NSManagedObject] = []
    
    var e = 0
    
    var cae : [Cast] = []
    
    var ca : Cast = Cast(title: nil, cast: nil)
    
    var casts : [Cast:Int] = [:]

    init() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCast(newCast: Cast) {
        casts[newCast] = newCast.title?.id
        saveUserData()
    }
    
    func getIdFav() -> [Int] {
        return Array(casts.values)
    }
    
    func getCast() -> [Cast] {
        return Array(casts.keys)
    }
    
    func deleteFav(deletecast: Cast) {
        for key in casts.keys{
            if key == deletecast {
                casts.removeValue(forKey: key)
            }
        }
    }
    
    func saveUserData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let context = appDelegate.persistentContainer.viewContext
       
        for castTitle in casts.keys {
            
            let newCast = NSEntityDescription.insertNewObject(forEntityName: "SavedCast", into: context)

            newCast.setValue(castTitle.title?.id, forKey: "id")
            newCast.setValue(castTitle.title?.title, forKey: "title")
            newCast.setValue(castTitle.title?.media_type, forKey: "media_type")
            newCast.setValue(castTitle.title?.backdrop_path, forKey: "backdrop_path")
            newCast.setValue(castTitle.title?.original_name, forKey: "original_name")
            newCast.setValue(castTitle.title?.poster_path, forKey: "poster_path")
            newCast.setValue(castTitle.title?.overview, forKey: "overview")
            newCast.setValue(castTitle.title?.release_date, forKey: "release_date")
            newCast.setValue(castTitle.title?.vote_average, forKey: "vote_average")
            newCast.setValue(castTitle.title?.first_air_date, forKey: "first_air_date")

        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("ERROR SACING: \(error)")
        }
       
    }
    
    func loadUserData() -> [Cast] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return []
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedCast")
        
        do {
            request = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")

        }

        for a in request {
            casts[(Cast(title: Title(id: (a.value(forKeyPath: "id") as? Int)!,
                                         title: a.value(forKeyPath: "title") as? String,
                                         media_type: a.value(forKeyPath: "media_type") as? String,
                                         backdrop_path: a.value(forKeyPath: "backdrop_path") as? String,
                                         original_name: a.value(forKeyPath: "original_name") as? String,
                                         poster_path: a.value(forKeyPath: "poster_path") as? String,
                                         overview: a.value(forKeyPath: "overview") as? String,
                                         release_date: a.value(forKeyPath: "release_date") as? String,
                                         vote_average: a.value(forKeyPath: "vote_average") as? Double,
                                         first_air_date: a.value(forKeyPath: "first_air_date") as? String), cast: nil))] = (a.value(forKeyPath: "id") as? Int)!
  
        }
        
        return Array(casts.keys)
    }
    
    
    
}
