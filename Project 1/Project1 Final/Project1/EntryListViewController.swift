//
//  EntryListViewController.swift
//  Project1
//
//  Created by Kaelen Guthrie on 3/2/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//
//
//Delegate tutorial : https://medium.com/ios-os-x-development/pass-data-with-delegation-in-swift-86f6bc5d0894
//
//

import UIKit

protocol EntryListViewControllerDelegate{
    func finishedPassData(array: [Adventure])
}

class EntryListViewController: UITableViewController, UINavigationControllerDelegate {
    
    var delegate: EntryListViewControllerDelegate?
    
    let infoDest = UIApplication.shared.windows[0].rootViewController as? CollectionViewController
    
    var adventureList: Adventure?
    var entrytitles = [String]()
    var dates = [String]()
    var entries = [String]()
    var imagenames = [String]()
    var imagepaths = [URL]()
    var selectedAdventure = 0
    var newEntryDict = [String:Any]()
    var entryArrayDict = [[String:Any]]()
    var arrayOfAdventures = [Adventure]()
    
    //add varialbe for adventure num
    var adventureNum = 0
    
    override func viewWillAppear(_ animated: Bool){
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        
    
        //get entries and entry titles for the chosen adventure
        entryArrayDict = arrayOfAdventures[adventureNum].entryArray
        for dict in entryArrayDict{
            entrytitles.append(dict["entry"]! as! String)
            dates.append(dict["date"]! as! String)
            entries.append(dict["entrytext"]! as! String)
            imagenames.append(dict["entryimagename"]! as! String)
            imagepaths.append(dict["entryimagepath"]! as! URL)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entrytitles.count
    }
    
    func finishedPassArray(array: [Adventure]){
        infoDest?.adventureArray[adventureNum] = arrayOfAdventures[adventureNum]
        //print(infoDest?.adventureArray)
    }
    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        if segue.identifier=="saveEntry"{
            let source = segue.source as! AddEntryViewController
            
            if ((source.newEntryName.isEmpty) == false && source.newEntryText.isEmpty == false && source.imageView.image != nil){
                entrytitles.append(source.newEntryName)
                dates.append(source.newDate)
                entries.append(source.newEntryText)
                imagenames.append(source.newEntryImageName)
                imagepaths.append(source.newEntryImagePath!)
                //print(entries)
                //create new entry dictionary
                newEntryDict = ["entry":source.newEntryName, "date":source.newDate, "entrytext":source.newEntryText, "entryimagename":source.newEntryImageName, "entryimagepath":source.newEntryImagePath]
                //print(newEntryDict)
                arrayOfAdventures[adventureNum].entryArray.append(newEntryDict)
                //print(arrayOfAdventures[adventureNum])
                delegate?.finishedPassData(array: arrayOfAdventures)
                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "viewEntry"){
            let viewVC = segue.destination as! ViewEntryViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            viewVC.title = entrytitles[indexPath.row]
            viewVC.entry = entries[indexPath.row]
            viewVC.imageName = imagenames[indexPath.row]
            viewVC.imagePath = imagepaths[indexPath.row]
        }
    }
    /*
    private func navigationController(_ navigationController: UINavigationController, willShow viewController: UICollectionViewController, animated: Bool) {
        (viewController as? CollectionViewController)?.adventureArray = arrayOfAdventures // Here you pass the to your original view controller
    }
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Entry Cell", for: indexPath)
        cell.textLabel?.text = entrytitles[indexPath.row]
        cell.detailTextLabel?.text = dates[indexPath.row]
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

