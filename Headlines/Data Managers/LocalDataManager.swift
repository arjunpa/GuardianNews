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
    
    private let realm: Realm?
    
    init?(realm: Realm? = nil) {
        guard let realm = realm else {
            self.realm = try? Realm()
            return
        }
        self.realm = realm
    }
    
    
    func read() -> [T]? {
        guard let objects = self.realm?.objects(T.self) else { return nil }
        return Array(objects)
    }
    
    func add(update: Bool = false, objects: [T]) {
        try? self.realm?.write {
            self.realm?.add(objects, update: update)
        }
    }
    
    func create(update: Bool = false, value: Any) {
        try? self.realm?.write {
            self.realm?.create(T.self, value: value, update: update)
        }
    }
}
