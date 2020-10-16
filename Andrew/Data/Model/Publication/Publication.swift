//
//  Publication.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 07. 21..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//

import Foundation
import CoreData
import Cocoa

extension Publication {
    var designedURL: URL? {
        guard let path = self.designedSubfolder else { return nil }
        return self.homeFolder?.appendingPathComponent(path)
    }
    
    var correctedURL: URL? {
        guard let path = self.correctedSubfolder else { return nil }
        return self.homeFolder?.appendingPathComponent(path)
    }
    
    var printableURL: URL? {
        guard let path = self.printableSubfolder else { return nil }
        return self.homeFolder?.appendingPathComponent(path)
    }
    
    var printedURL: URL? {
        guard let path = self.printedSubfolder else { return nil }
        return self.homeFolder?.appendingPathComponent(path)
    }
    
    var pdfURL: URL? {
        guard let path = self.pdfSubfolder else { return nil }
        return self.homeFolder?.appendingPathComponent(path)
    }
    
    var retouchURL: URL? {
        guard let path = self.retouchSubfolder else { return nil }
        return self.homeFolder?.appendingPathComponent(path)
    }
    
    // MARK: - Initialization
    convenience init(homeFolder: URL, context: NSManagedObjectContext? = nil) {
        var context = context
        if context == nil {
            context = AppDelegate.dbService.privateContext
        }
        self.init(context: context!)
        self.homeFolder = homeFolder
    }
}
