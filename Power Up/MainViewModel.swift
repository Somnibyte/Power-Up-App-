//
//  MainViewModel.swift
//  Power Up
//
//  Created by Guled  on 3/15/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//


/// ViewModel for the MainViewController class.
class MainViewModel {

    /// List of Article Model
    let articles: [Article]

    init(withArticles articles: [Article]) {

        self.articles = articles
    }

    /**
     The getSourceText method returns a piece of text that symbolizes what section of the Polygon website that the news articles are
     extracted from.

     - returns: The source text for our ContentViewConroller.

    */
    func getSourceText() -> String {

        return "Polygon - Top Posts"

    }

}
