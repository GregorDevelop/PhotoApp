//
//  UserService.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import Foundation
import FirebaseFirestore


class UserService {
   
    
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
