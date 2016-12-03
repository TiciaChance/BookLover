//
//  ViewController.swift
//  BookLover
//
//  Created by Laticia Chance on 12/3/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var goodreads = GoodreadsAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goodreads.APICall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

