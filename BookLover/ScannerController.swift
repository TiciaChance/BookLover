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

protocol ReviewDelegate {
    func getNYTbookReview(review: String)
}

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    @IBOutlet weak var messageButton: UIButton!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var player = AVAudioPlayer()
    var codeFrameView: UIView?
    
    let goodreadData = GoodreadsAPI()
    var bookReviewData = BestsellerGetter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateVidCapture()
        
        goodreadData.APICall(isbn: "9780812993547", completed:{
            print("got code - now going to goodreads data")
        })
        bookReviewData.NYTimesBookData(isbn: "9780812993547", completed: {
            
        })

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let detailVC = segue.destination as! DetailVC
            detailVC.author = goodreadData.author
            detailVC.bookTitle = goodreadData.title
            detailVC.bookImgURL = goodreadData.imageURL
            detailVC.rating = goodreadData.averageRating
            
            detailVC.reviewURL = bookReviewData.reviewURL
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:: Scanner functions

extension ScannerController {
    func instantiateVidCapture() {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            //according to Apple documentation this has to be done on a serial queue - read up on this
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
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
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
                
                
                goodreadData.APICall(isbn: metadataObj.stringValue, completed:{
                    print("got code - now going to goodreads data")
                })
                bookReviewData.NYTimesBookData(isbn: metadataObj.stringValue, completed: {
                   
                })
                
                messageButton.setTitle("Click for book details", for: .normal)

            }
            self.captureSession?.stopRunning()
        }
        
    }
    

}

