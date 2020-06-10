//
//  PositioningNodes.swift
//  AR-learning
//
//  Created by Ashok on 06/06/20.
//  Copyright © 2020 ashok. All rights reserved.
//
import UIKit
import ARKit
class PositioningNodes: UIViewController {
    let configuration = ARWorldTrackingConfiguration()
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        sceneView.automaticallyUpdatesLighting = true
    }

    override func viewDidAppear(_ animated: Bool) {
           let alert = Alert()
           alert.show("When you tap Add button it will positioning the mutiple node in the Scene", self)
       }

    @IBAction func addAction(_ sender: Any) {
        //Create Shape Node on the AR view
        // Add all node to the root node of the scenview
        let shapeNode = ShapeNode()
        self.sceneView.scene.rootNode.addChildNode(shapeNode)
    }

    //Shape Node Sample
    //Euler to roate
    func ShapeNode() -> SCNNode {
        //Create Nodes
        let pyramid = pyramidNode()
        let cylinder = cylinderNode()

        //Positioning the Nodes
        pyramid.position = SCNVector3(0.2,0.3,-0.2)
        pyramid.addChildNode(cylinder)
        cylinder.position = SCNVector3(0,-0.05,0)

        return pyramid
    }

    private func cylinderNode() -> SCNNode {
        let cylinder = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        cylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        return cylinder
    }

    //Create your own shape usine beizer  path
    private func shapeNode() -> SCNNode {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 30))
        path.lineWidth = 1
        let node = SCNNode(geometry: SCNShape(path: path, extrusionDepth: 0))
        return node
    }
    //Pyramid Node
    private func pyramidNode() -> SCNNode {
        let node = SCNNode()
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        return node
    }
}
