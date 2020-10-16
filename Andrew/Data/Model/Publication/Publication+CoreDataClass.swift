//
//  Publication+CoreDataClass.swift
//  Andrew
//
//  Created by Sashalmi Imre on 2020. 07. 25..
//  Copyright © 2020. Sashalmi Imre. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Publication)
public final class Publication: NSManagedObject {
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
}
