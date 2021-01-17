//
//  ContentModel.swift
//  What2Cook
//
//  Created by Maizi Liao on 2021-01-16.
//

import UIKit
import Foundation

var materials = [String]()

struct MaterialImage: Identifiable {
    var id: Int
    var imageUrl: URL?
    var image: UIImage
    
    init() {
        id = UUID().hashValue
        imageUrl = URL(string: "")
        image = UIImage()
    }
    
    init(image: UIImage) {
        id = UUID().hashValue
        imageUrl = URL(string: "")
        self.image = image
    }
}

struct Food: Codable, Identifiable {
    var id: Int
    var name: String
    var url: String
    var materials: [String]
    
    init() {
        id = UUID().hashValue
        name = ""
        url = ""
        materials = [String]()
    }
}
