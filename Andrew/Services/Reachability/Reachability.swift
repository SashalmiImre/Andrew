//
//  Reachability.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 10. 04..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//
//  Thanks to: https://medium.com/@marcosantadev/network-reachability-with-swift-576ca5070e4b

import Foundation
import SystemConfiguration

class Reachability {
    enum Event {
        case reachable
        case notReachable
    }
    
    weak var delegate: ReachabilityDelegate?
    static let reachabilityStateChanged = Notification.Name("reachabilityStateChanged")

    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.firebase.com")
    private let queue = DispatchQueue.main
    private var currentReachabilityFlags: SCNetworkReachabilityFlags?
    private var isListening = false
    var isReachable = true
    
    
    // MARK: - Initialization/deinitialization
    
    init() {
        self.start()
    }
    
    deinit {
        self.stop()
    }
    
    // MARK: - Start/stop

    private func start() {
        guard !isListening else { return }
        guard let reachability = reachability else { return }
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutableRawPointer(Unmanaged<Reachability>.passUnretained(self).toOpaque())
        let callbackClosure: SCNetworkReachabilityCallBack? = {
            (reachability:SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) in
            guard let info = info else { return }
            let handler = Unmanaged<Reachability>.fromOpaque(info).takeUnretainedValue()
            DispatchQueue.main.async {
                handler.checkReachability(flags: flags)
            }
        }

        if !SCNetworkReachabilitySetCallback(reachability, callbackClosure, &context) {
            // Not able to set the callback
        }

        if !SCNetworkReachabilitySetDispatchQueue(reachability, queue) {
            // Not able to set the queue
        }

        queue.async {
            self.currentReachabilityFlags = nil
            var flags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            self.checkReachability(flags: flags)
        }
        isListening = true
    }
    
    private func stop() {
        guard isListening,
            let reachability = reachability
            else { return }
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
        isListening = false
    }

    
    // MARK: - Check reachability
    
    private func checkReachability(flags: SCNetworkReachabilityFlags) {
        if currentReachabilityFlags != flags {
            var event: Reachability.Event
            event = flags.contains(.reachable) ? .reachable : .notReachable
            self.isReachable = event == .reachable
            self.delegate?.handler(self, stateDidChange: event)
            currentReachabilityFlags = flags
        }
    }
}
