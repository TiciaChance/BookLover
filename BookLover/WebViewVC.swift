//
//  WebViewVC.swift
//  BookLover
//
//  Created by Laticia Chance on 12/24/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class WebViewVC: UIViewController {
    
    
    @IBOutlet weak var articleWebView: UIWebView!
    
    var reviewURL = String()
    
    var infoFromScanner = ScannerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: reviewURL) else {
            print("review not available")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        articleWebView.loadRequest(urlRequest)
        
        }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
