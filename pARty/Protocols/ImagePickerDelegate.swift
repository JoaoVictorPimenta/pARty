//
//  ImagePickerDelegate.swift
//  pARty
//
//  Created by Beatriz Duque on 08/06/22.
//

import Foundation
import UIKit

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?)
}
