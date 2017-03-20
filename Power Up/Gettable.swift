//
//  Gettable.swift
//  Power Up
//
//  Created by Guled  on 3/15/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation

/// Protocol that defines method to extract JSON data from Polygon
protocol Gettable {

    /**
     The get method handles extracting articles from Polygon.

     - parameter completionHandler: A closure used to capture errors and, if successful, a list of articles from Polygon.

    */
    func get(completionHandler:  @escaping (Bool, [ArticleViewModel]) -> ())
}

extension Gettable {
    /**
     The validateJSONData method takes in JSON data, in the form of a dictionary, from the data downloaded from the source URL (using Alamofire) and checks for nil values within the data. If any nil values are found, based on the amount of missing data, the article will be skipped or altered slightly.

     - parameter jsonData: Data obtained from Alamofire in JSON format.
     - returns: A list of 'Article' Objects.
     */
    func validateJSONData(jsonData: [[String:AnyObject]]) -> [ArticleViewModel] {

        var author: String?

        var title: String?

        var description: String?

        var articleUrl: URL?

        var articleImageUrl: String?

        var articles: [ArticleViewModel] = []

        for article in jsonData {

            // Check if any of the articles attributes are nil values

            // Author
            if let potentialAuthor =  article["author"] as? String {

                author = potentialAuthor

            } else {

                author = "Anonymous"
            }

            // Title
            if let potentialTitle =  article["title"] as? String {

                title = potentialTitle

            } else {

                title = "UnKnown"
            }

            // Description
            if let potentialDescription =  article["description"] as? String {

                description = potentialDescription

            } else {

                description = ""
            }


            // Article URL
            if let potentialUrl =  article["url"] as? String {

                articleUrl = URL(string: potentialUrl)

            } else {

                // If there is no URL available for the article, skip the article
                // We cannot work with data that is not available for our detailViewController
                continue
            }

            // Image URL
            if let potentialImageUrl =  article["urlToImage"] as? String {

                articleImageUrl = potentialImageUrl

            } else {
                // If there is no image associated with the article, replace it with our default image
                articleImageUrl = "noimage"
            }

            // Create a new article object from the available data
            let newArticle = Article(author: author!, title: title!, description: description!, url: articleUrl!, imageUrl: articleImageUrl!)

            // Add the article to our articles list
            articles.append(ArticleViewModel(article: newArticle))

        }

        return articles

    }
}
