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

    override func spec() {


        beforeSuite {
            // Setup MainViewController
            self.mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController

            self.mainViewController.startDownloadProcess()
        }

        it("Should not have a pageViewController that is nil.", closure: {


            expect(self.mainViewController.pageViewController).toEventuallyNot(beNil())

        })

        it("Should have at most 10 articles readily available.", closure: {

            expect(self.mainViewController.mainViewModel.articles.count).to(beGreaterThan(0))
        })

    }
}
