//
//  Article .swift
//  Power Up
//
//  Created by Guled on 1/22/17.
//  Copyright © 2017 Guled. All rights reserved.
//

import Foundation
import UIKit

struct Article {

    /// Author of the article
    var author: String?

    /// Title of the article
    var title: String?

    /// Description of the article
    var description: String?

    /// URL of the article
    var url: URL?

    /// Image url of the article
    var imageUrl: String?

    /// The image of the article itself
    var image: UIImage?

    init(author: String, title: String, description: String, url: URL, imageUrl: String) {

        self.author = author

        self.title = title

        self.description = description

        self.url = url

        self.imageUrl = imageUrl
    }
}
