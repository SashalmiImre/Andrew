//
//  MainWindowController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 09. 13..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa
import FirebaseAuth

class MainWindowController: NSWindowController {

    // MARK: - Initialization/deinitialization
    
    override init(window: NSWindow?) {
        super.init(window: window)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default
            .addObserver(forName: Reachability.reachabilityStateChanged,
                         object: nil, queue: nil) { [unowned self] (notification) in
                guard let event = notification.userInfo?["event"] as? Reachability.Event else { return }
                guard let inProgressVisualizableViewController = self.contentViewController as? InProgressVisualizable else { return }
                if event == .notReachable {
                    inProgressVisualizableViewController.informationViewName = "ReachabilityInformationView"
                }
                inProgressVisualizableViewController.inProgress = event == .notReachable
            }
        AppDelegate.mainContentController = self
    }
        
    
    // MARK: - View events
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    
    // MARK: - Change ContentViewController
    
    func changeViewController(to targetViewController: InProgressVisualizable) {
        guard let window = self.window else { return }
        guard let currentViewController = self.contentViewController else { return }
        if currentViewController.nibName == targetViewController.nibName { return }

        targetViewController.view.frame = currentViewController.view.frame
        
        let animationView = CrossfadeAnimationView(from: currentViewController, to: targetViewController)
        window.contentView = animationView
        animationView.animate {
            if !AppDelegate.reachability.isReachable {
                targetViewController.informationViewName = "ReachabilityInformationView"
                targetViewController.inProgress = true
            }
            window.contentViewController = targetViewController
            window.contentView = targetViewController.view
        }
    }
    
    func changeViewController(to targetViewControllerName: String) {
        let storyboard = NSStoryboard(name: targetViewControllerName, bundle: nil)
        let targetViewController = storyboard.instantiateInitialController() as! NSViewController
        guard targetViewController is InProgressVisualizable else { return }
        self.changeViewController(to: targetViewController as! InProgressVisualizable)
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
}
