//
//  GuestCollectionViewCell.swift
//  SuitmediaTest
//
//  Created by MacBook on 24/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class GuestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var guestViewContainer: UIView!
    @IBOutlet weak var guestImageView: UIImageView!
    @IBOutlet weak var guestNameLabel: UILabel!
    
    func configure(name: String, imageURL: String){
        
        // Assign Data
        guestNameLabel.text = name
        
        // Custom View Cell
        guestImageView.layer.cornerRadius = guestImageView.frame.height / 2
        
        // Load Image
        self.loadImage(urlString: imageURL) { (urlString, image) in
            
            // Caching image data
            self.cacheImage(urlString: urlString, img: image!)
            
            self.guestImageView.image = image
        }
    }

    func loadImage(urlString: String, completion: @escaping (String, UIImage?)->Void) {
        
        // Load image from cache memory
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String] {
            if let path = dict[urlString] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let img = UIImage(data: data)
                    
                    completion(urlString, img)
                }
            }
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard error == nil else { return }
            guard let d = data else { return }
            DispatchQueue.main.async {
                if let image = UIImage(data: d){
                    completion(urlString, image)
                }
            }
        }
        task.resume()
    }
    
    func cacheImage(urlString: String, img: UIImage){
        
        // Caching process
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = img.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
        if dict == nil {
            dict = [String:String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache"  )
    }

}
