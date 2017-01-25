//
//  MainViewControllerTests.swift
//  Power Up
//
//  Created by Guled on 1/24/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import XCTest
@testable import Power_Up 

class MainViewControllerTests: XCTestCase {
    
    
    var mainViewController: MainViewController!
    var articleDownloader:ArticleDownloader!
    
    
    override func setUp() {
        super.setUp()

        // Setup MainViewController
        mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        // Setup our ArticleDownloader class
        articleDownloader = ArticleDownloader(view: mainViewController.view)
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    // Test if the pageViewController is attached to the mainViewController and that there are 10 articles ready for the user to consume. 
    func testIfPageViewControllerIsSetAfterLoading(){
        

        articleDownloader.downloadArticles(completion: { success, data in
            
            // Obtain the downloaded data
            self.mainViewController.articles = data
            
            // Setup the initial pageViewController
            self.mainViewController.pageViewController = self.mainViewController.storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! UIPageViewController
            
            self.mainViewController.pageViewController.dataSource = self.mainViewController
            
            let startVC = self.mainViewController.viewControllerAtIndex(index: 0) as ContentViewController
            
            let viewControllers = [startVC]
            
            self.mainViewController.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
            
            self.mainViewController.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.mainViewController.view.frame.size.width, height: self.mainViewController.view.frame.size.height - 30)
            
            self.mainViewController.addChildViewController(self.mainViewController.pageViewController)
            self.mainViewController.view.addSubview(self.mainViewController.pageViewController.view)
            
            self.mainViewController.pageViewController.didMove(toParentViewController: self.mainViewController.pageViewController)
            
            
            // The pageViewController should now be existant
            XCTAssertNotNil(self.mainViewController.pageViewController, "The pageViewController should now be existant.")
            
            
            // There should be 10 articles when everything has been loaded
            XCTAssertEqual(self.mainViewController.articles.count, 10)
            
        })
    }
    
    // Test if the MainViewController recognizes that there are no articles to be found via the noInternetConnection Bool. Which, in effect, triggers a UIAlertController to popup
    func testNoInternetConnectionBool(){
        
        articleDownloader.downloadArticles(completion: { success, data in
            
            // Obtain the downloaded data
            self.mainViewController.articles = []
            
            // Setup the initial pageViewController
            self.mainViewController.pageViewController = self.mainViewController.storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! UIPageViewController
            
            self.mainViewController.pageViewController.dataSource = self.mainViewController
            
            let startVC = self.mainViewController.viewControllerAtIndex(index: 0) as ContentViewController
            
            let viewControllers = [startVC]
            
            self.mainViewController.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
            
            self.mainViewController.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.mainViewController.view.frame.size.width, height: self.mainViewController.view.frame.size.height - 30)
            
            self.mainViewController.addChildViewController(self.mainViewController.pageViewController)
            self.mainViewController.view.addSubview(self.mainViewController.pageViewController.view)
            
            self.mainViewController.pageViewController.didMove(toParentViewController: self.mainViewController.pageViewController)
        
            
            XCTAssertTrue(self.mainViewController.noInternetConnection, "No Internet Connection was available.")
            
        })
        
    }
    
}
