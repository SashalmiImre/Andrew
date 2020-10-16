//
//  TestEnvironment.swift
//  AndrewTests
//
//  Created by Sashalmi Imre on 2020. 08. 10..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import Cocoa
import CoreData

class TestEnvironment {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Andrew")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    var dbContext: NSManagedObjectContext { self.persistentContainer.viewContext }
    private var baseFolder: URL { FileManager.default.homeDirectoryForCurrentUser }
    var homeFolder: URL { self.baseFolder.appendingPathComponent("HomeFolder") }
    var pdfSubFolder: URL { self.homeFolder.appendingPathComponent("__PDF") }
    var designedSubFolder: URL { self.homeFolder.appendingPathComponent("__TORDELVE") }
    var correctedSubFolder: URL { self.designedSubFolder.appendingPathComponent("__OLVASVA") }
    var printableSubFolder: URL { self.correctedSubFolder.appendingPathComponent("__LEVILAGITHATO") }
    var printedSubFolder: URL { self.correctedSubFolder.appendingPathComponent("__LEVIL") }
    
    init() {
        self.removeFolders()
        self.createFolders()
    }
    
    func createHomeFolder() {
        try? FileManager.default.createDirectory(at: self.homeFolder,
                                                 withIntermediateDirectories: false, attributes: nil)
    }
    
    func deleteHomeFolder() {
        try? FileManager.default.removeItem(at: self.homeFolder)
    }
    
    func createPDFSubFolder() {
        try? FileManager.default.createDirectory(at: self.pdfSubFolder,
                                                 withIntermediateDirectories: false, attributes: nil)
    }
    
    func deletePDFSubFolder() {
        try? FileManager.default.removeItem(at: self.pdfSubFolder)
    }
    
    func createDesignedSubFolder() {
        try? FileManager.default.createDirectory(at: self.designedSubFolder,
                                                 withIntermediateDirectories: false, attributes: nil)
    }
    
    func deleteDesignedSubFolder() {
        try? FileManager.default.removeItem(at: self.designedSubFolder)
    }
    
    func createCorrectedSubFolder() {
        try? FileManager.default.createDirectory(at: self.correctedSubFolder,
                                                 withIntermediateDirectories: false, attributes: nil)
    }
    
    func deleteCorrectedSubFolder() {
        try? FileManager.default.removeItem(at: self.correctedSubFolder)
    }
    
    func createPrintableSubFolder() {
        try? FileManager.default.createDirectory(at: self.printableSubFolder,
                                                 withIntermediateDirectories: false, attributes: nil)
    }
    
    func deletePrintableSubFolder() {
        try? FileManager.default.removeItem(at: self.printableSubFolder)
    }
    
    func createPrintedSubFolder() {
        try? FileManager.default.createDirectory(at: self.printedSubFolder,
                                                 withIntermediateDirectories: false, attributes: nil)
    }
    
    func deletePrintedSubFolder() {
        try? FileManager.default.removeItem(at: self.printedSubFolder)
    }
    
    func createFolders() {
        self.createHomeFolder()
        self.createPDFSubFolder()
        self.createDesignedSubFolder()
        self.createCorrectedSubFolder()
        self.createPrintableSubFolder()
        self.createPrintedSubFolder()
    }
    
    func removeFolders() {
        self.deletePrintedSubFolder()
        self.deletePrintableSubFolder()
        self.deleteCorrectedSubFolder()
        self.deleteDesignedSubFolder()
        self.deletePDFSubFolder()
        self.deleteHomeFolder()
    }
    
    func saveDB() {
        guard self.dbContext.commitEditing() else {
            print("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return
        }
        guard self.dbContext.hasChanges else { return }
        
        do {
            try self.dbContext.save()
        } catch {
            print(error)
        }
    }
}
