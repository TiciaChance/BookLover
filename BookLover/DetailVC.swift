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

    var overlayView = UIView()
    var descriptionLabel = UILabel()
    var doneButton = UIButton()
    
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
    
    @IBAction func descriptionButtonTapped(_ sender: Any) {
        
        showOverlay(overlayView: overlayView)
    }
    
    func showOverlay(overlayView: UIView) {
        
        //view
        overlayView.frame = self.view.frame
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0.8
        
        //label
        descriptionLabel.frame = overlayView.frame
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = .max
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.textAlignment = .center
        let newBookDescription = bookDescription.replacingOccurrences(of: "<br />", with: " ")
        descriptionLabel.text = newBookDescription
        
        //button
        doneButton = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width/2 + 75, y: self.view.frame.height - 60), size: CGSize(width: 100, height: 50)))
        doneButton.setTitle("Done", for: .normal)
        doneButton.alpha = 1.0
        doneButton.setTitleColor(UIColor.red, for: .normal)
       // doneButton.backgroundColor = UIColor.white

        overlayView.addSubview(descriptionLabel)
        overlayView.addSubview(doneButton)
        view.addSubview(overlayView)
        
        doneButton.addTarget(self, action: #selector(self.click(sender:)), for: .touchUpInside)

        
    }
    
    func click(sender: UIButton) {
        overlayView.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
}
