//
//  MainViewControllerPageViewDataSource.swift
//  Power Up
//
//  Created by Guled on 1/24/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import UIKit


// UIPageViewControllerDataSource Methods for MainViewController.
extension MainViewController: UIPageViewControllerDataSource {


    /**
     The viewControllerAtIndex method provides the ContentViewController with the appropriate data (images, title, etc..) for the uipageviewcontroller's pages.

     - parameter index: Index indicating which page we are currently on (pageView dots).
     - returns: A ContentViewController. The view controller that is going to be displayed on the uipageviewcontroller.
     */
    func viewControllerAtIndex(index: Int) -> ContentViewController {

        // If there are no articles, send out an alert to refresh the app.
        if articles.count == 0 || index >= articles.count {

            return ContentViewController()
        }

        let contentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController

        // Add the contents of each article to the contentViewController
        contentViewController.pageIndex = index

        contentViewController.articleViewModel = articles[index]

        return contentViewController
    }

    // MARK: - UIPageViewController DataSource Methods

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let contentViewController = viewController as! ContentViewController

        var index = contentViewController.pageIndex! as Int

        // There is no 'previous' viewcontroller before index 0.
        // In this case we return nil
        if index == 0 || index == NSNotFound {

            return nil

        }

        // Otherwise, proceed to displaying other pages.
        index -= 1

        return self.viewControllerAtIndex(index: index)

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let contentViewController = viewController as! ContentViewController

        var index = contentViewController.pageIndex! as Int

        if index == NSNotFound {

            return nil
        }

        index += 1

        // If the index is at the last article, do not return anything as there is no other page after the last page.
        if index == self.articles.count {

            return nil

        }

        return self.viewControllerAtIndex(index: index)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {

        return self.articles.count

    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        return 0

    }
}
