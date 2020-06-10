//
//  ViewController.swift
//  AR-learning
//
//  Created by Ashok on 05/06/20.
//  Copyright © 2020 ashok. All rights reserved.
//

import UIKit
import ARKit
class DrawingShapes: UIViewController, ARSCNViewDelegate {
    let configuration = ARWorldTrackingConfiguration()
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        sceneView.automaticallyUpdatesLighting = true
        self.sceneView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
           let alert = Alert()
           alert.show("When you hold the button and move the phone it will draw based on your move in the scene", self)
       }
    @IBAction func addAction(_ sender: Any) {

    }

    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        print("rendeering")
        guard let pointOfView = sceneView.pointOfView else {
            return
        }
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        let currentCameraPostion = location + orientation
        DispatchQueue.main.async {
            if self.actionButton.isHighlighted {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                sphereNode.position = currentCameraPostion
                self.sceneView.scene.rootNode.addChildNode(sphereNode)
            } else {

                self.sceneView.scene.rootNode.enumerateChildNodes({ (node,_) in
                    node.removeFromParentNode()
                })
            }

        }
    }


}

// function to add 3d vector
func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    let vectorMake = SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    return vectorMake
}
