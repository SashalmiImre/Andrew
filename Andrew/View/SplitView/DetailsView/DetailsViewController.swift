//
//  DetailsViewController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class DetailsViewSelectionController: NSViewController {
    
    
    func changeView(with object: Any?) {
        var storyboardName = "ApplicationSettings"
        switch object.self {
        case is Publication:
            storyboardName = "PublicationDetails"
        case is Article:
            storyboardName = "ArticleDetails"
        default:
            break
        }
        let storyboard = NSStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateInitialController() as! NSViewController
        self.changeDetailViewController(to: viewController)
    }
    
    private func changeDetailViewController(to targetViewController: NSViewController) {
        guard let currentViewController = self.children.first else { return }
        self.addChild(targetViewController)
        self.view.addSubview(targetViewController.view)
        targetViewController.view.frame = currentViewController.view.frame
        self.transition(from: currentViewController,
                        to: targetViewController,
                        options: .crossfade)
        currentViewController.removeFromParent()
    }
    
}
