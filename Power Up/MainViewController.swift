//
//  ViewController.swift
//  Power Up
//
//  Created by Guled on 1/21/17.
//  Copyright © 2017 Guled. All rights reserved.
//

import UIKit


class MainViewController: UIViewController{
    
    var pageViewController:UIPageViewController! // The UIPageViewController that will be embedded onto our MainViewController
    
    var articles:[Article] = [] // Array that holds the data for the UIPageViewController
    
    var articleDownloader:ArticleDownloader! // An object that downloads articles to fill the 'articles' variable with data 
    
    var alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: UIAlertControllerStyle.alert)
    
    var noInternetConnection:Bool = false 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start downloading articles from the web.
        self.startDownloadProcess()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     The startDownloadProcess method initiates downloading articles from the web. 
     */
    func startDownloadProcess(){

        // Instantiate the ArticleDownloader class in order to start the donwloading process
        articleDownloader = ArticleDownloader(view: self.view)
        
        articleDownloader.downloadArticles(completion: { success, data in
            
            // Obtain the downloaded data
            self.articles = data 
            
            // Setup the initial pageViewController
            self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! UIPageViewController
            
            self.pageViewController.dataSource = self
            
            // Create the first ContentViewController
            let startVC = self.viewControllerAtIndex(index: 0) as ContentViewController
            
            let viewControllers = [startVC]
            
            self.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
            
            // Move the pageViewController slightly from the bottom of the screen
            self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 30)
            
            
            // Append the pageViewController to our MainViewController
            self.addChildViewController(self.pageViewController)
            
            self.view.addSubview(self.pageViewController.view)
            
            self.pageViewController.didMove(toParentViewController: self)
            
        })
        
    }

    
    
}

