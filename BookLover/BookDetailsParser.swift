//
//  BookDetailsParser.swift
//  BookLover
//
//  Created by Laticia Chance on 3/23/17.
//  Copyright © 2017 Laticia Chance. All rights reserved.
//

import Foundation
import SWXMLHash

class BookDetailsParser {
    class func parseData(xml: Data) -> [Details] {
        
        let xml = SWXMLHash.parse(xml)
        var additionalDetails = [Details]()
        
        // handle optionals appropriately 
        let bookDescription = (xml["GoodreadsResponse"]["book"]["description"].element?.text)!
        let numOfPages = (xml["GoodreadsResponse"]["book"]["num_pages"].element?.text)!
        let publisher = (xml["GoodreadsResponse"]["book"]["publisher"].element?.text)!
        
        let details = Details(bookDescription: bookDescription, numberOfPages: numOfPages, publisher: publisher)
        additionalDetails.append(details)
        
        return additionalDetails
    }
}

struct Details {
    let bookDescription: String
    let numberOfPages: String
    let publisher: String
}
