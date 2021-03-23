//
//  SettingsViewController.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            LocalStorageService.clearUser()
            
            let loginNavVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginNavController)
            view.window?.rootViewController = loginNavVC
            view.window?.makeKeyAndVisible()
            
        } catch {
            
        }
        
    }
    

}
