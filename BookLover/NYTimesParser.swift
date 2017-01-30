//
//  NYTimesParser.swift
//  BookLover
//
//  Created by Laticia Chance on 1/20/17.
//  Copyright © 2017 Laticia Chance. All rights reserved.
//

import Foundation

class NYTimesParser {
    class func BookReviewParser(json: Any) -> [BookReview]{

        var bookReviewURL = [BookReview]()
        
        if let JSON = json as? [String : Any],
            let allData = JSON["results"] as?  [[String : Any]],
            let reviewURLString = allData[0]["url"] as? String {
            
            let bookReview = BookReview(reviewURLString: reviewURLString)
            bookReviewURL.append(bookReview)
        } else {
            let defaultURLString = "http://www.nytimes.com/section/books/review"
            let bookReview = BookReview(reviewURLString: defaultURLString)
            bookReviewURL.append(bookReview)
        }
        return [BookReview]()
    }
}

struct BookReview {
    let reviewURLString: String
}
