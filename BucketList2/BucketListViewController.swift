//
//  ViewController.swift
//  BucketList2
//
//  Created by Grant Brooks on 9/12/17.
//  Copyright © 2017 Grant Brooks. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemDelegate {

    var items = ["Go to the moon", "Eat a candy bar", "Swim in the Amazon", "Ride a motorbike in Tokyo"]
// conforms to protocol after these two functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

// we go to next view with these
    @IBAction func ComposePressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddItemSegue", sender: sender)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddItemSegue", sender: indexPath)
    }
    
// set up delegate here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navc = segue.destination as! UINavigationController
        let additemvc = navc.topViewController as! AddItemTableViewController
        additemvc.delegate = self
        
        if sender is NSIndexPath {
            let index = sender as! NSIndexPath
            additemvc.item = items[(index.row)]
            additemvc.indexPath = index
        }
    }
    
    
// saves items here, if an indexPath is passed in then update item, otherwise new item
    func saveItem(by: AddItemTableViewController, item: String, indexPath: NSIndexPath?){
        if let ip = indexPath {
            items[ip.row] = item
        }
        else {
            if item.characters.count > 0 {
                items.append(item)
            }
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
// cancel view here and go back to main view
    func cancelItem(by: AddItemTableViewController){
        dismiss(animated: true, completion: nil)
    }
    
    
// delete list items
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }

    
// built in stuff
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

