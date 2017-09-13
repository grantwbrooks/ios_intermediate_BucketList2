//
//  AddItemTableViewController.swift
//  BucketList2
//
//  Created by Grant Brooks on 9/12/17.
//  Copyright © 2017 Grant Brooks. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    weak var delegate: AddItemDelegate?
    var indexPath: NSIndexPath?
    var item: String?
    
    @IBOutlet weak var EnterItemLabel: UITextField!

    
    @IBAction func TrashButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelItem(by: self)
    }
    
    @IBAction func SaveButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.saveItem(by: self, item: EnterItemLabel.text!, indexPath: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EnterItemLabel.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
