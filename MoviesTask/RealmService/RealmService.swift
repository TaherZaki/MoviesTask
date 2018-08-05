//
//  RealmService.swift
//  MoviesTask
//
//  Created by TR on 8/5/18.
//  Copyright © 2018 mine. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T , completion:@escaping (Bool) -> ()) {
        do {
            try realm.write {
                realm.add(object)
                completion(true)
                
            }
        } catch {
            
            completion(false)
            
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?] , completion:@escaping (Bool) -> ()) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
                
                completion(true)
                
            }
        } catch {
            
            completion(false)
            
        }
    }
    
    func delete<T: Object>(_ object: T , completion:@escaping (Bool) -> () ) {
        do {
            try realm.write {
                realm.delete(object)
                
                completion(true)
                
            }
        } catch {
            completion(false)
            
        }
    }
    
    
    
}

