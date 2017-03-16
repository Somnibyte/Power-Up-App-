//
//  ContentViewControllerSpec.swift
//  Power Up
//
//  Created by Guled  on 3/1/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Power_Up


class ContentViewControllerSpec: QuickSpec {

    var mainViewController: MainViewController!

    var mainViewControllerPageViewController: UIPageViewController?

    override func spec() {

        beforeSuite {

            // Setup MainViewController
            self.mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController


            ArticleService().get { [weak self] (response, data) in

                if response  {
                    // Obtain the downloaded data
                    self?.mainViewController.mainViewModel = MainViewModel(withArticles: data)

                    // Setup the initial pageViewController
                    self?.mainViewController.pageViewController = self?.mainViewController.storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! UIPageViewController

                    self?.mainViewController.pageViewController.dataSource = self?.mainViewController

                    // Create the first ContentViewController
                    let startViewController = (self?.mainViewController.viewControllerAtIndex(index: 0))! as ContentViewController

                    let viewControllers = [startViewController]

                    self?.mainViewController.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)

                    // Move the pageViewController slightly from the bottom of the screen
                    self?.mainViewController.pageViewController.view.frame = CGRect(x: 0, y: 0, width: (self?.mainViewController.view.frame.size.width)!, height: (self?.mainViewController.view.frame.size.height)! - 30)


                    // Append the pageViewController to our MainViewController
                    self?.mainViewController.addChildViewController((self?.mainViewController.pageViewController)!)

                    self?.mainViewController.view.addSubview((self?.mainViewController.pageViewController.view)!)

                    self?.mainViewController.pageViewController.didMove(toParentViewController: self?.mainViewController)

                    self?.mainViewController.hideActivityIndicator()

                    self?.mainViewControllerPageViewController = self?.mainViewController.pageViewController

                }else{

                    self?.mainViewController.hideActivityIndicator()

                    // If there are no articles, send out an alert to refresh the app.
                    self?.mainViewController.noInternetConnection = true
                    
                    self?.mainViewController.present((self?.mainViewController.alert)!, animated: true, completion: nil)
                    
                }
                
            }


        }


        it("Should exist and the information must be the same as what is provided by the first Article in the MainViewController.") {


            expect(self.mainViewControllerPageViewController).toEventuallyNot(beNil())

            expect(self.mainViewControllerPageViewController?.viewControllers?[0] as! ContentViewController).toEventuallyNot(beNil())

            expect( (self.mainViewControllerPageViewController?.viewControllers?[0] as! ContentViewController).titleText).toEventually(equal(self.mainViewController.mainViewModel.articles[0].title))

            expect((self.mainViewControllerPageViewController?.viewControllers?[0] as! ContentViewController).articleUrl).toEventually(equal(self.mainViewController.mainViewModel.articles[0].url))

            expect((self.mainViewControllerPageViewController?.viewControllers?[0] as! ContentViewController).descriptionText).toEventually(equal(self.mainViewController.mainViewModel.articles[0].description))

            expect((self.mainViewControllerPageViewController?.viewControllers?[0] as! ContentViewController).imageUrl).toEventually(equal(self.mainViewController.mainViewModel.articles[0].imageUrl))

        }


        it("Should have an image downloaded from an Article imageURL") {

             expect( (self.mainViewControllerPageViewController?.viewControllers?[0] as! ContentViewController).articleImage).toEventuallyNot(beNil())
        }


    }
}


