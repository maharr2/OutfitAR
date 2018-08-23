//
//  ViewController.swift
//  OutfitAR
//
//  Created by Rashmi Maharjan on 06/19/2018.
//  Copyright (c) 2018 Rashmi Maharjan. All rights reserved.
//

import UIKit
import SceneKit
import AVFoundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //capture video input in an AVCaptureLayerVideoPreviewLayer
        let captureSession = AVCaptureSession()
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        if let videoDevice = AVCaptureDevice.default(for: AVMediaType.video) {
            var err: NSError? = nil
            do {
                let input = try AVCaptureDeviceInput(device: videoDevice)
                captureSession.addInput(input)
                captureSession.commitConfiguration()
            } catch {
             print("Failed to create video capture device.")
                return
            }
        }
        captureSession.startRunning()
        
        //add AVCaptureVideoPreviewLayer as sublayer of self.view.layer
        previewLayer.frame = self.view.bounds
        self.view.layer.addSublayer(previewLayer)
        
        //create a SceneView with a clear background color and add it as a subview of self.view
        let sceneView = SCNView()
        sceneView.frame = self.view.bounds
        sceneView.backgroundColor = UIColor.yellow
        previewLayer.frame = self.view.bounds
        self.view.addSubview(sceneView)
        
        //now you could begin to build your scene with the device's camera video as your background
        let scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        let boxGeometry = SCNBox(width: 10.0, height: 10.0, length: 10.0, chamferRadius: 1.0)
        let boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
        sceneView.scene = scene
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
}

