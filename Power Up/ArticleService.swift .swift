//
//  ArticleService.swift .swift
//  Power Up
//
//  Created by Guled  on 3/15/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//
import Alamofire

struct ArticleService: Gettable {

    func get(completionHandler: @escaping (Bool, [Article]) -> ()) {

        // Array holding our 'Article' objects
        var articles: [Article] = []

        // Make a request to the NewsAPI
        Alamofire.request("https://newsapi.org/v1/articles?source=polygon&sortBy=top&apiKey=9cd682bad8e8419780f3d08939fd9df7").validate().responseJSON { response in
            switch response.result {

            case .success:
                if let json = response.result.value as? [String: AnyObject] {

                    // Create 'Article' objects from the JSON data
                    let arrayOfArticles = json["articles"] as! [[String:AnyObject]]

                    articles = self.validateJSONData(jsonData: arrayOfArticles)

                    completionHandler(true, articles)

                }
            case .failure( _):
                
                completionHandler(false, [])
            
            }
        }
    }

}
