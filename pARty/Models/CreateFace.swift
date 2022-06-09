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
    
    func createFace(photo: String) -> SimpleMaterial {
        // material = tipo de textura pro ARKit
        var material = SimpleMaterial()
        let path = photo
        let url = PhotoManager.getDocumentDirectory().appendingPathComponent(path)
        do {
            let texture: TextureResource = try TextureResource.load(contentsOf: url)
            let materialTexture: MaterialColorParameter = MaterialColorParameter.texture(texture)
            material.baseColor = materialTexture
        } catch {
            do {
                material.color = try .init(tint: .white,
                                           texture: .init(.load(named: photo, in: nil)))
            } catch { print("Nao foi possivel texturizar") }
        }
        material.metallic = .init(floatLiteral: 1.0)
        material.roughness = .init(floatLiteral: 0.5)
        
        return material
    }
    
    func createMaterial(photo: String) -> MaterialColorParameter? {
        let path = photo
        let url = PhotoManager.getDocumentDirectory().appendingPathComponent(path)
        do {
            let texture: TextureResource = try TextureResource.load(contentsOf: url)
            let materialTexture: MaterialColorParameter = MaterialColorParameter.texture(texture)
            return materialTexture
        } catch {
            return nil
        }
    }
}
