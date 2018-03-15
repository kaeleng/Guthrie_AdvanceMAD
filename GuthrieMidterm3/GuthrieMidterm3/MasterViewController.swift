//
//  MasterViewController.swift
//  GuthrieMidterm3
//
//  Created by Kaelen Guthrie on 3/15/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var places = [Restaurants]()
    var searchController : UISearchController!
    let kfilename = "data1.plist"
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if(segue.identifier == "saveSegue"){
            let source = segue.source as! AddViewController
            if((source.addedRestaurant.isEmpty) == false){
                let newPlace = Restaurants(name: source.addedRestaurant, url: source.addedURL)
                places.append(newPlace)
                
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        loadjson()

    }
    
    func loadjson(){
        print("working")
        let urlPath = "https://creative.colorado.edu/~apierce/samples/data/restaurants.json"
        guard let url = URL(string: urlPath)
            else {
                print("url error")
                return
        }
        
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard statusCode == 200
                else {
                    print("file download error")
                    return
            }
            //download successful
            print("download complete")
            DispatchQueue.main.async {self.parsejson(data!)}
        })
        //must call resume to run session
        session.resume()
    }
    
    func parsejson(_ data: Data){
        do
        {
            //print(data)
            /*
             let api = try JSONDecoder().decode(API.self, from: data)
             print(api)
             for joke in api.results
             {
             jokes.append(joke)
             }
             */
            let jsonData = try JSONDecoder().decode([Restaurants].self, from: data)
            print(jsonData)
            for restaurant in jsonData{
                places.append(restaurant)
            }
            
        }
        catch let jsonErr
        {
            print(jsonErr.localizedDescription)
            return
        }
        //reload the table data after the json data has been downloaded
        tableView.reloadData()
    }
    


    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
*/
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let place = places[indexPath.row]
                let title = place.name
                let url = place.url
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = url
                controller.title = title
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

          // Configure the cell...
        let restName = places[indexPath.row]
        cell.textLabel?.text = restName.name
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

*/
}

