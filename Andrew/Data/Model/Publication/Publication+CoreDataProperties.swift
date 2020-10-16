//
//  Publication+CoreDataProperties.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 08. 24..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//
//

import Foundation
import CoreData


extension Publication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Publication> {
        return NSFetchRequest<Publication>(entityName: "Publication")
    }

    @NSManaged public var correctedSubfolder: String?
    @NSManaged public var designedSubfolder: String?
    @NSManaged public var homeFolder: URL?
    @NSManaged public var isLeaf: Bool
    @NSManaged public var isSpecialEdition: Bool
    @NSManaged public var name: String?
    @NSManaged public var pdfSubfolder: String?
    @NSManaged public var printableSubfolder: String?
    @NSManaged public var printedSubfolder: String?
    @NSManaged public var subName: String?
    @NSManaged public var retouchSubfolder: String?
    @NSManaged public var pageNumber: Int16
    @NSManaged public var contents: NSSet?
    @NSManaged public var deadlines: NSSet?

}

// MARK: Generated accessors for contents
extension Publication {

    @objc(addContentsObject:)
    @NSManaged public func addToContents(_ value: Article)

    @objc(removeContentsObject:)
    @NSManaged public func removeFromContents(_ value: Article)

    @objc(addContents:)
    @NSManaged public func addToContents(_ values: NSSet)

    @objc(removeContents:)
    @NSManaged public func removeFromContents(_ values: NSSet)

}

// MARK: Generated accessors for deadlines
extension Publication {

    @objc(addDeadlinesObject:)
    @NSManaged public func addToDeadlines(_ value: Deadline)

    @objc(removeDeadlinesObject:)
    @NSManaged public func removeFromDeadlines(_ value: Deadline)

    @objc(addDeadlines:)
    @NSManaged public func addToDeadlines(_ values: NSSet)

    @objc(removeDeadlines:)
    @NSManaged public func removeFromDeadlines(_ values: NSSet)

}
