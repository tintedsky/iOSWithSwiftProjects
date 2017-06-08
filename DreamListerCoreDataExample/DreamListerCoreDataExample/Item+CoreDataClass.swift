//
//  Item+CoreDataClass.swift
//  DreamListerCoreDataExample
//
//  Created by Berkant Y. GEDIZ on 6/5/17,23.
//  Copyright © 2017 Mnemosyne C2. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
