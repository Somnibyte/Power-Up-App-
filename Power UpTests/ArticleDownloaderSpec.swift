//
//  ArticleDownloaderSpec.swift
//  Power Up
//
//  Created by Guled  on 3/1/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Power_Up

class ArticleDownloaderSpec: QuickSpec {

    var articleDownloader: ArticleDownloader!
    var mainViewController: MainViewController!

    override func spec() {

        beforeSuite {

            // Setup MainViewController
            self.mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController

            // Setup our ArticleDownloader class
            self.articleDownloader = ArticleDownloader(view: self.mainViewController.view, source: "https://newsapi.org/v1/articles?source=polygon&sortBy=top&apiKey=9cd682bad8e8419780f3d08939fd9df7")
        }

        it("[validateJSONData method] Should disregard the article given if no data is provided.", closure: {

            let dummyData: [[String:AnyObject]] = []
            let articles = self.articleDownloader.validateJSONData(jsonData: dummyData)

            expect(articles).to(beEmpty())
        })

        it("[validateJSONData method] Should replace author with \"Anonymous\" if no author is given.", closure: {

            let empty: AnyObject? = nil
            let dummyData: [[String:AnyObject]] = [["title":"Random Title" as AnyObject, "description": "Random Description" as AnyObject, "url": "http://www.asjdfljasdlkfjaldfjaljsdfakefakewhatfake.com" as AnyObject, "urlToImage":"noimage" as AnyObject]]
            let articles = self.articleDownloader.validateJSONData(jsonData: dummyData)

            expect(articles).toNot(beEmpty())
            expect(articles[0].author).to(equal("Anonymous"))
        })

        it("[validateJSONData method] Should replace the title with \"Uknown\" if not title is given.", closure: {

            let empty: AnyObject? = nil
            let dummyData: [[String:AnyObject]] = [["author":"Random Author" as AnyObject, "description": "Random Description" as AnyObject, "url": "http://www.asjdfljasdlkfjaldfjaljsdfakefakewhatfake.com" as AnyObject, "urlToImage":"noimage" as AnyObject]]
            let articles = self.articleDownloader.validateJSONData(jsonData: dummyData)

            expect(articles).toNot(beEmpty())
            expect(articles[0].title).to(equal("UnKnown"))
        })

        it("[validateJSONData method] Should replace the description with \" \" if not description is given.", closure: {

            let empty: AnyObject? = nil
            let dummyData: [[String:AnyObject]] = [["author":"Random Author" as AnyObject, "title": "Random Title" as AnyObject, "url": "http://www.asjdfljasdlkfjaldfjaljsdfakefakewhatfake.com" as AnyObject, "urlToImage":"noimage" as AnyObject]]
            let articles = self.articleDownloader.validateJSONData(jsonData: dummyData)

            expect(articles).toNot(beEmpty())
            expect(articles[0].description).to(equal(""))
        })

        it("[validateJSONData method] Should disregard the article if no URL is given. ", closure: {

            let empty: AnyObject? = nil
            let dummyData: [[String:AnyObject]] = [["author":"Random Author" as AnyObject, "title": "Random Title" as AnyObject, "description": "Random Description" as AnyObject, "urlToImage":"noimage" as AnyObject]]
            let articles = self.articleDownloader.validateJSONData(jsonData: dummyData)

            expect(articles).to(beEmpty())
        })

        it("[validateJSONData method] Should replace the article image with \"noimage\" asset name.", closure: {


            let empty: AnyObject? = nil
            let dummyData: [[String:AnyObject]] = [["author":"Random Author" as AnyObject, "title": "Random Title" as AnyObject, "description": "Random Description" as AnyObject, "url": "http://www.asjdfljasdlkfjaldfjaljsdfakefakewhatfake.com" as AnyObject]]
            let articles = self.articleDownloader.validateJSONData(jsonData: dummyData)

            expect(articles).toNot(beEmpty())
            expect(articles[0].imageUrl).to(equal("noimage"))
        })
    }

}
