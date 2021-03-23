//
//  CameraViewController.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    func savePhoto(selectedImage: UIImage) {
        
        PhotoService.savePhoto(selectedImage: selectedImage)
        
    }


}
