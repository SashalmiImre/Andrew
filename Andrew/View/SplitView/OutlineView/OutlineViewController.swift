//
//  OutlineViewController.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 12..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import CoreData
import Cocoa
import FirebaseAuth

class OutlineViewController: NSViewController {

    @objc var moc: NSManagedObjectContext? {
        let moc = AppDelegate.dbService.privateContext
        return moc
    }
    
    @objc var loggedUserName: String? {
        AppDelegate.defaults.loggedUser?.displayName
    }
    
    @IBOutlet weak var outlineView: NSOutlineView!
    
    static let selectionChangedNotificationName = Notification.Name("treeControllerSelectionChanged")
    let delegate = OutlineViewDelegate()
    
    @IBAction func userLoginClicked(_ sender: NSButton) {
        AppDelegate.mainContentController.changeViewController(to: "UserSettings")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outlineView.delegate = self.delegate
         NotificationCenter.default.addObserver(self, selector: #selector(contextChanged(notification:)), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func contextChanged(notification: NSNotification) {
        self.outlineView.reloadData()
    }
}
