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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let pathURL = Bundle.main.url(forResource: "classes", withExtension: "plist"){
            let plistdecoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: pathURL)
                classList.classData = try plistdecoder.decode([String: [String]].self, from:data)
                classList.classes = Array(classList.classData.keys)
            }catch{
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int{
        return classList.classes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier",for: indexPath)
        cell.textLabel?.text = classList.classes[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

