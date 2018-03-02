//
//  ViewController.swift
//  Lab4
//
//  Created by Kaelen Guthrie on 3/1/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var jokes = [Joke]()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "seeJoke"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let joke = jokes[indexPath.row]
                let setup = joke.setup
                let punchline = joke.punchline
                let jokeVC = segue.destination as! JokeViewController
                jokeVC.joke = setup
                jokeVC.punch = punchline
            
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadjson()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadjson(){
        let urlPath = "https://08ad1pao69.execute-api.us-east-1.amazonaws.com/dev/random_ten"
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
            let jsonData = try JSONDecoder().decode([Joke].self, from: data)
            print(jsonData)
            for joke in jsonData{
                jokes.append(joke)
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
/*
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    
    // MARK: - Segues
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let joke = jokes[indexPath.row]
                let punchline = joke.punchline
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.punchline = punchline
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    */
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let jokesetup = jokes[indexPath.row]
        cell.textLabel!.text = jokesetup.setup
        return cell
    }


}

