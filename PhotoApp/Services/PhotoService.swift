//
//  PhotoService.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class PhotoService {
    
    
    static func savePhoto(selectedImage: UIImage) {
        
        let photoData = selectedImage.jpegData(compressionQuality: 1)
        if photoData == nil {return}
        
        let filename = UUID().uuidString
        
        let userId = Auth.auth().currentUser?.uid
        if userId == nil {return}
        
        let ref = Storage.storage().reference().child("images/\(userId!)/\(filename)")
        
        ref.putData(photoData!, metadata: nil) { (metadata, error) in
             
            if error == nil {
                
                createDatabaseEntry(ref: ref)
            }
        }
        
    }
    
    static private func createDatabaseEntry(ref: StorageReference) {
        
        ref.downloadURL { (url, error) in
            if error == nil {
                
                let photoId = ref.fullPath
                
                let user = LocalStorageService.loadUser()
                
                let userId = user?.userId
                let username = user?.username
                
                let df = DateFormatter()
                df.dateStyle = .full
                let date = df.string(from: Date())
                
                let metadata = ["photoId": photoId, "byId": userId, "byUsername" : username, "date": date , "url": url!.absoluteString]
                
                let db = Firestore.firestore()
                
                db.collection("photos").addDocument(data: metadata) { (error) in
                    
                    if error != nil {
                        return
                    }
                }
            }

        }
    }
}
