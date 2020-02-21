//
//  MarsViewController.swift
//  Open Space
//
//  Created by Andy Triboletti on 2/20/20.
//  Copyright © 2020 GreenRobot LLC. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming
import SceneKit

class MarsViewController: UIViewController {
    @IBOutlet var takeOffButton: MDCButton!
    
    var baseNode:SCNNode!
    @IBOutlet var scnView: SCNView!
    
    
    @IBAction func takeOffAction() {
        self.performSegue(withIdentifier: "takeOff", sender: self)
    }
    @objc func shipsAction(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "selectShip", sender: sender)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseNode = SCNNode()
        let scene = SCNScene()
        
        let backgroundFilename = "PIA01120orig.jpg"
        let image = UIImage(named: backgroundFilename)!
        
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        let aspectScaledToFitImage = image.af_imageAspectScaled(toFill: size)
        scene.background.contents = aspectScaledToFitImage
        scene.background.wrapS = SCNWrapMode.repeat
        scene.background.wrapT = SCNWrapMode.repeat
        
        
        scene.rootNode.addChildNode(baseNode)
        
        
        
        
        
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        //increased values for y move object lower to bottom of screen
        //increase values for x move object to the left
        //increase values for z move object smaller
        cameraNode.position = SCNVector3(x: 0, y: 15, z: 50)
        cameraNode.rotation = SCNVector4(1, 0, 0, 0.1) //slightly rotate so base is pointed away from user

        baseNode.rotation = SCNVector4(0, -1, 0, 3.14/2)
        //baseNode.runAction(SCNAction.rotateBy(x: 0, y: -1, z: 0, duration: 1))
        //baseNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))

        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        //let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
        // animate the 3d object
        //ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
        
        // retrieve the SCNView
        let scnView = self.scnView!
        //self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = false
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        // add a tap gesture recognizer
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
           scnView.addGestureRecognizer(tapGesture)
        
        
        self.takeOffButton.applyTextTheme(withScheme: appDelegate.containerScheme)
        self.takeOffButton.applyContainedTheme(withScheme: appDelegate.containerScheme)
        
        
        let shipButton = UIBarButtonItem(title: "Ships", style: .done, target: self, action: #selector(shipsAction(_:)))
        self.navigationItem.leftBarButtonItem = shipButton
        
        addObject(name: "flagcool.dae", position:  SCNVector3(1,1,1), scale: nil)

    }
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        }
    
    func addObject(name: String, position: SCNVector3?, scale: SCNVector3?) {
        let shipScene = SCNScene(named: name)!
        var animationPlayer: SCNAnimationPlayer! = nil
        
        let shipSceneChildNodes = shipScene.rootNode.childNodes
        for childNode in shipSceneChildNodes {
            if(position != nil) {
                childNode.position = position!
            }
            if(scale != nil) {
                childNode.scale = scale!
            }
            baseNode.addChildNode(childNode)
            baseNode.scale = SCNVector3(0.50, 0.50, 0.50)
            baseNode.position = SCNVector3(0,0,0)
            //print(child.animationKeys)
            
            
        }
        
        for key in shipScene.rootNode.animationKeys {
            // for every animation key
            animationPlayer = shipScene.rootNode.animationPlayer(forKey: key)
            
            self.scnView.scene!.rootNode.addAnimationPlayer(animationPlayer, forKey: key)
            animationPlayer.play()
            
            
        }
        
    }
    
    
}
