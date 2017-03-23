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
        var bookDetails = [BookDetails]()
     
        let bookInfo = xml["GoodreadsResponse"]["search"]["results"]["work"]
        let test = xml["GoodreadsResponse"]["search"]
        
        let total_results: Int = try! test["total-results"].value()
        
        if total_results == 0 {
            let author = "Sorry, not found"
            let title = "Sorry, not found"
            let averageRating = "0"
            let replacementDetails = BookDetails(author: author, title: title, imageURL: nil , averageRating: averageRating)
            bookDetails.append(replacementDetails)
            
        } else {
            let author = (bookInfo[0]["best_book"]["author"]["name"].element?.text)!
            let title = (bookInfo[0]["best_book"]["title"].element?.text)!
            let imgURL = (bookInfo[0]["best_book"]["image_url"].element?.text)!
            let averageRating = (bookInfo[0]["average_rating"].element?.text)!
            
            let details = BookDetails(author: author, title: title, imageURL: imgURL, averageRating: averageRating)
            bookDetails.append(details)
        }
        
        print("YO \(bookDetails)")
        return bookDetails

        }
    }


struct BookDetails {
    var author : String
    var title : String
    var imageURL : String?
    var averageRating : String
}


