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

class BestsellerGetter: NSObject {

    var APIkey = "1c39612baa1642ef82cec94ef24d24b1"
    var url =  "https://api.nytimes.com/svc/books/v3/reviews.json?"
 
    func NYTimesBookData(isbn: String, completed: @escaping () -> ()) {
        
        Alamofire.request("https://api.nytimes.com/svc/books/v3/reviews.json?api-key=\(APIkey)&isbn=\(isbn)").responseJSON { (response) in
            print(response.result.value)
        }
        completed()
    }
}
