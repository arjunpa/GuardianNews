//
//  String+SanitizeHTML.swift
//  Headlines
//
//  Created by Arjun P A on 28/06/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

extension String {
    
    private static let paragraphTags = "</p> <p>"
    private static let newLineCharacters = "\n\n"
    private static let tagSearchRegex  = "<[^>]+>"
    
    var strippingTags: String {
        let typeSelf = type(of: self)
        var resultantString = self.replacingOccurrences(of: typeSelf.paragraphTags, with: typeSelf.newLineCharacters)
        
        var range: Range<String.Index>? = resultantString.range(of: typeSelf.tagSearchRegex,
                                                                options: .regularExpression,
                                                                range: nil,
                                                                locale: nil)
        while let newRange = range{
            resultantString = resultantString.replacingCharacters(in: newRange, with: "")
            range = resultantString.range(of: typeSelf.tagSearchRegex,
                                          options: .regularExpression,
                                          range: nil,
                                          locale: nil)
        }
        return resultantString
    }
    
    var detectedURLs: [URL]? {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: (self as NSString).length))
        return matches.compactMap({ $0.url })
    }
    
}
