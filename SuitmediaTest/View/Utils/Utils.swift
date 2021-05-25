//
//  Utils.swift
//  SuitmediaTest
//
//  Created by MacBook on 24/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public func downloadImage(urlString: String) -> UIImage? {
        let url = URL(string: urlString)
        var image: UIImage?
        if let url = url {
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                DispatchQueue.main.async() {
                    image = UIImage(data: data)
                }
            }
        }
        return image
    }
    
    

}
