//
//  CreateProfileViewController.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        
        if Auth.auth().currentUser == nil {return}
        
        let usernameFromTF = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if usernameFromTF == nil || usernameFromTF == "" {return}
        
        UserService.createProfile(userIdFromAuth: Auth.auth().currentUser!.uid, usernameFromTF: usernameFromTF!) { (newUser) in
            
            if newUser != nil {
                
                LocalStorageService.saveUser(userId: newUser!.userId, username: newUser!.username)
                
                let tabTabVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                self.view.window?.rootViewController = tabTabVC
                self.view.window?.makeKeyAndVisible()
            }
        }
        
    }
    

}
