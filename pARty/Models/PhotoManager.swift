//
//  PhotoManager.swift
//  pARty
//
//  Created by Beatriz Duque on 08/06/22.
//

import Foundation
import UIKit

class PhotoManager {
    // achar diretorio onde salva as imagens
    static func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // salvar arquivo
    static func saveToFiles(image: UIImage?) -> String {
        if let data = image?.jpegData(compressionQuality: 1){
            let directory = getDocumentDirectory()
            let path = directory.appendingPathComponent("\(UUID().uuidString).jpeg")
            try? data.write(to: path)
            return path.lastPathComponent
        }
        return ""
    }
    
    // deletar arquivo
    static func deleteImage(path: String) -> Bool {
        let imagePath = getDocumentDirectory().appendingPathComponent(path)
        if FileManager.default.fileExists(atPath: imagePath.relativePath) {
            try? FileManager.default.removeItem(at: imagePath)
            return true
        }
        return false
    }
    
    // buscar imagens
    static func getFilePath(fileName: String) -> String {
        let imagePath = getDocumentDirectory().appendingPathComponent(fileName)
        return imagePath.relativePath
    }
}
