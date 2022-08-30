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
                
    var casts : [Int:Cast] = [:]

    init() {
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCast(new: Cast) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newCast = NSEntityDescription.insertNewObject(forEntityName: "SavedCast", into: context)
        
        
        newCast.setValue(new.title?.id, forKey: "id")
        newCast.setValue(new.title?.title, forKey: "title")
        newCast.setValue(new.title?.media_type, forKey: "media_type")
        newCast.setValue(new.title?.backdrop_path, forKey: "backdrop_path")
        newCast.setValue(new.title?.original_name, forKey: "original_name")
        newCast.setValue(new.title?.poster_path, forKey: "poster_path")
        newCast.setValue(new.title?.overview, forKey: "overview")
        newCast.setValue(new.title?.release_date, forKey: "release_date")
        newCast.setValue(new.title?.vote_average, forKey: "vote_average")
        newCast.setValue(new.title?.first_air_date, forKey: "first_air_date")

    }
    
    func getIdFav() -> [Int] {
        return Array(casts.keys)
    }
    
    
    func deleteFav(deletecast: Cast) {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                         return
                       }
                let managedContext = appDelegate.persistentContainer.viewContext
                for val in request {
                    if (val.value(forKeyPath: "id") as! Int) == deletecast.title!.id  {
                        print((val.value(forKeyPath: "id") as! Int))
                        print(deletecast.title!.id)
                        managedContext.delete(val)
                        casts.removeValue(forKey: deletecast.title!.id)
                        do {
                            try  managedContext.save()
                        } catch let error as NSError {
                            print("Could not fetch. \(error), \(error.userInfo)")

                        }
                    }
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
            casts[(a.value(forKeyPath: "id") as? Int)!] = (Cast(title: Title(id: (a.value(forKeyPath: "id") as? Int)!,
                                                                             title: a.value(forKeyPath: "title") as? String,
                                                                             media_type: a.value(forKeyPath: "media_type") as? String,
                                                                             backdrop_path: a.value(forKeyPath: "backdrop_path") as? String,
                                                                             original_name: a.value(forKeyPath: "original_name") as? String,
                                                                             poster_path: a.value(forKeyPath: "poster_path") as? String,
                                                                             overview: a.value(forKeyPath: "overview") as? String,
                                                                             release_date: a.value(forKeyPath: "release_date") as? String,
                                                                             vote_average: a.value(forKeyPath: "vote_average") as? Double,
                                                                             first_air_date: a.value(forKeyPath: "first_air_date") as? String), cast: nil))
  
        }
        
        return Array(casts.values)
    }
    
    
    
}
