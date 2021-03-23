//
//  CameraViewController.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        progressLabel.alpha = 0
        progressBar.alpha = 0
        progressBar.progress = 0
        doneButton.alpha = 0
    }

    func savePhoto(selectedImage: UIImage) {
        
        PhotoService.savePhoto(selectedImage: selectedImage) { (pct) in
            
            DispatchQueue.main.async {
                
                self.progressBar.alpha = 1
                self.progressBar.progress = Float(pct)
                
                self.progressLabel.alpha = 1
                let roundedPct = Int(pct * 100)
                self.progressLabel.text = "\(roundedPct) %"
                
                if pct == 1 {
                    self.doneButton.alpha = 1
                    self.progressLabel.text = "Upload Completed!"
                }
            }
        }
        
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        
        let tabBarVC = tabBarController as? MainTabBarController
        
        if let tabBarVC = tabBarVC {
            
            tabBarVC.goToFeed()
            
        }
    }
    
}
