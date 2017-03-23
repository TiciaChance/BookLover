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

typealias GoodreadsCompletion = (GoodreadsResponse) -> Void

enum GoodreadsResponse {
    case success(response: GoodreadsResponseData)
    case failure(error: Error)
}

struct GoodreadsResponseData {
    public let results : [BookDetails]
}

class GoodreadsAPI {
    
    
    let key = "mqaiL9tKRtfMngub7an3A"
   // let secret = "21zrUDzirF0cRyIENUh2Fwl1cGlJN0RjOTX3eBkO4w"
    
    func APICall(isbn: String, completed: @escaping GoodreadsCompletion) {
        
        Alamofire.request("https://www.goodreads.com/search.xml?key=\(key)&q=\(isbn)").responseString {(response) in
            
            if let data = response.data {
                let info = GoodreadsParser.parseData(xml: data)
                completed(.success(response: GoodreadsResponseData(results: info)))
            } else {
                completed(.failure(error: response.result.error ?? NSError()))
            }
            
        }
    }
  
}
