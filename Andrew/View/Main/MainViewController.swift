//
//  MainViewController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 14..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa
import FirebaseAuth

class MainViewController: NSViewController, InProgressVisualizable {
    var inProgress: Bool = false {
        didSet {
            self.setAppearance()
        }
    }
    override func viewWillLayout() {
        super.viewWillLayout()
        self.moveWindowButtons()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.mainViewController = self
        if let view = self.view as? NSVisualEffectView {
            view.wantsLayer = true
            view.state = .active
            view.blendingMode = .behindWindow
            view.layer?.cornerRadius = 15.0
        }
        NotificationCenter.default
            .addObserver(forName: Reachability.reachabilityStateChanged,
                         object: nil, queue: nil) { [unowned self] (notification) in
                guard let event = notification.userInfo?["event"] as? Reachability.Event else { return }
                self.inProgress = event == .notReachable
            }
    }
    
    func changeViewController(to targetViewController: NSViewController) {
        guard let currentViewController = self.children.first else {
            targetViewController.view.frame = self.view.frame
            self.addChild(targetViewController)
            self.view.addSubview(targetViewController.view)
            return
        }

        self.addChild(targetViewController)
        self.view.addSubview(targetViewController.view)
        targetViewController.view.frame = currentViewController.view.frame
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.5
            self.transition(from: currentViewController,
                            to: targetViewController,
                            options: .crossfade)
        }
        
        currentViewController.view.removeFromSuperview()
        currentViewController.removeFromParent()
    }
    
    func changeViewController(to targetViewControllerName: String) {
        let storyboard = NSStoryboard(name: targetViewControllerName, bundle: nil)
        let targetViewController = storyboard.instantiateInitialController() as! NSViewController
        if let currentViewController = self.children.first,
           currentViewController.nibName == targetViewController.nibName {
            return
        }
        self.changeViewController(to: targetViewController)
    }
    
    func setAppropriateViewController() {
        let storyboardName = self.appropriateStoryboardName()
        self.changeViewController(to: storyboardName)
    }
    
    private func appropriateStoryboardName() -> String {
        let user = AppDelegate.defaults.value(forKey: .currentUser, type: User.self)
        switch (user, user?.displayName, user?.isEmailVerified) {
        case (nil, _, _):
            return "UserLogin"
        case (_, nil, _):
            return "UserSettings"
        case (_, _, false):
            return "UserVerification"
        default:
            return "SplitView"
        }
    }
    
    private func moveWindowButtons() {
        guard let window = self.view.window else { return }
        self.moveWindowButton(button: window.standardWindowButton(.closeButton)!, position: NSMakePoint(10, -2))
        self.moveWindowButton(button: window.standardWindowButton(.miniaturizeButton)!, position: NSMakePoint(30, -2))
        self.moveWindowButton(button: window.standardWindowButton(.zoomButton)!, position: NSMakePoint(50, -2))
    }

    private func moveWindowButton(button: NSView, position: NSPoint) {
        button.setFrameOrigin(position)
    }
    
}

