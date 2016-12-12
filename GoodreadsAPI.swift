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
    

    let key = "mqaiL9tKRtfMngub7an3A"
    let secret = "21zrUDzirF0cRyIENUh2Fwl1cGlJN0RjOTX3eBkO4w"

    func APICall() {
        Alamofire.request("https://www.goodreads.com/search.xml?key=\(key)&q=Ender%27s+Game").responseString { (response) in
           // print(response.result.value)
            
            let xml = SWXMLHash.parse(response.data!)
            //print(xml)
            
            let bookInfo = xml["GoodreadsResponse"]["search"]["results"]["work"]
            
            self.author = (bookInfo[0]["best_book"]["author"]["name"].element?.text)!
            print(self.author)
        }
    }

    
}
