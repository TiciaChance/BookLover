//
//  WebViewVC.swift
//  BookLover
//
//  Created by Laticia Chance on 12/24/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WebViewVC: UIViewController, UIWebViewDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet var activityIndicatorView: NVActivityIndicatorView!
    
    @IBOutlet weak var articleWebView: UIWebView!
    
    var reviewURL = String()
    
    var infoFromScanner = ScannerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articleWebView.delegate = self
        self.startAnimating(CGSize(width: 70, height: 70), message: "Loading", messageFont: UIFont(name: "Didot", size: CGFloat(50)), type: .ballPulse, color: UIColor.black)
        
        guard let url = URL(string: reviewURL) else {
            return
        }

        let urlRequest = URLRequest(url: url)
        articleWebView.loadRequest(urlRequest)
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.stopAnimating()
        print("finished loading")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
