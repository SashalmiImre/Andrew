//
//  AppDelegate.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 07. 09..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Cocoa
import FirebaseCore
import FirebaseAuth

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    static var defaults: DefaultValues!
    static var dbService: DBService!
    static var mainContentController: MainWindowController!
    static var reachability: Reachability!

    override init() {
        ValueTransformer.setValueTransformer(StringToNSImage(), forName: .stringToNSImage)
        super.init()
        FirebaseApp.configure()
        AppDelegate.defaults = DefaultValues()
        AppDelegate.dbService = DBService()
        AppDelegate.reachability = Reachability()
        AppDelegate.reachability.delegate = self
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate: ReachabilityDelegate {
    func handler(_ handler: Reachability, stateDidChange event: Reachability.Event) {
        print(event)
        let notification = Notification(name: Reachability.reachabilityStateChanged,
                                        object: self,
                                        userInfo: ["event" : event])
        NotificationCenter.default.post(notification)
    }
}
