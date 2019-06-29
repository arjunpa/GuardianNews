//
//  Article.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import ISO8601
import Alamofire

fileprivate let APIKey = "enj8pstqu5yat6yesfsdmd39"

class Article: Object, Decodable {
    
    private enum ArticleCodingKeys: String, CodingKey {
        case id
        case webTitle
        case webPublicationDate
        case fields
    }
    
    private enum FieldsCodingKeys: String, CodingKey {
        case body
        case main
    }
    
    @objc dynamic var id: String = ""
    @objc dynamic var headline: String?
    @objc dynamic var published: Date?
    @objc dynamic var body: String?
    @objc dynamic var rawImageURL: String?
    
    override class func primaryKey() -> String? {
        return ArticleCodingKeys.id.rawValue
    }
    
    static var all: [Article] {
//        let realm = try! Realm()
//        let all = realm.objects(Article.self)
//        return Array(all)
        return LocalDataManager<Article>()!.read()!
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    init(id: String, headline: String?, published: Date?, body: String?, rawImageURL: String?) {
        super.init()
        self.id = id
        self.headline = headline
        self.published = published
        self.body = body
        self.rawImageURL = rawImageURL
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArticleCodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let headline = try container.decodeIfPresent(String.self, forKey: .webTitle)
        var published: Date?
        if let dateInString = try container.decodeIfPresent(String.self, forKey: .webPublicationDate) {
            published = NSDate(iso8601String: dateInString) as Date?
        }
        let fieldsKeyedContainer = try? container.nestedContainer(keyedBy: FieldsCodingKeys.self, forKey: .fields)
        let body = try fieldsKeyedContainer?.decodeIfPresent(String.self, forKey: .body)?.strippingTags
        let rawImageURL = try fieldsKeyedContainer?.decodeIfPresent(String.self,
                                                                    forKey: .main)?.detectedURLs?.first?.absoluteString
        self.init(id: id, headline: headline, published: published, body: body, rawImageURL: rawImageURL)
    }
}