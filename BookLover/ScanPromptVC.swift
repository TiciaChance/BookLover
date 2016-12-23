//
//  ScanPromptVC.swift
//  BookLover
//
//  Created by Laticia Chance on 12/12/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class ScanPromptVC: UIViewController {

    var nytTest = BestsellerGetter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nytTest.NYTimesBookData(isbn: "978-0812993547", completed: {

})
        
        
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ScanPromptVC.screenTapped(recgognizer:)))
        
        self.view.addGestureRecognizer(recognizer)

    }
    
    func screenTapped(recgognizer: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "scannerSegue", sender: self)
        
    }

}
