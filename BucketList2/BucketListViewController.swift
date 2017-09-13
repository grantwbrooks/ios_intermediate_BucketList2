//
//  ViewController.swift
//  BucketList2
//
//  Created by Grant Brooks on 9/12/17.
//  Copyright © 2017 Grant Brooks. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemDelegate {

    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchAllItems()
    }
    
// conforms to protocol after these two functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
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
            additemvc.item = items[(index.row)].text!
            additemvc.indexPath = index
        }
    }
    
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
    }
    
    
// saves items here, if an indexPath is passed in then update item, otherwise new item
    func saveItem(by: AddItemTableViewController, item: String, indexPath: NSIndexPath?){
        if let ip = indexPath {
            items[ip.row].text = item
        }
        else {
            if item.characters.count > 0 {
//                items.append(item)
                let bucketitem = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
                bucketitem.text = item
//                items.append(bucketitem)   removed because I added fetch all below
            }
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        fetchAllItems()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
// cancel view here and go back to main view
    func cancelItem(by: AddItemTableViewController){
        dismiss(animated: true, completion: nil)
    }
    
    
// delete list items
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(items[indexPath.row])
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
//        items.remove(at: indexPath.row)  removed because I added fetch all below  (this just adjusts array)
        fetchAllItems()
        tableView.reloadData()
    }

    
// built in stuff


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

