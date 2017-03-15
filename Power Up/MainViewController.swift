//
//  ViewController.swift
//  Power Up
//
//  Created by Guled on 1/21/17.
//  Copyright © 2017 Guled. All rights reserved.
//

import Foundation
import UIKit


/// A Container View Controller that contains a UIPageViewController and each page is represented as a ContentViewController.
class MainViewController: UIViewController {

    /// The UIPageViewController that will be embedded onto our MainViewController.
    var pageViewController: UIPageViewController!

    /// UIAlertViewController used to alert user if there is no internet connection available.
    var alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: UIAlertControllerStyle.alert)

    /// Boolean to indicate internet connection status.
    var noInternetConnection: Bool = false

    /// The ViewModel for the MainViewController View Controller 
    var mainViewModel: MainViewModel!

    /// Activity Indicator to display the progress of downloading our articles
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:
        UIActivityIndicatorViewStyle.whiteLarge)


    override func viewDidLoad() {

        super.viewDidLoad()

        // Setup UIAlertController
        alert.addAction(UIAlertAction(title: "Refresh", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in

            // Restart the downloading process
            self.startDownloadProcess()
        }))

        // Start downloading articles from the web.
        self.startDownloadProcess()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    public func startDownloadProcess(){

        ArticleService().get { [weak self] (response, data) in

            if response  {
                // Obtain the downloaded data
                self?.mainViewModel = MainViewModel(withArticles: data)

                // Setup the initial pageViewController
                self?.pageViewController = self?.storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! UIPageViewController

                self?.pageViewController.dataSource = self

                // Create the first ContentViewController
                let startViewController = (self?.viewControllerAtIndex(index: 0))! as ContentViewController

                let viewControllers = [startViewController]

                self?.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)

                // Move the pageViewController slightly from the bottom of the screen
                self?.pageViewController.view.frame = CGRect(x: 0, y: 0, width: (self?.view.frame.size.width)!, height: (self?.view.frame.size.height)! - 30)


                // Append the pageViewController to our MainViewController
                self?.addChildViewController((self?.pageViewController)!)
                
                self?.view.addSubview((self?.pageViewController.view)!)
                
                self?.pageViewController.didMove(toParentViewController: self)

                self?.hideActivityIndicatory()

            }else{

                self?.hideActivityIndicatory()

                // If there are no articles, send out an alert to refresh the app.
                self?.noInternetConnection = true

                self?.present((self?.alert)!, animated: true, completion: nil)

                }

            }
        }

    /**
     The showActivityIndicator method displays a UIActivityIndicatorView on the view specified by the 'currentView' variable.
     */
    func showActivityIndicator() {

        // Create the activityIndicatorView in the background
        DispatchQueue.main.async {

            self.activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)

            self.activityIndicator.center = CGPoint(x:self.view.bounds.size.width / 2, y:self.view.bounds.size.height / 2)

            self.view.addSubview(self.activityIndicator)

            self.activityIndicator.startAnimating()
            
        }
    }

    /**
     The hideActivityIndicatory method hides the UIActivityIndicatorView created by the showActivityIndictor method.
     */
    func hideActivityIndicatory() {

        DispatchQueue.main.async {

            self.activityIndicator.stopAnimating()
        }
        
    }
    



}
