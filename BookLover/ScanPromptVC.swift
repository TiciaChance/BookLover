//
//  ScanPromptVC.swift
//  BookLover
//
//  Created by Laticia Chance on 12/12/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class ScanPromptVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ScanPromptVC.screenTapped(recgognizer:)))
        
        self.view.addGestureRecognizer(recognizer)

    }
    
    func screenTapped(recgognizer: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "scannerSegue", sender: self)
        
    }

}
