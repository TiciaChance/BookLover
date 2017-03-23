//
//  GRAdditionalDetailsAPI.swift
//  BookLover
//
//  Created by Laticia Chance on 3/23/17.
//  Copyright © 2017 Laticia Chance. All rights reserved.
//

import Foundation

import Alamofire
import SWXMLHash

typealias DetailsCompletion = (AdditionalDetailsResponse) -> Void

enum AdditionalDetailsResponse {
    case success(response: DetailsResponseData)
    case failure(error: Error)
}

struct DetailsResponseData {
    public let results : [Details]
}

class GRAdditionalDetails: NSObject {
    let key = "mqaiL9tKRtfMngub7an3A"
    
    // account for book author -- 
    func moreDetails(bookAuthor: String, bookTitle: String, completed: @escaping DetailsCompletion) {
        
        Alamofire.request("https://www.goodreads.com/book/title.xml?author=\(bookAuthor)&key=\(key)&title=\(bookTitle)").responseString {(response) in
            
            
            guard let data = response.data else {return}
            if let data = response.data {
                let info = BookDetailsParser.parseData(xml: data)
                completed(.success(response: DetailsResponseData(results: info)))
            } else {
                completed(.failure(error: response.result.error ?? NSError()))
            }
            
        }
    }
    
}
