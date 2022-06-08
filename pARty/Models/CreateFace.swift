//
//  CreateFace.swift
//  pARty
//
//  Created by Beatriz Duque on 07/06/22.
//

import Foundation
import RealityKit
import UIKit

class CreateFace {
    
    func createFace(photo: String) -> SimpleMaterial{
        let path = photo
        let imageNew = UIImage(contentsOfFile: PhotoManager.getFilePath(fileName: path))
        
        // material = tipo de textura pro ARKit
        var material = SimpleMaterial()
        // aplica uma cor e essa cor tem uma textura que eh a imagem
        material.color = try! .init(tint: .white,
                                 texture: .init(.load(named: photo, in: nil)))
        if photo != "ney"{
            material.color = try! .init(tint: .white, texture: .init(.load(contentsOf: URL.init(string: path)!)))
        }
        material.metallic = .init(floatLiteral: 1.0)
        material.roughness = .init(floatLiteral: 0.5)
        
        return material
    }
}
