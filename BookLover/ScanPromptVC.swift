//
//  ScanPromptVC.swift
//  BookLover
//
//  Created by Laticia Chance on 12/12/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class ScanPromptVC: UIViewController {

    var goodreads = GoodreadsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //can't keep call here 
        goodreads.APICall(isbn: "9781516966509", completed: {
        
        })
        
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ScanPromptVC.screenTapped(recgognizer:)))
        
        self.view.addGestureRecognizer(recognizer)

    }
    
    func screenTapped(recgognizer: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "scannerSegue", sender: self)
        
    }

}
