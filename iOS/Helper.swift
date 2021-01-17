//
//  Helper.swift
//  What2Cook
//
//  Created by Maizi Liao on 2021-01-17.
//

import UIKit
import Foundation

func getUIImage(url: String) -> UIImage {
    let lock = NSLock()
    var result = UIImage()
    
    guard let serviceUrl = URL(string: url) else { return UIImage() }
    let task = URLSession.shared.dataTask(with: serviceUrl) { (data, response, error) in
        guard let data = data else { return }
        guard let uiImage = UIImage(data: data) else { return }
        result = uiImage
        lock.unlock()
    }
    task.resume()
    lock.lock()
    
    return result
}
