//
//  Article.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import RealmSwift
import ISO8601
import Alamofire

fileprivate let APIKey = "enj8pstqu5yat6yesfsdmd39"

fileprivate extension String {
    var strippingTags: String {
        var result = self.replacingOccurrences(of: "</p> <p>", with: "\n\n") as NSString
        
        var range = result.range(of: "<[^>]+>", options: .regularExpression)
        while range.location != NSNotFound {
            result = result.replacingCharacters(in: range, with: "") as NSString
            range = result.range(of: "<[^>]+>", options: .regularExpression)
        }
        
        return result as String
    }
    
    var url: URL? {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: (self as NSString).length))
        return matches.first?.url
    }
}

class Article: Object {
    @objc dynamic var headline = ""
    @objc dynamic var body = ""
    @objc dynamic var published: Date?
    @objc dynamic var id: String?
    @objc private dynamic var rawImageURL: String?
    var imageURL: URL? {
        guard let rawImageURL = rawImageURL else { return nil }
        return URL(string: rawImageURL)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static var all: [Article] {
//        let realm = try! Realm()
//        let all = realm.objects(Article.self)
//        return Array(all)
        return LocalDataManager<Article>()!.read()!
    }
    
    convenience init?(dictionary: [String : Any]) {
        self.init()
        
        headline = dictionary["webTitle"] as? String ?? ""
        
        id = dictionary["id"] as? String
        
        if let publicationDate = dictionary["webPublicationDate"] as? String {
            published = NSDate(iso8601String: publicationDate) as Date?
        }
        
        guard let fields = dictionary["fields"] as? [String: String] else { return }
        body = fields["body"]?.strippingTags ?? ""
        rawImageURL = fields["main"]?.url?.absoluteString
    }
}
