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
            view.snapshotView(afterScreenUpdates: true)
        })
    }
    func feedBackScreen(view: UIView) {
        view.backgroundColor = .white.withAlphaComponent(0.3)
        // adiciona o label que indica o powerup selecionado
        Timer.scheduledTimer(withTimeInterval: 0.005 , repeats: true) { timer in
            view.backgroundColor = .clear
            timer.invalidate()
        }
    }
}
