//
//  Article .swift
//  Power Up
//
//  Created by Guled on 1/22/17.
//  Copyright © 2017 Guled. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class Article {
    
    var author: String!
    var title: String!
    var description: String!
    var url: URL!
    var imageURL: String!
    var image:UIImage!
    
    init(author:String, title:String, description:String, url:URL, imageURL:String){
        
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.imageURL = imageURL
    }
    
    
}
