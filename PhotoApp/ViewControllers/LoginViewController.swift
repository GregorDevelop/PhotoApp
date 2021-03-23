//
//  LoginViewController.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func loginTapped(_ sender: Any) {
        
        let authUI = FUIAuth.defaultAuthUI()
        if let authUI = authUI {
            
            authUI.delegate = self
            authUI.providers = [FUIEmailAuth()]
            let authVC = authUI.authViewController()
            present(authVC, animated: true, completion: nil)
        }
    }
    

}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        let userFromAuth = authDataResult?.user
        
        if let userFromAuth = userFromAuth {
            
            UserService.retrieveProfile(userIdFromAuth: userFromAuth.uid) { (currentUser) in
                if currentUser == nil {
                    self.performSegue(withIdentifier: Constants.Storyboard.profileSegue, sender: self)
                }
                else {
                    
                    let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                    
                }
            }
            
        }
    }
    
}
