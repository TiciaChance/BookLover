//
//  DetailVC.swift
//  BookLover
//
//  Created by Laticia Chance on 12/24/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var ratingLbl: UILabel!
    
    @IBOutlet weak var numOfPagesLabel: UILabel!
    @IBOutlet weak var NYTReviewButton: UIButton!
    @IBOutlet weak var publisherLabel: UILabel!


    
    var bookTitle = String()
    var author = String()
    var bookImgURL = String()
    var rating = String()
    var reviewURL = String()
    var bookDescription = String()
    var bookPublisher = String()
    var pages = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = bookTitle
        authorLbl.text = author
        guard let url = URL(string: bookImgURL) else {
            bookImage.image = #imageLiteral(resourceName: "book.jpg")
            return
        }
        let data = try? Data(contentsOf: url)
        bookImage.image = UIImage(data: data!)
        ratingLbl.text = "Rating: \(rating)"
        numOfPagesLabel.text = "Number of pages: \(pages)"
        publisherLabel.text = "Publisher: \(bookPublisher)"
    
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webVC = segue.destination as! WebViewVC
         webVC.reviewURL = reviewURL
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    

}
