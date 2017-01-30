//
//  GoodreadsParser.swift
//  BookLover
//
//  Created by Laticia Chance on 1/20/17.
//  Copyright © 2017 Laticia Chance. All rights reserved.
//

import Foundation
import SWXMLHash

class GoodreadsParser {
    class func parseData(xml: Data) -> [BookDetails] {
        
        let xml = SWXMLHash.parse(xml)
        
        let bookInfo = xml["GoodreadsResponse"]["search"]["results"]["work"]
        let test = xml["GoodreadsResponse"]["search"]
        
        
//        let total_results: Int = try! test["total-results"].value()
//        
//        if total_results == 0 {
//            self.author = "Sorry, not found"
//            self.title = "Sorry, not found"
//            self.averageRating = "0"
//        } else {
//            
//            self.author = (bookInfo[0]["best_book"]["author"]["name"].element?.text)!
//            self.title = (bookInfo[0]["best_book"]["title"].element?.text)!
//            self.imageURL = (bookInfo[0]["best_book"]["image_url"].element?.text)!
//            self.averageRating = (bookInfo[0]["average_rating"].element?.text)!
//            
//            self.hyphenatedAuthor = self.author.replacingOccurrences(of: " ", with: "+")
//            self.hyphenatedTitle = self.title.replacingOccurrences(of: " ", with: "-")
//            
        }
    }


struct BookDetails {
    var author : String
    var title : String
    var imageURL : String
    var averageRating : String
    var bookDescription : String
    var numOfPages : String
    var publisher : String
}


