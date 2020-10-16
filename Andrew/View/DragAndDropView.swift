//
//  DragAndDropView.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 05..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

class DragAndDropView: NSView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            return .copy
        } else {
            return NSDragOperation()
        }
    }

    private func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard directoryURLs(drag) != nil else { return false }
        return true
    }
    
    private func directoryURLs(_ drag: NSDraggingInfo) -> [URL]? {
        let pasteboard = drag.draggingPasteboard
        guard let urls = pasteboard.readObjects(forClasses: [NSURL.self], options: nil) as? [URL]
            else { return nil }
        let directoryItems: [URL] = urls.compactMap {
            let isDir = (try? $0.resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory ?? false
            return isDir ? $0 : nil
        }
        return directoryItems.isEmpty ? nil : directoryItems
    }

    override func draggingExited(_ sender: NSDraggingInfo?) {

    }

    override func draggingEnded(_ sender: NSDraggingInfo) {

    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let urls = directoryURLs(sender) else { return false }
        guard let dbContext = AppDelegate.dbService.privateContext else { return false }
        
        let request = NSFetchRequest<NSDictionary>(entityName: "Publication")
        request.resultType = .dictionaryResultType
        request.returnsDistinctResults = true
        request.propertiesToFetch = ["homeFolder"]
        guard let results = try? dbContext.fetch(request) else { return false }
        let storedURLs = results.first?.allValues as? [URL] ?? [URL]()
        for url in urls {
            guard !storedURLs.contains(url) else { continue }
            let publication = Publication(homeFolder: url, context: dbContext)
            publication.name = url.lastPathComponent
        }
        AppDelegate.dbService.save(dbContext)
        return true
    }
}
