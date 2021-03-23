//
//  UserService.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import Foundation
import FirebaseFirestore


class UserService {
   
    
    static func createProfile(userIdFromAuth: String, usernameFromTF: String, completion: @escaping (PhotoUser?) -> Void) {
        
        let db = Firestore.firestore()
        
        let profiledata = ["username": usernameFromTF]
        
        db.collection("users").document(userIdFromAuth).setData(profiledata) { (error) in
            
            if error == nil {
                
                var newUser = PhotoUser()
                newUser.userId = userIdFromAuth
                newUser.username = usernameFromTF
                
                completion(newUser)
            }
            else {
                completion(nil)
            }
        }
        
    }
    
    
    static func retrieveProfile(userIdFromAuth: String, completion: @escaping(PhotoUser?) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userIdFromAuth).getDocument { (snapshot, error) in
            if error != nil || snapshot == nil {return}
            
            let profiledata = snapshot?.data()
            
            if let profiledata = profiledata {
                
                var currentUser = PhotoUser()
                currentUser.userId = snapshot!.documentID
                currentUser.username = profiledata["username"] as? String
                
                completion(currentUser)
            }
            else {
                completion(nil)
            }
            
        }
        
    }
}
