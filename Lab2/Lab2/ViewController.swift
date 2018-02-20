//
//  ViewController.swift
//  Lab2
//
//  Created by Kaelen Guthrie on 2/13/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var classList = Classes()
    let kfilename = "data1.plist"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pathURL:URL?
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        print(docDir)
        
        let dataFileURL = docDir.appendingPathComponent(kfilename)
        print(dataFileURL)
        
        if FileManager.default.fileExists(atPath: dataFileURL.path){
            pathURL = dataFileURL
        }
        else{
            pathURL = Bundle.main.url(forResource: "classes", withExtension: "plist")
        }
            let plistdecoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: pathURL!)
                classList.classData = try plistdecoder.decode([String: [String]].self, from:data)
                classList.classes = Array(classList.classData.keys)
            }catch{
                print(error)
            }

        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.applicationWillResignActive(_:)), name:NSNotification.Name.UIApplicationWillResignActive, object: app)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int{
        return classList.classes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier",for: indexPath)
        cell.textLabel?.text = classList.classes[indexPath.row]
        return cell
    }
    
    @objc func applicationWillResignActive(_ notification: NSNotification){
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        print(docDir)
        let dataFileURL = docDir.appendingPathComponent(kfilename)
        print(dataFileURL)
        let plistencoder = PropertyListEncoder()
        plistencoder.outputFormat = .xml
        do{
            let data = try plistencoder.encode(classList.classData)
            try data.write(to: dataFileURL)
        }
        catch{
            print(error)
        }
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender:Any?){
        if segue.identifier == "classsegue"{
            let detailVC = segue.destination as! DetailTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            detailVC.title = classList.classes[indexPath.row]
            detailVC.classListAssignments = classList
            detailVC.selectedClass = indexPath.row

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

