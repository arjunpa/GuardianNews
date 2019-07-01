//
//  LocalDataManager.swift
//  Headlines
//
//  Created by Arjun P A on 26/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import RealmSwift

final class LocalDataManager<T: Object> {
    
    enum Operations {
        case sort(ascending: Bool, keyPath: String)
        case filter(query: String)
    }
    
    private let realm: Realm?
    
    /**
     Initializes the manager with a realm object. Defaults to the default instance
    
     - Parameter realm: The realm object
    */
    init?(realm: Realm? = nil) {
        guard let realm = realm else {
            self.realm = try? Realm()
            return
        }
        self.realm = realm
    }
    
    /**
     Read from the database and perform operations on the results.
    
     - Parameter operations: The operations that need to performed on the results
     - Returns: The array of corresponding objects.
    */
    func read(with operations: [Operations]) -> [T]? {
        guard var objects = self.realm?.objects(T.self) else { return nil }
        guard !operations.isEmpty else { return Array(objects) }
        for operation in operations {
            switch operation {
            case .filter(let query):
                objects = objects.filter(query)
            case .sort(let ascending, let keyPath):
                objects = objects.sorted(byKeyPath: keyPath, ascending: ascending)
            }
        }
        return Array(objects)
    }
    
    /**
     Read from the database using query and arguments
    
     - Parameters:
       - query: The query to be used.
       - args: The arguments that go with the query.
     - Returns: The array of corresponding objects.
    */
    func read(with query: String, args: Any...) -> [T]? {
        guard let objects = self.realm?.objects(T.self).filter(query, args) else { return nil }
        return Array(objects)
    }
    
    /**
     Read everything from the database relating to the type.
    
     - Returns: The array of corresponding objects.
    */
    func read() -> [T]? {
        guard let objects = self.realm?.objects(T.self) else { return nil }
        return Array(objects)
    }
    
    /**
     Add objects to the database
    
     - Parameters:
       - update: If true, objects that are already in the database will be updated instead of added anew.
       - objects: The array of corresponding objects.
    */
    func add(update: Bool = false, objects: [T]) {
        try? self.realm?.write {
            self.realm?.add(objects, update: update)
        }
    }
    
    /**
     Creates or peform partial updates a object on the database with a given values.
    
     - Parameters:
       - update: If true, objects that are already in the database will be updated instead of added anew.
       - value: The values corresponding to the object.
    */
    func create(update: Bool = false, value: Any) {
        try? self.realm?.write {
            self.realm?.create(T.self, value: value, update: update)
        }
    }
    
    /**
     Perform updates to the object on the database using block.
    
     - Parameter block: The block.
    */
    func update(with block: () -> Void) {
        try? self.realm?.write {
            block()
        }
    }
}
