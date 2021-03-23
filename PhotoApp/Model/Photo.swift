//
//  Photo.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import Foundation
import FirebaseFirestore

struct Photo {
    
    var photoId: String?
    var byId: String?
    var byUsername: String?
    var date: String?
    var url: String?

    
    init? (snapshot: QueryDocumentSnapshot) {
        
        let data = snapshot.data()
        
        let photoId = data["photoId"] as? String
        let userId = data["byId"] as? String
        let username = data["byUsername"] as? String
        let date = data["date"] as? String
        let url = data["url"] as? String

        if photoId == nil || userId == nil || username == nil || date == nil || url == nil {return}
        
        self.photoId = photoId
        self.byId = userId
        self.byUsername = username
        self.date = date
        self.url = url

    }
    
}
