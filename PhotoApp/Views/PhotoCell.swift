//
//  PhotoCell.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import UIKit

class PhotoCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var photo: Photo?
    
    
    func displayPhoto(photo: Photo) {
        
        self.photo = photo
        photoImageView.image = nil
        
        usernameLabel.text = photo.byUsername
        dateLabel.text = photo.date
        
        
        if photo.url == nil {return}
        
        if let cachedImage =  ImageCacheService.loadPhoto(url: photo.url!) {
            photoImageView.image = cachedImage
            return
        }
        
        let url = URL(string: photo.url!)
        if url == nil {return}
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                let image = UIImage(data: data!)
                
                ImageCacheService.savePhoto(url: url!.absoluteString, image: image)
                
                if url!.absoluteString != self.photo!.url {return}
                
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
                
            }
        }
        
        dataTask.resume()
        
    }
    
}
