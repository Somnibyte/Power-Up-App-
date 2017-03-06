//
//  DetailViewControllerSpec.swift
//  Power Up
//
//  Created by Guled  on 3/1/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Power_Up

class DetailViewControllerSpec: QuickSpec {


    var articleDownloader: ArticleDownloader!
    
    var mainViewController: MainViewController!

    override func spec() {

        beforeSuite {

            // Setup MainViewController
            self.mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController

            // Setup our ArticleDownloader class
            self.articleDownloader = ArticleDownloader(view: self.mainViewController.view, source: "https://newsapi.org/v1/articles?source=polygon&sortBy=top&apiKey=9cd682bad8e8419780f3d08939fd9df7")
        }

        it("Should contain the correct information from an article that is passed to this view via delegate.", closure: {



        })


    }

}
