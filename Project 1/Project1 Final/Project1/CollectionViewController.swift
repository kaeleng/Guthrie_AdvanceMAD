//
//  CollectionViewController.swift
//  Project1
//
//  Created by Kaelen Guthrie on 2/27/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, EntryListViewControllerDelegate{
    func finishedPassData(array: [Adventure]) {
        //print("ok")
        //print(adventureArray)
        //print(array)
        adventureArray = array
    }
    
    
    //var adventure = Adventure()
    var adventureArray = [Adventure]()
    var adventureDetail: Adventure?
    //var adventureArray = [AdventureInformation]()
    //var displayImage: UIImage?
    
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 25.0, right: 10.0)
    
    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        print("unwind segue")
        if(segue.identifier == "saveAdventure"){
            let source = segue.source as! AddViewController
            if(source.newImageName != nil && source.newImagePath != nil && source.newDestinationName != nil){
                let information = Adventure(imageName: source.newImageName!, imagePath: source.newImagePath!, destinationName: source.newDestinationName!)
                adventureArray.append(information)
                self.collectionView?.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(adventureArray)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return adventureArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdventureInformation", for: indexPath) as! CollectionViewCell
        
        let information = adventureArray[indexPath.row]
        
        let imagePath = getDocumentsDirectory().appendingPathComponent(information.imageName!)
        
        cell.tripImage.image = UIImage(contentsOfFile: imagePath.path)
        //displayImage = cell.tripImage.image
        cell.tripName.text = information.destinationName
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        print(screenWidth)
        print(screenHeight)
        return CGSize(width: screenWidth, height: screenHeight/3);
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? EntryListViewController {
            destination.delegate = self
        }
        if segue.identifier == "showAdventure"{
            let entryVC = segue.destination as! EntryListViewController
            //entryVC.title = Adventure.destinationName
            let indexPath = collectionView?.indexPath(for: sender as! UICollectionViewCell)!
            let selectedAdventure = adventureArray[(indexPath?.row)!]
            entryVC.title = selectedAdventure.destinationName
            //send indexpath.row to list view controller
            entryVC.adventureNum = (indexPath?.row)!
            entryVC.arrayOfAdventures = adventureArray
        }
    }
    

   /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = displayImage
        let newSize = CGSize(width: (image?.size.width)!/40, height:(image?.size.height)!/40)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height:newSize.height)
        image?.draw(in:rect)
        let image2 = UIGraphicsGetImageFromCurrentImageContext()
        return(image2?.size)!
        
    }
*/
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

