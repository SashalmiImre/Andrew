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
    func informationView() -> NSView?
}

extension InProgressVisualizable {
    func setAppearance() {
        if self.inProgress {
            self.addBlurView(for: self.view)
            self.addInformationView(to: self.view)
        } else {
            self.removeEffects(from: self.view)
        }
    }

    private func addBlurView(for view: NSView) {
        guard let filter = CIFilter(name:"CIGaussianBlur") else { return }
        filter.setValue(5, forKey: kCIInputRadiusKey)
        filter.isEnabled = true

        let blurView = MouseEventBlindView(frame: view.frame)
        blurView.identifier = NSUserInterfaceItemIdentifier(rawValue: "TEMPORARY_EFFECT_VIEW")
        
        if #available(macOS 10.15, *) {
            let layer = CALayer()
            layer.backgroundColor = .clear
            layer.backgroundFilters = [filter]
            layer.isHidden = false
            blurView.wantsLayer = true
            blurView.layer = layer
        } else {
            blurView.backgroundFilters = [filter]
        }
        view.addSubview(blurView, positioned: .above, relativeTo: nil)
        blurView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blurView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func addInformationView(to parentView: NSView) {
        let informationView = self.informationView() ?? self.progressIndicator()
        informationView.identifier = NSUserInterfaceItemIdentifier(rawValue: "TEMPORARY_EFFECT_VIEW")
        parentView.addSubview(informationView, positioned: .above, relativeTo: nil)
        informationView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        informationView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
    }
    
    private func progressIndicator() -> NSView {
        let progressIndicator = NSProgressIndicator()
        progressIndicator.style = .spinning
        progressIndicator.isIndeterminate = true
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        progressIndicator.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        progressIndicator.heightAnchor.constraint(equalToConstant: 75.0).isActive = true
        progressIndicator.startAnimation(nil)
        return progressIndicator
    }
    
    private func removeEffects(from view: NSView) {
        view.subviews.forEach { (view) in
            if view.identifier == NSUserInterfaceItemIdentifier(rawValue: "TEMPORARY_EFFECT_VIEW") {
                view.removeFromSuperview()
            }
        }
    }
}
