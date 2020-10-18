//
//  CrossfadeAnimationView.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 10. 17..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class CrossfadeAnimationView: NSView {
    var currentViewController: NSViewController!
    var targetViewController: NSViewController!
    
    convenience init(from currentViewController: NSViewController, to targetViewController: NSViewController) {
        self.init(frame: currentViewController.view.frame)
        self.addSubview(currentViewController.view)
        self.addSubview(targetViewController.view)
        self.currentViewController = currentViewController
        self.currentViewController.view.alphaValue = 1.0
        self.targetViewController = targetViewController
        self.targetViewController.view.alphaValue = 0.0
        self.targetViewController.view.wantsLayer = true
        self.targetViewController.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
    }
    
    override private init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func animate(completionHandler: (()->Void)?) {
        NSAnimationContext.runAnimationGroup { (context) in
            context.duration = 1.5
            self.currentViewController.view.animator().alphaValue = 0.0
            self.targetViewController.view.animator().alphaValue = 1.0
        } completionHandler: {
            self.currentViewController.view.removeFromSuperview()
            self.currentViewController.removeFromParent()
            completionHandler?()
        }
    }
}
