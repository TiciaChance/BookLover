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
    
    //var bookTitle = String()
    var author = String()
//    var bookImg = UIImage()
//    var rating = Int()
    
    var goodreadData : GoodreadsAPI!
    var bookReviewData : BestsellerGetter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorLbl.text = author

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
