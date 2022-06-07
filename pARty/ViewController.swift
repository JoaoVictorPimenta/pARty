//
//  ViewController.swift
//  POCTestModels
//
//  Created by João Pimenta on 02/06/22.
//

import UIKit
import RealityKit
import SceneKit
import ARKit


class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    let scene = SCNScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadCena()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        self.createBoard()
        
        // Configurando plano horizontal
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
    }
    
    func createBoard() {
        //criacao de um plano
        let planeMesh = MeshResource.generatePlane(width: 0.1,
                                                   height: 0.1,
                                            cornerRadius: 0.02)
        
        // material = tipo de textura pro ARKit
        var material = SimpleMaterial()
        // aplica uma cor e essa cor tem uma textura que eh a imagem
        material.color = try! .init(tint: .white,
                                 texture: .init(.load(named: "ney", in: nil)))
        material.metallic = .init(floatLiteral: 1.0)
        material.roughness = .init(floatLiteral: 0.5)

        
        let modelEntity = ModelEntity(mesh: planeMesh,
                                 materials: [material])
        //modelEntity.position = SIMD3(SCNVector3(10, 10, 0))
        let anchorEntity = AnchorEntity()
        
        if let body = arView.scene.findEntity(named: "body") {
            // adiciona o objeto na entidade
            modelEntity.setPosition(SIMD3(SCNVector3(0, 6.5, 0.5)), relativeTo: body)
            anchorEntity.addChild(body)
        }
        
        anchorEntity.addChild(modelEntity)
        arView.scene.anchors.append(anchorEntity)
        
    }
}

