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
    var averageRating = String()
    var bookDescription = String()
    var numOfPages = String()
    var publisher = String()
    
    var hyphenatedAuthor = String()
    var hyphenatedTitle = String()
    
    
    let key = "mqaiL9tKRtfMngub7an3A"
    let secret = "21zrUDzirF0cRyIENUh2Fwl1cGlJN0RjOTX3eBkO4w"
    
    func APICall(isbn: String, completed: @escaping () -> ()) {
        
        Alamofire.request("https://www.goodreads.com/search.xml?key=\(key)&q=\(isbn)").responseString {(response) in
            
            guard let data = response.data else {return}
            
            let xml = SWXMLHash.parse(data)
            
            let bookInfo = xml["GoodreadsResponse"]["search"]["results"]["work"]
            let test = xml["GoodreadsResponse"]["search"]
            
            
            let total_results: Int = try! test["total-results"].value()
            
            if total_results == 0 {
                self.author = "Sorry, not found"
                self.title = "Sorry, not found"
                self.averageRating = "0"
            } else {
                
                self.author = (bookInfo[0]["best_book"]["author"]["name"].element?.text)!
                self.title = (bookInfo[0]["best_book"]["title"].element?.text)!
                self.imageURL = (bookInfo[0]["best_book"]["image_url"].element?.text)!
                self.averageRating = (bookInfo[0]["average_rating"].element?.text)!
                print(self.averageRating)
                
                self.hyphenatedAuthor = self.author.replacingOccurrences(of: " ", with: "+")
                self.hyphenatedTitle = self.title.replacingOccurrences(of: " ", with: "-")
                
                self.moreDetails(bookAuthor: self.hyphenatedAuthor, bookTitle: self.hyphenatedTitle, completed: {
                })
                
            }
        }
        
        completed()
    }
    
    func moreDetails(bookAuthor: String, bookTitle: String, completed: @escaping () -> ()) {
        
        Alamofire.request("https://www.goodreads.com/book/title.xml?author=\(bookAuthor)&key=\(key)&title=\(bookTitle)").responseString {(response) in
            
            
            guard let data = response.data else {return}
            
            let xml = SWXMLHash.parse(data)
            
            self.bookDescription = (xml["GoodreadsResponse"]["book"]["description"].element?.text)!
            
            self.numOfPages = (xml["GoodreadsResponse"]["book"]["num_pages"].element?.text)!
            self.publisher = (xml["GoodreadsResponse"]["book"]["publisher"].element?.text)!
            
        }
        
        
    }
    
}
