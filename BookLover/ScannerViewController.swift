//
//  ScannerController.swift
//  BookLover
//
//  Created by Laticia Chance on 12/12/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

//protocol ReviewDelegate {
  //  func getNYTbookReview(review: String)
//}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    @IBOutlet weak var messageButton: UIButton!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var player = AVAudioPlayer()
    var codeFrameView: UIView?
    
    let goodreadData = GoodreadsAPI()
    var bookReviewData = BestsellerGetter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //messageButton.isEnabled = false
        instantiateVidCapture()
        
       goodreadData.APICall(isbn: "9780812993547") { (response) in
        print("in closure")
    }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {

        self.captureSession?.startRunning()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "detailSegue" {
//            let detailVC = segue.destination as! DetailVC
//            detailVC.author = goodreadData.author
//            detailVC.bookTitle = goodreadData.title
//            detailVC.bookImgURL = goodreadData.imageURL
//            detailVC.rating = goodreadData.averageRating
//            detailVC.bookDescription = goodreadData.bookDescription
//            detailVC.bookPublisher = goodreadData.publisher
//            detailVC.pages = goodreadData.numOfPages
//            
//            //detailVC.reviewURL = bookReviewData.reviewURL
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:: Scanner functions

extension ScannerViewController {
    func instantiateVidCapture() {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [ AVMetadataObjectTypeEAN13Code]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            view.bringSubview(toFront: messageButton)
            
            captureSession?.startRunning()
            
            codeFrameView = UIView()
            
            if let codeFrameView = codeFrameView {
                codeFrameView.layer.borderColor = UIColor.green.cgColor
                codeFrameView.layer.borderWidth = 3
                view.addSubview(codeFrameView)
                view.bringSubview(toFront: codeFrameView)
            }
            
            
        } catch {
            
            print(error)
            return
        }
        
        
    }
    
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            codeFrameView?.frame = CGRect.zero
            
            messageButton.setTitle("No code has been detected", for: .normal)
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeEAN13Code {
            
            
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            codeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                messageButton.isEnabled = true

                goodreadData.APICall(isbn: metadataObj.stringValue, completed:{_ in 
                    print("got code - now going to goodreads data")
                })
                
                bookReviewData.NYTimesBookData(isbn: metadataObj.stringValue, completed: {_ in
                    
                })
                
                messageButton.setTitle("Click for book details", for: .normal)
                
            }
            self.captureSession?.stopRunning()
        }
        
    }
    
    
}

