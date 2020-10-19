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
}

extension InProgressVisualizable {
    func setAppearance() {
        if self.inProgress {
            self.addBlurView(for: self.view)
            self.addProgressIndicator(to: self.view)
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
    
    private func addProgressIndicator(to parentView: NSView) {
        let progressIndicator = NSProgressIndicator()
        parentView.addSubview(progressIndicator, positioned: .above, relativeTo: nil)

        progressIndicator.identifier = NSUserInterfaceItemIdentifier(rawValue: "TEMPORARY_EFFECT_VIEW")
        progressIndicator.style = .spinning
        progressIndicator.isIndeterminate = true
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        progressIndicator.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        progressIndicator.heightAnchor.constraint(equalToConstant: 75.0).isActive = true
        progressIndicator.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        progressIndicator.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        progressIndicator.startAnimation(nil)
    }
    
    private func removeEffects(from view: NSView) {
        view.subviews.forEach { (view) in
            if view.identifier == NSUserInterfaceItemIdentifier(rawValue: "TEMPORARY_EFFECT_VIEW") {
                view.removeFromSuperview()
            }
        }
    }
}
