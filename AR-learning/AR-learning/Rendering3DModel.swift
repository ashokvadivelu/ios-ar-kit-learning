//
//  ViewController.swift
//  AR-learning
//
//  Created by Ashok on 05/06/20.
//  Copyright © 2020 ashok. All rights reserved.
//

import UIKit
import ARKit
class Rendering3DModel: UIViewController {
    let configuration = ARWorldTrackingConfiguration()
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true

        //Add Tap Gesture
        self.sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    override func viewDidAppear(_ animated: Bool) {
        let alert = Alert()
        alert.show("When you tap Add button it will show 3d Model in Scene", self)
    }
    @IBAction func addAction(_ sender: Any) {
        let scene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let node = scene?.rootNode.childNode(withName: "Jellyfish", recursively: false)
        node?.position = SCNVector3(0,0,-1)
        self.sceneView.scene.rootNode.addChildNode(node!)
    }

    // Tap the model and do Animation
    @objc func handleTap(sender: UITapGestureRecognizer){
        let sceneViewTapped = sender.view as! SCNView
        let locationCoordinates = sender.location(in: sceneViewTapped)
        let hitTest = sceneViewTapped.hitTest(locationCoordinates)
        if hitTest.isEmpty {

        } else {
            print("tapped the model")
            let result = hitTest.first!
            let node = result.node
            self.doBasicAnimation(node)
        }
    }

    func doBasicAnimation(_ node: SCNNode) {
        let basic = CABasicAnimation(keyPath: "position")
        basic.fromValue = node.presentation.position
        basic.toValue = SCNVector3(node.presentation.position.x-1, node.presentation.position.y-1, node.presentation.position.z-1)
        basic.duration = 5
        basic.repeatCount = 5
        node.addAnimation(basic, forKey: "position")
    }

}
