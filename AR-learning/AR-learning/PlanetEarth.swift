//
//  ViewController.swift
//  AR-learning
//
//  Created by Ashok on 05/06/20.
//  Copyright © 2020 ashok. All rights reserved.
//

import UIKit
import ARKit
class PlanetEarth: UIViewController, ARSCNViewDelegate {
    let configuration = ARWorldTrackingConfiguration()
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        self.sceneView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        let alert = Alert()
        alert.show("When you tap the button you can see the sun and earth and even earth will revolve round the sun", self)
    }
    @IBAction func addAction(_ sender: Any) {
        let sun = sunNode()
        let earth = earthNode()
        earth.position = SCNVector3(1.2,0,0)
        sun.position = SCNVector3(0,0,-1)
        sun.addChildNode(earth)
        self.sceneView.scene.rootNode.addChildNode(sun)
    }

    func sunNode() -> SCNNode {
      let node = SCNNode()
        node.geometry = SCNSphere(radius: 0.2)
        node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "sunDiffuse.png")
        let action = SCNAction.rotateBy(x: 0, y: 360.degreesToRadians, z: 0, duration: 14)
        let infinity = SCNAction.repeatForever(action)
        node.runAction(infinity)
        return node
    }

    func earthNode() -> SCNNode {
        let node = SCNNode()
          node.geometry = SCNSphere(radius: 0.2)
          node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth_day.png")
          node.geometry?.firstMaterial?.specular.contents = UIImage(named: "earth_specular.png")
          node.geometry?.firstMaterial?.normal.contents = UIImage(named: "earthNormal.jpg")
          let action = SCNAction.rotateBy(x: 0, y: 360.degreesToRadians, z: 0, duration: 12)
          let infinity = SCNAction.repeatForever(action)
          node.runAction(infinity)
          return node
    }

}
extension BinaryInteger {
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}
