//
//  InProgressVisualizable.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 10. 03..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

protocol InProgressVisualizable where Self: NSViewController  {
    var inProgress: Bool { get set }
    var informationViewName: String? { get set }
}

extension InProgressVisualizable {
    func setAppearance() {
        if self.inProgress {
            self.view.window?.makeFirstResponder(nil)
            self.addInformationView(to: self.view)
        } else {
            self.removeEffects(from: self.view)
        }
    }

    private func addInformationView(to parentView: NSView) {
        let informationViewName = self.informationViewName ?? "InProgressVisualizableInformationView"
        let storyboard = NSStoryboard(name: informationViewName, bundle: nil)
        guard let informationViewController = storyboard.instantiateInitialController() as? NSViewController else { return }
        let informationView = informationViewController.view
        self.addChild(informationViewController)
        informationView.identifier = NSUserInterfaceItemIdentifier(rawValue: "TEMPORARY_EFFECT_VIEW")
        informationView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(informationView, positioned: .above, relativeTo: nil)
        informationView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        informationView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        informationView.widthAnchor.constraint(equalTo: parentView.widthAnchor).isActive = true
        informationView.heightAnchor.constraint(equalTo: parentView.heightAnchor).isActive = true
    }

    private func removeEffects(from view: NSView) {
        self.children.forEach { (childViewController) in
            if childViewController.view.identifier == NSUserInterfaceItemIdentifier(rawValue: "TEMPORARY_EFFECT_VIEW") {
                childViewController.view.removeFromSuperview()
                childViewController.removeFromParent()
            }
        }
        self.informationViewName = nil
    }
}
