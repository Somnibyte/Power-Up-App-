//
//  ArticleDownloader.swift
//  Power Up
//
//  Created by Guled on 1/22/17.
//  Copyright © 2017 Guled. All rights reserved.
//

import Foundation
import Alamofire


final class ArticleDownloader{
    
    var source = "https://newsapi.org/v1/articles?source=polygon&sortBy=top&apiKey=9cd682bad8e8419780f3d08939fd9df7"
    
    var currentView:UIView!
    
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:
        UIActivityIndicatorViewStyle.whiteLarge)
    
    init(view:UIView){
        
        // The view variable helps specify where our activityIndicatorView will be placed on.
        self.currentView = view
    }

    
    /**
     The downloadArticles method downloads articles (in JSON format) from the 'source' variable (above).
     */
    func downloadArticles(completion:@escaping (Bool, [Article]) -> ()){
        
        showActivityIndicator()
        // Array holding our 'Article' objects
        var articles: [Article] = []
        
        // Make a request to the NewsAPI
        Alamofire.request(source).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value as? [String: AnyObject] {
                    
                    // Create 'Article' objects from the JSON data
                    let arrayOfArticles = json["articles"] as! [[String:AnyObject]]
                    articles = self.validateJSONData(jsonData: arrayOfArticles)
                    completion(true, articles)
                    self.hideActivityIndicatory()
            
                }
            case .failure( _):
                completion(false, [])
                self.hideActivityIndicatory()
            }
        }
        
        
    }
    

    /**
     The validateJSONData method takes in JSON data, in the form of a dictionary, from the data downloaded from the source URL (using Alamofire) and checks for nil values within the data. If any nil values are found, based on the amount of missing data, the article will be skipped or altered slightly.
     
     - parameter jsonData: Data obtained from Alamofire in JSON format.
     - returns: A list of 'Article' Objects.
     */
     func validateJSONData(jsonData:[[String:AnyObject]]) -> [Article]{
        var author:String!
        var title:String!
        var description:String!
        var articleURL: URL!
        var articleImageURL:String!
        
        var articles:[Article] = []
        
        for article in jsonData {
            
            // Check if any of the articles attributes are nil values
            
            // Author
            if let potentialAuthor =  article["author"] as? String {
                author = potentialAuthor
            }else {
                author = "Anonymous"
            }
            
            // Title
            if let potentialTitle =  article["title"] as? String {
                title = potentialTitle
            }else {
                title = "UnKnown"
            }
            
            // Description
            if let potentialDescrip =  article["description"] as? String {
                description = potentialDescrip
            }else {
                description = ""
                
            }
            
            // Article URL
            if let potentialURL =  article["url"] as? String {
                articleURL = URL(string: potentialURL)
            }else {
                
                // If there is no URL available for the article, skip the article
                // We cannot work with data that is not available for our detailViewController 
                continue
            }
            
            // Image URL
            if let potentialImageURL =  article["urlToImage"] as? String {
                
                articleImageURL = potentialImageURL
                
            }else {
                // If there is no image associated with the article, replace it with our default image
                articleImageURL = "noimage"
            }
            
            
 
            // Create a new article object from the available data
            let newArticle = Article(author: author, title: title, description: description, url: articleURL, imageURL: articleImageURL)
           
            // Add the article to our articles list
            articles.append(newArticle)
            
        }
        
        return articles
        
    }
    
    
    /**
     The showActivityIndicator method displays a UIActivityIndicatorView on the view specified by the 'currentView' variable.
     */
    func showActivityIndicator(){
        
        // Create the activityIndicatorView in the background
        DispatchQueue.main.async {
            
            self.activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            
            self.activityIndicator.center = CGPoint(x:self.currentView.bounds.size.width / 2, y:self.currentView.bounds.size.height / 2)
            
            self.currentView.addSubview(self.activityIndicator)
            
            self.activityIndicator.startAnimating()

        }
    }
    
    /**
     The hideActivityIndicatory method hides the UIActivityIndicatorView created by the showActivityIndictor method.
     */
    func hideActivityIndicatory(){
        
        DispatchQueue.main.async {
            
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    
}
