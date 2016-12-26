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
    @IBOutlet weak var NTYReviewBtn: UIButton!
    
    @IBOutlet weak var NYTReviewButton: UIButton!
    
    var bookTitle = String()
    var author = String()
    var bookImgURL = String()
    var rating = Double()
    var reviewURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = bookTitle
        authorLbl.text = author
        guard let url = URL(string: bookImgURL) else {
            print("url not found")
            bookImage.image = #imageLiteral(resourceName: "book.jpg")
            return
        }
        let data = try? Data(contentsOf: url)
        bookImage.image = UIImage(data: data!)
        ratingLbl.text = "Rating: \(String(rating))/5.00"
        
        
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webVC = segue.destination as! WebViewVC
        
         webVC.reviewURL = reviewURL
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    

}
