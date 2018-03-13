//
//  ViewEntryViewController.swift
//  Project1
//
//  Created by Kaelen Guthrie on 3/9/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

class ViewEntryViewController: UIViewController {

    var entry : String?
    var imageName: String?
    var imagePath: URL?
    @IBOutlet weak var entryView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(title)
        entryView.text = entry
        let imageURL = getDocumentsDirectory().appendingPathComponent(imageName!)
        imageView.image = UIImage(contentsOfFile: imageURL.path)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func docFilePath(_ filename: String) -> String?{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString //document directory
        //creates the full path to out data file
        //print(dir.appendingPathComponent(filename))
        return dir.appendingPathComponent(filename)
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
