//
//  ArticleViewModelSpec.swift
//  Power Up
//
//  Created by Guled  on 3/20/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Power_Up


class ArticleViewModelSpec: QuickSpec {


    var fakeArticle: Article?
    var fakeArticleViewModel: ArticleViewModel?

    override func spec() {


        beforeSuite {
            self.fakeArticle = Article(author: "Fake Author", title: "Fake Title", description: "Fake Description", url: URL(string:"http://www.asjdfljasdlkfjaldfjaljsdfakefakewhatfake.com")!, imageUrl: "noimage")

            self.fakeArticleViewModel = ArticleViewModel(article: self.fakeArticle!)
        }


        it("Should display the author of an article.") {
            expect(self.fakeArticleViewModel?.authorText).to(equal("Written by Fake Author"))
        }

        it("Should display the title text of an article.") {
            expect(self.fakeArticleViewModel?.titleText).to(equal("Fake Title"))
        }

        it("Should display the description  of an article.") {
            expect(self.fakeArticleViewModel?.descriptionText).to(equal("Fake Description"))
        }

        it("Should display the url of an article.") {
            expect(self.fakeArticleViewModel?.articleUrl).to(equal(URL(string: "http://www.asjdfljasdlkfjaldfjaljsdfakefakewhatfake.com")))
        }

        it("Should display the image url of an article.") {
            expect(self.fakeArticleViewModel?.imageURL).to(equal("noimage"))
        }

    }
}
