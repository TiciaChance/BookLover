//
//  Book.swift
//  BookLover
//
//  Created by Laticia Chance on 12/21/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import Foundation
import SWXMLHash

struct Books {
   
    var author: String
    var title: String
    var imageURL: String
    var averageRating: Double
    var publicationYear: Int
    
    init(bookInfo: XMLIndexer) throws {
        self.author = (bookInfo[0]["best_book"]["author"]["name"].element?.text)!
        self.title = (bookInfo[0]["best_book"]["title"].element?.text)!
        self.imageURL = (bookInfo[0]["best_book"]["image_url"].element?.text)!
        self.averageRating = try (bookInfo[0]["average_rating"].value())
        self.publicationYear = try (bookInfo[0]["original_publication_year"].value())
    }
    
}
