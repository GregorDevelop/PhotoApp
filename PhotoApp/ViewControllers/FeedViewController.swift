//
//  FeedViewController.swift
//  PhotoApp
//
//  Created by Gregor Kramer on 23.03.2021.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        PhotoService.retrievePhoto { (photos) in
            self.photos = photos
            self.tableView.reloadData()
        }
        
    }
    



}


extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.photoCell, for: indexPath) as? PhotoCell
        
        let photo = photos[indexPath.row]
        
        cell?.displayPhoto(photo: photo)
        
        return cell!
    }
    
    
    
    
}
