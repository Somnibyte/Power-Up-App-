//
//  ArticleDownloaderTests.swift
//  Power Up
//
//  Created by Guled on 1/24/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import XCTest
@testable import Power_Up 

class ArticleDownloaderTests: XCTestCase {
    
    
    var articleDownloader:ArticleDownloader!
    var mainViewController: MainViewController!
    
    override func setUp() {
        super.setUp()
        
        
        // Setup our view that the articleDownloader will use 
        mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        // Setup our ArticleDownloader class 
        articleDownloader = ArticleDownloader(view: mainViewController.view)
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // Test if the ArticleDownloader class is able to download the article successfully and 
    // there are exactly 10 top articles from the source.
    func testArticleDownload(){
        
        articleDownloader.downloadArticles(completion: { success, data in
            
            XCTAssertTrue(success, "Data was successfully extracted.")
            
            XCTAssertEqual(data.count, 10)
        })
    }
    
    // Test a situation where the source has been changed or is non-existant. 
    func testArticleDownloadFailure(){
        
        // Manipulate the source variable
        articleDownloader.source = ""
        
        articleDownloader.downloadArticles(completion: { success, data in
            
            XCTAssertFalse(success, "Data does not exist. Source is invalid or there is no connection.")
            
            XCTAssertEqual(data.count, 0)
        })
        
    }
    
    
}
