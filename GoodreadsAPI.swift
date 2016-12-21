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

protocol BookInformationDelegate {
    func didGetInfo(books: Books)
    func didNotGetInfo(error: NSError)
}

class GoodreadsAPI: NSObject {

    var delegate : BookInformationDelegate
    
    init(delegate: BookInformationDelegate) {
        self.delegate = delegate
    }
    
    let key = "mqaiL9tKRtfMngub7an3A"
    let secret = "21zrUDzirF0cRyIENUh2Fwl1cGlJN0RjOTX3eBkO4w"
    
    func APICall(isbn: String, completed: @escaping () -> ())  {
        
        Alamofire.request("https://www.goodreads.com/search.xml?key=\(key)&q=\(isbn)").responseString {(response) in
            // print(response.result.value)
            
            let xml = SWXMLHash.parse(response.data!)
            //print(xml)
            
            let bookInfo = xml["GoodreadsResponse"]["search"]["results"]["work"]
            
            let books = try! Books(bookInfo: bookInfo)
            self.delegate.didGetInfo(books: books)
            
           }
        
        completed()
    }
    
    
}
