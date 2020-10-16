//
//  OutlineViewDelegate.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 08..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class OutlineViewDelegate: NSObject, NSOutlineViewDelegate {
        
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let viewNode = item as? NSTreeNode else { return nil }

        var view: NSView? = nil
        if viewNode.representedObject is Publication {
            view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("PublicationCellView"), owner: self)
        }
        if viewNode.representedObject is Article {
            view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("ArticleCellView"), owner: self)
        }
        
        return view
    }
    
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        guard let viewNode = item as? NSTreeNode else { return 17.0 }
        return viewNode.representedObject is Publication ? 60.0 : 25.0
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let sender = notification.object as? NSOutlineView else { return }
        let selectedItem = sender.item(atRow: sender.selectedRow)
        let viewNode = selectedItem as? NSTreeNode
        NotificationCenter.default.post(name: OutlineViewController.selectionChangedNotificationName,
                                        object: self, userInfo: ["Node" : viewNode ?? NSTreeNode(representedObject: nil)])
    }
    
    
}
