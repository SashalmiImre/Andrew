//
//  SplitViewController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class SplitViewController: NSSplitViewController, InProgressVisualizable {
   
    var inProgress: Bool = false {
        didSet {
            self.setAppearance()
        }
    }
    

    // MARK: - View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onSelectionChanged(notification:)), name: OutlineViewController.selectionChangedNotificationName, object: nil)
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Notification observer function
    
    @objc func onSelectionChanged(notification: NSNotification) {
        guard let selectedNode = notification.userInfo?["Node"] as? NSTreeNode else { return }
        guard let detailsViewController = self.splitViewItems[1].viewController as? DetailsViewController else { return }
        let object = selectedNode.representedObject
        detailsViewController.changeView(with: object)
    }
}
