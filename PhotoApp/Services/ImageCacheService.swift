//
//  ImageCacheService.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import UIKit



class ImageCacheService {
    
    
    static var imageCache = [String: UIImage]()
    
    
    
    static func savePhoto(url: String?, image: UIImage?) {
        
        if url != nil && image != nil {
            imageCache[url!] = image
        }
    }
    
    
    static func loadPhoto(url: String?) -> UIImage? {
        
        if url == nil { return nil}
        
        else {
            return imageCache[url!]
        }
        
    }
}
