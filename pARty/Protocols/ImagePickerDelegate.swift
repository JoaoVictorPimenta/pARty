//
//  ImagePickerDelegate.swift
//  pARty
//
//  Created by Beatriz Duque on 08/06/22.
//

import Foundation
import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}
