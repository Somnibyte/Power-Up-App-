//
//  MainViewModel.swift
//  Power Up
//
//  Created by Guled  on 3/15/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import UIKit

/// ViewModel for our Article objects
class ArticleViewModel {

    /// ViewModel's Article Object
    private var article: Article

    /// Author text
    var authorText: String? {
        guard let author = article.author else {
            return nil
        }

        return "Written by \(author)"
    }

    /// Title text
    var titleText: String? {
        return article.title
    }

    /// Description text
    var descriptionText: String? {
        return article.description
    }

    /// Url of a Article object
    var articleUrl: URL? {
        return article.url
    }

    /// URL of the image of a particular Article object
    var imageURL: String? {
        return article.imageUrl
    }



    init(article: Article) {
        self.article = article
    }

    /**
     The getSourceText method returns a piece of text that symbolizes what section of the Polygon website that the news articles are
     extracted from.

     - returns: The source text for our ContentViewConroller.

    */
    func getSourceText() -> String {

        return "Polygon - Top Posts"

    }

}
