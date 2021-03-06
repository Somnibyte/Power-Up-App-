//
//  ContentViewController.swift
//  Power Up
//
//  Created by Guled on 1/21/17.
//  Copyright © 2017 Guled. All rights reserved.
//

import UIKit
import AlamofireImage

/// View Controller that represents a page within a UIPageViewController.
class ContentViewController: UIViewController {

    @IBOutlet var articleImage: UIImageView!

    @IBOutlet var sourceLabel: UILabel!

    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var leftWall: UIView!

    /// ViewModel for ContentViewController
    var articleViewModel: ArticleViewModel?

    /// Index of the current page (pageView). Could be used to tell which article we are reading (ex. Article #1)
    var pageIndex: Int?

    /// ImageDownloader Object from AlamofireImage to apply image resizing effects
    let downloader = ImageDownloader()

    /// Activity Indicator to display the progress of downloading our articles
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:
        UIActivityIndicatorViewStyle.whiteLarge)


    override func viewDidLoad() {

        super.viewDidLoad()

        // Setup the labels within the view

        // Check if the source text is available
        if let potentialSourceText = articleViewModel?.getSourceText() {

            self.sourceLabel.text = potentialSourceText

        }

        // Check if the articles title is available
        if let potentialTitle = articleViewModel?.titleText {

            self.titleLabel.text = potentialTitle

            self.titleLabel.sizeToFit()
        }

        // Download the image from the provided article image URL
        if articleViewModel?.imageURL != nil {

            if articleViewModel?.imageURL == "noimage" {

                // If the article never came with an image, put in a placeholder
                articleImage.image = UIImage(named: "noimage")

            } else if articleImage.image == nil {

                downloadImage()
            }
        }

        // Add tap gesture (This will lead us to transitioning to the detailViewController
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ContentViewController.didTapView(sender:)))

        self.view.addGestureRecognizer(gesture)

    }

    override func viewDidDisappear(_ animated: Bool) {

        super.viewDidDisappear(true)

        // Make sure an image exists
        if articleViewModel?.imageURL != nil {

            // Resize the image back to normal (originally animated in viewDidAppear method).
            UIView.animate(withDuration: 0.1) {

                self.articleImage.transform = CGAffineTransform.identity
            }
        }

    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(true)

        // Make sure an image exists
        if articleViewModel?.imageURL != nil {

            // Animate the labels, and image on the view
            animateLabelsAndViews()
        }
    }


    // MARK: - CONTROLLER METHODS

    /**
     The didTapView method initiates the transition to the detailViewController.
     */
    func didTapView(sender: UITapGestureRecognizer) {

        performSegue(withIdentifier: "showDetailView", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Segue for detailViewController
        if segue.identifier == "showDetailView" {

            let detailView = segue.destination as! DetailViewController

            detailView.articleViewModel = articleViewModel
            detailView.image = self.articleImage.image
        }
    }

    /**
     The animateLabelsandViews method animates the article image to give it a "growth" effect.
     */
    func animateLabelsAndViews() {

        // Animate the UIImageView with a "zoom-in" effect
        UIView.animate(withDuration: 1.3) {

            self.articleImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }

    }

    /**
     The downloadImage method applies downloads the image provided by the URL (imageURL variable) given by the mainViewController once the articles are downloaded into the app.
     */
    func downloadImage() {

        let urlRequest = URLRequest(url: URL(string: (self.articleViewModel?.imageURL!)!)!)
        showActivityIndicator()

        downloader.download(urlRequest) { response in

            if let downloadedImage = response.result.value {

                // Scale the image to the exact size of the articleImage (UIImageView).
                let aspectScaledToFillImage = downloadedImage.af_imageAspectScaled(toFill: self.articleImage.frame.size)

                // Apply a dark gradient to the aspectScaledToFillImage (UIImage)
                self.articleImage.image = aspectScaledToFillImage.imageWithDarkGradient()
            }
        }

        hideActivityIndicator()
    }


    /**
     The showActivityIndicator method displays a UIActivityIndicatorView. */
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
     The hideActivityIndicator method hides the UIActivityIndicatorView created by the showActivityIndictor method.
     */
    func hideActivityIndicator() {

        DispatchQueue.main.async {

            self.activityIndicator.stopAnimating()
        }

    }


 }
