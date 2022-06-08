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
import PhotosUI


class ViewController: UIViewController, ARSessionDelegate {
    
    
    
    @IBOutlet var arView: ARView!
    let scene = SCNScene()
    
    var anchorEntity = AnchorEntity()
    var modelEntity = ModelEntity()
    var body = Entity ()
    var planeMesh = MeshResource.generatePlane(width: 0.17,
                                               height: 0.17,
                                        cornerRadius: 0.02)
    var material = SimpleMaterial()
    
    var imagePicker: ImagePicker!
    var imageFace = false
    var newPhoto = "ney"
    var photo = "ney" {
        didSet { self.photo = newPhoto } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadCena()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        // Configurando plano horizontal
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        arView.session.delegate = self
        arView.session.run(config)
        imagePicker = ImagePicker(presentationController: self, delegate: self)

    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                
                self.anchorEntity = AnchorEntity(anchor: planeAnchor)
                
                if let body = arView.scene.findEntity(named: "body") {
                    // adiciona o objeto na entidade
                    self.body = body
                    self.anchorEntity.addChild(self.body)
                }
                arView.scene.anchors.append(self.anchorEntity)
            }
        }
        self.setMaterialToPhoto()
        anchorEntity.addChild(modelEntity)
    }
    
    func setMaterialToPhoto() {
        let createFace = CreateFace()
        self.material = createFace.createFace(photo: self.newPhoto)
        self.modelEntity = ModelEntity(mesh: self.planeMesh,
                                       materials: [self.material])
        modelEntity.setPosition(SIMD3(SCNVector3(0, 6.5, 0.45)), relativeTo: self.body)
        imageFace = false
    }
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                
                self.anchorEntity = AnchorEntity(anchor: planeAnchor)
                
                if let body = arView.scene.findEntity(named: "body") {
                    // adiciona o objeto na entidade
                    self.body = body
                    self.anchorEntity.addChild(self.body)
                }
                arView.scene.anchors.append(self.anchorEntity)
            }
        }
        self.setMaterialToPhoto()
        anchorEntity.addChild(modelEntity)
    }
    
    @IBAction func clickButton(_ sender: Any) {
        let takeImage = ARPhotoManager()
        takeImage.takePhoto(view: self.arView)
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if status != .denied{
                        self.imagePicker.present(from: sender as! UIView)

                    } else {
                       print("Acesso nao permitido")
                    }
                })
            }
        else {
            self.imagePicker.present(from: sender as! UIView)
        }
    }
}

extension ViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.imageFace = true
        self.newPhoto = PhotoManager.saveToFiles(image: image)
        self.setMaterialToPhoto()
        anchorEntity.removeChild(modelEntity)
    }
}
