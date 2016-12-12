//
//  ScannerController.swift
//  BookLover
//
//  Created by Laticia Chance on 12/12/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var codeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateVidCapture()

    }
    
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
            
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeEAN8Code]
            
        } catch {
            
            print(error)
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
    }
}


