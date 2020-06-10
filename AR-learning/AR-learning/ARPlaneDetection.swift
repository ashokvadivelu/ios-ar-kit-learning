//
//  ViewController.swift
//  AR-learning
//
//  Created by Ashok on 05/06/20.
//  Copyright © 2020 ashok. All rights reserved.
//

import UIKit
import ARKit
class ARPlaneDetection: UIViewController {
    let configuration = ARWorldTrackingConfiguration()
    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true

        //Add Tap Gesture
        self.sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    override func viewDidAppear(_ animated: Bool) {
          let alert = Alert()
          alert.show("Will detect the Plane(Floor/Flat Surface), tap the view to see the cup model placed in the surface", self)
      }

    // Tap the model and do Animation
    @objc func handleTap(sender: UITapGestureRecognizer){
        let handleTapped = sender.view as! ARSCNView
        let location = sender.location(in: handleTapped)
        let hitTest = handleTapped.hitTest(location, types: .existingPlaneUsingExtent)
        if !hitTest.isEmpty {
            print("Floor Detected")
            self.setPlaneNode(hitTest.first!)
        }
    }


    func setPlaneNode(_ hitTest: ARHitTestResult) {
        // Get Transform position of the horinzontal plane
        let transform = hitTest.worldTransform
         let thirdColumn = transform.columns.3

        //let box = boxNode()
        let cup = cupNode()
        cup.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
        self.sceneView.scene.rootNode.addChildNode(cup)
    }

    func cupNode() -> SCNNode {
        let scene = SCNScene(named: "art.scnassets/cup.scn")
        let node = (scene?.rootNode.childNode(withName: "cup", recursively: false))!
        return node
    }

    func boxNode() -> SCNNode {
        let boxNode = SCNNode(geometry: SCNBox(width: 0.03, height: 0.03, length: 0.03, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        return boxNode
    }
}
