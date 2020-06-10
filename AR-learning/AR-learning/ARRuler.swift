//
//  ViewController.swift
//  AR-learning
//
//  Created by Ashok on 05/06/20.
//  Copyright © 2020 ashok. All rights reserved.
//

import UIKit
import ARKit
class ARRuler: UIViewController {
    var dotNodes = [SCNNode]()
    var  textNode = SCNNode()
    let configuration = ARWorldTrackingConfiguration()
    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.sceneView.debugOptions = [ ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true

    }
    override func viewDidAppear(_ animated: Bool) {
        let alert = Alert()
        alert.show("Tap the two location in the object and find the distance of the object", self)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if dotNodes.count >= 2 {
            for dot in dotNodes {
                dot.removeFromParentNode()
            }
            dotNodes = [SCNNode]()
        }
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
            let hitTest = sceneView.hitTest(location, types: .featurePoint)
            if let hitResult = hitTest.first {
                self.setPlaneNode(hitResult)
            }
        }

    }


    func setPlaneNode(_ hitTest: ARHitTestResult) {
        // Get Transform position of the horinzontal plane
        let transform = hitTest.worldTransform
        let thirdColumn = transform.columns.3

        //let box = boxNode()
        let sphere = sphereNode()
        sphere.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
        self.sceneView.scene.rootNode.addChildNode(sphere)
        dotNodes.append(sphere)
        if dotNodes.count >= 2 {
            calculateDistance()
        }
    }

    func sphereNode() -> SCNNode {
        let node = SCNNode(geometry: SCNSphere(radius: 0.005))
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        return node
    }

    func calculateDistance() {
        let startNode = dotNodes[0]
        let endNode = dotNodes[1]
        let a = endNode.position.x - startNode.position.x
        let b = endNode.position.y - startNode.position.y
        let c = endNode.position.z - startNode.position.z
        let distance = sqrt(pow(a, 2) + pow(b, 2) + pow(c, 2))
        print(abs(distance))
        let text = String(abs(distance))
        self.updateTextNode(text, endNode.position)
    }

    func updateTextNode(_ text: String, _ position: SCNVector3){
        textNode.removeFromParentNode()
        textNode = SCNNode(geometry: SCNText(string: text, extrusionDepth: 0.02))
        textNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        textNode.position = SCNVector3(position.x, position.y+0.01, position.z)
        textNode.scale = SCNVector3(0.01,0.01,0.01)
        sceneView.scene.rootNode.addChildNode(textNode)
    }


}
