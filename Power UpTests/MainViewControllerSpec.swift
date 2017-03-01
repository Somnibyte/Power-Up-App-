//
//  MainViewControllerSpec.swift
//  Power Up
//
//  Created by Guled  on 3/1/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Power_Up

class MainViewControllerSpec: QuickSpec {


    var mainViewController: MainViewController!

    var articleDownloader: ArticleDownloader!

    override func spec() {


        beforeSuite {
            // Setup MainViewController
            self.mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController

            // Setup our ArticleDownloader class
            self.articleDownloader = ArticleDownloader(view: self.mainViewController.view, source: "https://newsapi.org/v1/articles?source=polygon&sortBy=top&apiKey=9cd682bad8e8419780f3d08939fd9df7")

        }

        it("Should not have a pageViewController that is nil.", closure: {

            self.articleDownloader.downloadArticles(completion: { success, data in

                // Obtain the downloaded data
                self.mainViewController.articles = data

                // Setup the initial pageViewController
                self.mainViewController.pageViewController = self.mainViewController.storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! UIPageViewController

                self.mainViewController.pageViewController.dataSource = self.mainViewController

                let startingViewController = self.mainViewController.viewControllerAtIndex(index: 0) as ContentViewController

                let viewControllers = [startingViewController]

                self.mainViewController.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)

                self.mainViewController.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.mainViewController.view.frame.size.width, height: self.mainViewController.view.frame.size.height - 30)

                self.mainViewController.addChildViewController(self.mainViewController.pageViewController)
                self.mainViewController.view.addSubview(self.mainViewController.pageViewController.view)

                self.mainViewController.pageViewController.didMove(toParentViewController: self.mainViewController.pageViewController)

                expect(self.mainViewController.pageViewController).toNot(beNil())

            })

        })


        it("Should have at most 10 articles readily available.", closure: {

            self.articleDownloader.downloadArticles(completion: { success, data in

                // Obtain the downloaded data
                self.mainViewController.articles = data

                // Setup the initial pageViewController
                self.mainViewController.pageViewController = self.mainViewController.storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! UIPageViewController

                self.mainViewController.pageViewController.dataSource = self.mainViewController

                let startingViewController = self.mainViewController.viewControllerAtIndex(index: 0) as ContentViewController

                let viewControllers = [startingViewController]

                self.mainViewController.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)

                self.mainViewController.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.mainViewController.view.frame.size.width, height: self.mainViewController.view.frame.size.height - 30)

                self.mainViewController.addChildViewController(self.mainViewController.pageViewController)
                self.mainViewController.view.addSubview(self.mainViewController.pageViewController.view)

                self.mainViewController.pageViewController.didMove(toParentViewController: self.mainViewController.pageViewController)

                expect(self.mainViewController.articles.count).to(beGreaterThan(0))
            })
        })


        it("Should display a UIAlertViewController if there is no internet connection.", closure: {

            self.articleDownloader.downloadArticles(completion: { success, data in

                if !success {
                    expect(self.mainViewController.alert.isBeingPresented).toNot(beFalse())
                }

            })


        })

    }
}
