//
//  PhotoManager.swift
//  pARty
//
//  Created by Beatriz Duque on 07/06/22.
//

import Foundation
import RealityKit
import UIKit


public class ARPhotoManager {
    
    func takePhoto(view: ARView) {
        let image = view.snapshot(saveToHDR: false, completion: { image in
            // Compriminho a imagem
             let compressedImage = UIImage(data: (image?.pngData())!)
             // Salvando no album
             UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        })
    }
}
