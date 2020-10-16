//
//  DetailsViewController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class DetailsViewController: NSViewController {
    
    
    func changeView(with object: Any?) {
        switch object.self {
        case is Publication:
            let storyboard = NSStoryboard(name: "PublicationDetails", bundle: nil)
            let viewController = storyboard.instantiateInitialController() as! PublicationDetailsController
            viewController.publication = object as? Publication
            self.changeDetailViewController(to: viewController)
        case is Article:
            let storyboard = NSStoryboard(name: "ArticleDetails", bundle: nil)
            let viewController = storyboard.instantiateInitialController() as! ArticleDetailsController
            viewController.article = object as? Article
            self.changeDetailViewController(to: viewController)
        default:
            let storyboard = NSStoryboard(name: "ApplicationSettings", bundle: nil)
            let viewController = storyboard.instantiateInitialController() as! NSViewController
            self.changeDetailViewController(to: viewController)
        }
        
    }
    
    private func changeDetailViewController(to targetViewController: NSViewController) {
        guard let currentViewController = self.children.first else { return }
        self.addChild(targetViewController)
        self.view.addSubview(targetViewController.view)
        targetViewController.view.frame = currentViewController.view.frame
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.1
            self.transition(from: currentViewController,
                            to: targetViewController,
                            options: .crossfade)
        }
        currentViewController.removeFromParent()
    }
    
}
