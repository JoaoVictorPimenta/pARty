//
//  CreateFace.swift
//  pARty
//
//  Created by Beatriz Duque on 07/06/22.
//

import Foundation
import RealityKit

class CreateFace {
    
    func createFace(photo: String) -> SimpleMaterial{
        // material = tipo de textura pro ARKit
        var material = SimpleMaterial()
        // aplica uma cor e essa cor tem uma textura que eh a imagem
        material.color = try! .init(tint: .white,
                                 texture: .init(.load(named: photo, in: nil)))
        material.metallic = .init(floatLiteral: 1.0)
        material.roughness = .init(floatLiteral: 0.5)
        
        return material
    }
}
