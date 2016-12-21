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

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, BookInformationDelegate {
    

        
    @IBOutlet weak var topBar: UINavigationBar!
    
    @IBOutlet weak var messageButton: UIButton!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var codeFrameView: UIView?
    
    var goodreadData : GoodreadsAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goodreadData = GoodreadsAPI(delegate: self)
        instantiateVidCapture()
        
    }
    
    internal func didGetInfo(books: Books) {
        //
    }
    
    func didNotGetInfo(error: NSError) {
        //
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
            
            codeFrameView = UIView()
            
            if let codeFrameView = codeFrameView {
                codeFrameView.layer.borderColor = UIColor.green.cgColor
                codeFrameView.layer.borderWidth = 2
                view.addSubview(codeFrameView)
                view.bringSubview(toFront: codeFrameView)
            }
            
        } catch {
            
            print(error)
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        view.bringSubview(toFront: messageButton)
        view.bringSubview(toFront: topBar)
        
        captureSession?.startRunning()
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

            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            codeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                messageButton.setTitle("Click for book details", for: .normal)
                                goodreadData.APICall(isbn: metadataObj.stringValue, completed:{
                                    print("working")
                                })
                
            }
        }
        
    }

}

