//
//  detailViewController.swift
//  Power Up
//
//  Created by Guled on 1/24/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet var titleView: UIView!

    @IBOutlet var descriptionView: UIView!

    @IBOutlet var detailImage: UIImageView!

    @IBOutlet var detailTitleLabel: UILabel!

    @IBOutlet var detailDescripLabel: UILabel!

    @IBOutlet var safariButton: UIButton!

    /// Image of the article given by ContentViewController
    var image: UIImage?

    /// Title of the article given by ContentViewController
    var detailTitle: String?

    /// Description of the article given by ContentViewController
    var detailDescription: String?

    /// URL of the article given by ContentViewController
    var articleUrl: URL?

    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()

        // Hide the titleView, descriptionView, and safariButton
        self.titleView.alpha = 0

        self.descriptionView.alpha = 0

        self.safariButton.alpha = 0

        self.titleView.frame.origin.y -= 30

        self.descriptionView.frame.origin.y -= 30

        self.safariButton.frame.origin.y -= 30


    }
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(true)

        animateAllUIViewsOnStartup()
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        // Check if an image has been given to the detailViewController
        if let potentialImage = image {

            // Resize the image to fit within the detailImage (UIImageView)
            let aspectScaledToFillImage = potentialImage.af_imageAspectScaled(toFill: self.detailImage.frame.size)

            // Set the detailImage image
            detailImage.image = aspectScaledToFillImage


            let xOffset = detailImage.layer.position.x

            let yOffset = detailImage.layer.position.y


            // Set the Corners of the detailImage
            let bottomLeftCorner = CGPoint(x: detailImage.frame.minX - xOffset, y: (detailImage.frame.maxY + yOffset) )

            let topLeftCorner = CGPoint(x: detailImage.frame.minX, y: detailImage.frame.minY + 200)

            let bottomRightCorner = CGPoint(x: detailImage.frame.maxX + xOffset, y: detailImage.frame.maxY + yOffset)

            // Add a slanted view on top of the detailImage
            let layer: CAShapeLayer = CAShapeLayer()


            // Create a triangular path
            let path: UIBezierPath = UIBezierPath()

            path.move(to: topLeftCorner)

            path.addLine(to: bottomLeftCorner)

            path.addLine(to:  bottomRightCorner)

            path.close()

            layer.path = path.cgPath

            layer.fillColor = self.view.backgroundColor?.cgColor

            layer.strokeColor = nil

            self.detailImage.layer.addSublayer(layer)


            // Add shadows to each UIView
            addShadowTo(view: self.titleView)

            addShadowTo(view: self.descriptionView)



        }

        // Check if a title has been given to the detailViewController
        if let potentialTitle = detailTitle {

            self.detailTitleLabel.text = potentialTitle

        }

        // Check if a description has been given to the detailViewController
        if let potentialDescription = detailDescription {

            self.detailDescripLabel.text = potentialDescription

            self.detailDescripLabel.sizeToFit()
        }

        safariButton.accessibilityLabel = "safari-button"

    }


    // When the 'Open in Safari' button is tapped, take the user to the URL from the current
    // article.
    @IBAction func safariButtonTapped(_ sender: Any) {

        if articleUrl != nil {

            // Open the article in Safari if the link exists
            UIApplication.shared.open(articleUrl!, options: [:], completionHandler: nil)

        } else {

            // Otherwise given an alert
            let alert = UIAlertController(title: "Article no longer exists.", message: "Sorry for the inconvenience.", preferredStyle: UIAlertControllerStyle.alert)

            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in

                alert.dismiss(animated: true, completion: nil)
            }))

            self.present(alert, animated: true, completion: nil)
        }

    }

    @IBAction func backButtonTapped(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }

    /**
     The animateAllUIViewsOnStartup method animates titleView, descriptionView, and safariButton.
     */
    func animateAllUIViewsOnStartup() {
        // Resize the image back to normal (originally animated in viewDidAppear method).
        UIView.animate(withDuration: 0.4, animations: {

            self.titleView.frame.origin.y += 30

            self.titleView.alpha = 1

        }) { (Bool) in

            UIView.animate(withDuration: 0.4, animations: {

                self.descriptionView.frame.origin.y += 30

                self.descriptionView.alpha = 1

            }, completion: { (Bool) in

                UIView.animate(withDuration: 0.4, animations: {

                    self.safariButton.frame.origin.y += 30

                    self.safariButton.alpha = 1
                })

            })
        }

    }

    /**
     The addShadowTo method adds shadows to a particular view.

     - parameter view: A UIView.
     */
    func addShadowTo(view: UIView) {

        view.layer.shadowColor = UIColor.black.cgColor

        view.layer.shadowOffset = CGSize.zero

        view.layer.shadowOpacity = 0.3

        view.layer.shadowRadius = 1
    }


}
