//
//  BestsellerGetter.swift
//  BookLover
//
//  Created by Laticia Chance on 12/23/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias NYTimesCompletion = (BookReviewResponse) -> Void

enum BookReviewResponse {
    case success(response: BookReviewResponseData)
    case failure(error: Error)
}

struct BookReviewResponseData {
    let result : [BookReview]
}

class BestsellerGetter: NSObject {
    
    let baseURL = "https://api.nytimes.com/svc/books/v3/reviews.json"
    let APIkey = "1c39612baa1642ef82cec94ef24d24b1"
    
    func NYTimesBookData(isbn: String, completed: @escaping NYTimesCompletion) {
        
        Alamofire.request("\(baseURL)?api-key=\(APIkey)&isbn=\(isbn)").responseJSON { (response) in
            if let data = response.result.value {
                let review = NYTimesParser.BookReviewParser(json: data)
                completed(.success(response: BookReviewResponseData(result: review)))
            } else {
                completed(.failure(error: response.result.error ?? NSError()))
            }
            
        }
    }
}
