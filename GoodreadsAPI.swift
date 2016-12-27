//
//  GoodreadsAPI.swift
//  BookLover
//
//  Created by Laticia Chance on 12/3/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash

class GoodreadsAPI: NSObject {
    
    var author = String()
    var title = String()
    var imageURL = String()
    var averageRating = Double()
    var publicationYear = Int()
    
    
    
    let key = "mqaiL9tKRtfMngub7an3A"
    let secret = "21zrUDzirF0cRyIENUh2Fwl1cGlJN0RjOTX3eBkO4w"
    
    func APICall(isbn: String, completed: @escaping () -> ())  {
        
        Alamofire.request("https://www.goodreads.com/search.xml?key=\(key)&q=\(isbn)").responseString {(response) in
            
            
            
            let xml = SWXMLHash.parse(response.data!)
            
            let bookInfo = xml["GoodreadsResponse"]["search"]["results"]["work"]
            let test = xml["GoodreadsResponse"]["search"]
            
            let total_results: Int = try! test["total-results"].value()
            print(total_results)
            
            if total_results == 0 {
                self.author = "NOT FOUND"
                self.title = "NOT FOUND"
                self.averageRating = 0
            } else {
                
                self.author = (bookInfo[0]["best_book"]["author"]["name"].element?.text)!
                
                self.title = (bookInfo[0]["best_book"]["title"].element?.text)!
                
                self.imageURL = (bookInfo[0]["best_book"]["image_url"].element?.text)!
                self.averageRating = try! (bookInfo[0]["average_rating"].value())
                self.publicationYear = try! (bookInfo[0]["original_publication_year"].value())
            }
            
        }
        
        completed()
    }
}
