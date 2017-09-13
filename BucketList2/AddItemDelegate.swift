//
//  AddItemDelegate.swift
//  BucketList2
//
//  Created by Grant Brooks on 9/13/17.
//  Copyright © 2017 Grant Brooks. All rights reserved.
//

import Foundation

protocol AddItemDelegate: class {
    func saveItem(by: AddItemTableViewController, item: String, indexPath: NSIndexPath?)
    func cancelItem(by: AddItemTableViewController)
}
