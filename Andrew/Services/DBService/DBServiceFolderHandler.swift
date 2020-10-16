//
//  FolderHandler.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2019. 05. 02..
//  Copyright © 2019. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa

// MARK: - Handler
class DBServiceHandler: NSObject, NSFilePresenter, ServiceHandler, HandlerDelegate {
    enum Event {
        case folderIsExist(String)
        case folderNotExist(String)
    }

    private enum FolderValidityError: Error {
        case notSet
        case notDirectory
        case notReachable(nearestReachable: URL)
    }
    
    private(set) var presentedItemURL: URL?
    var presentedItemOperationQueue: OperationQueue { return OperationQueue.main }
    public var isRunning = false
    weak var delegate: HandlerDelegate?
    
    
    // MARK: - Initialization
    
    init(folderURL: URL, delegate: HandlerDelegate? = nil) {
        super.init()
        self.delegate = delegate
        self.presentedItemURL = folderURL
    }
    
    convenience init(folderPath: String, delegate: HandlerDelegate? = nil) {
        let folderURL = URL(fileURLWithPath: folderPath)
        self.init(folderURL: folderURL, delegate: delegate)
    }
    
    deinit {
        self.stop()
    }

    // MARK: - Start/stop
    
    func start() {
        guard self.isRunning == false else { return }
        NSFileCoordinator.addFilePresenter(self)
        self.validate()
        self.isRunning = true
    }
    
    func stop() {
        guard self.isRunning == true else { return }
        self.delegate = nil
        NSFileCoordinator.removeFilePresenter(self)
        self.isRunning = false
    }
    
    // MARK: - Auxiliary handler
    
    private func setAuxiliaryHandler(toFolder: URL) {
        let auxiliaryHandler = DBServiceHandler(folderURL: toFolder, delegate: self)
        auxiliaryHandler.start()
    }
    
    func handler<T>(_ handler: T, stateDidChange event: T.Event) where T : ServiceHandler {
        guard let event = event as? DBServiceHandler.Event else { return }
        guard let auxiliaryHandler = handler as? DBServiceHandler else { return }
        
        switch event {
        case .folderIsExist:
            let folderValidity = self.checkFolder()
            if (try? folderValidity.get()) != nil {
                auxiliaryHandler.stop()
                NSFileCoordinator.addFilePresenter(self)
                self.isRunning = true
            }
        case .folderNotExist:
            return
        }
    }
    
    // MARK: - Validate
    
    private func validate() {
        let folderValidity = self.checkFolder()
        var event: Event
        switch folderValidity {
        case .success:
            self.isRunning = true
            event = Event.folderIsExist("A szolgáltatás működik. Az elérési útvonal: \(self.presentedItemURL!.path)")
        case .failure(let error):
            self.isRunning = false
            event = self.errorSorter(error)
        }
        self.delegate?.handler(self, stateDidChange: event)
    }
    
    private func checkFolder() -> Result<URL, FolderValidityError> {
        guard var itemURL = self.presentedItemURL else {
            return .failure(.notSet)
        }
        
        var isReachable = false
        repeat {
            do {
                try isReachable = itemURL.checkPromisedItemIsReachable()
            } catch {
                itemURL = itemURL.deletingLastPathComponent()
            }
        } while !isReachable
        if itemURL == self.presentedItemURL! {
            if  try! itemURL.resourceValues(forKeys: [.isDirectoryKey]).isDirectory! {
                return .success(self.presentedItemURL!)
            }
            return .failure(.notDirectory)
        }
        
        return .failure(.notReachable(nearestReachable: itemURL))
    }
    
    private func errorSorter(_ error: FolderValidityError) -> Event {
        var event: Event
        switch error {
        case .notSet:
            event = Event.folderNotExist("Nincs beállított mappa! Kérlek válassz egyet amelyik közös a veled együtt dolgozók mappájával.")
        case .notDirectory:
            event = Event.folderNotExist("A kiválasztott elem nem mappa! Kérlek válassz egy mappát, amelyik közös a veled együtt dolgozók adatbázisának mappájával.")
        case .notReachable(let nearestReachable):
            self.setAuxiliaryHandler(toFolder: nearestReachable)
            event = Event.folderNotExist("A beállított mappa nem elérhető. Amennyiben az elérési út helyreáll, automatikus elindul a szolgáltatás. A jelenlegi elérési út: \(self.presentedItemURL!.path)")
        }
        return event
    }
    
    func changePath(to path: String) {
        guard !path.isEmpty else { return }
        guard path != self.presentedItemURL?.path else { return }
        let delegate = self.delegate
        self.stop()
        let fileURL = URL(fileURLWithPath: path)
        self.presentedItemURL = fileURL
        self.delegate = delegate
        self.start()
    }
}

// MARK: - NSFilePresenter delegate functions
extension DBServiceHandler {
    func presentedItemDidChange() {
        self.validate()
    }
}
