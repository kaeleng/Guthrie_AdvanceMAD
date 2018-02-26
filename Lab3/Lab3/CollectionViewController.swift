//
//  CollectionViewController.swift
//  Lab3
//
//  Created by Kaelen Guthrie on 2/22/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var hungaryImages=[String]()
    var sloveniaImages=[String]()
    var italyImages=[String]()
    let reuseIdentifier = "Cell"
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        for i in 1...8{
            hungaryImages.append("europe" + String(i))
        }
        for i in 9...16{
            sloveniaImages.append("europe" + String(i))
        }
        for i in 17...20{
            italyImages.append("europe" + String(i))
        }
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
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        var returnValue = Int()
        if section == 0{
            returnValue = hungaryImages.count
        }
        else if section == 1{
            returnValue = sloveniaImages.count
        }
        else{
            returnValue = italyImages.count
        }
        return returnValue
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let section = indexPath.section
        // Configure the cell
        if section == 0{
            let image = UIImage(named:hungaryImages[indexPath.row])
            cell.imageView.image = image
        }else if section == 1{
            let image = UIImage(named:sloveniaImages[indexPath.row])
            cell.imageView.image = image
        }else{
            let image = UIImage(named:italyImages[indexPath.row])
            cell.imageView.image = image
        }
        
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        var header: CollectionReusableView?
        var footer: CollectionReusableView2?
        let section = indexPath.section
        if kind == UICollectionElementKindSectionHeader{
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? CollectionReusableView
            if section == 0{
                header?.headerLabel.text = "Hungary"
                return header!
            }
            else if section == 1{
                header?.headerLabel.text = "Slovenia"
                return header!
            }
            else{
                header?.headerLabel.text = "Italy"
                return header!
            }
        }
        if kind == UICollectionElementKindSectionFooter{
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? CollectionReusableView2
            if section == 0{
                footer?.footerLabel.text = "After Hungary we went and camped in..."
                return footer!
            }
            else if section == 1{
                footer?.footerLabel.text = "We hopped over the border for dinner in..."
                return footer!
            }
            else{
                footer?.footerLabel.text = "The end..."
                return footer!
            }
        }
        return footer!
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return sectionInsets
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showDetail"{
            //let section = indexPath.section
            let indexPath = collectionView?.indexPath(for: sender as! CollectionViewCell)
            let section = indexPath?.section
            let detailVC = segue.destination as! DetailViewController
            if section == 0{
                detailVC.imageName = hungaryImages[(indexPath?.row)!]
            }
            else if section == 1{
                detailVC.imageName = sloveniaImages[(indexPath?.row)!]
            }
            else{
                detailVC.imageName = italyImages[(indexPath?.row)!]
            }
            
        }
    }
  /*
    func collectionView(_ collectionView: UICollectionView, layout collecitonViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)->CGSize{
        let hImage = UIImage(named: hungaryImages[indexPath.row])
        let sImage = UIImage(named: sloveniaImages[indexPath.row])
        let iImage = UIImage(named: italyImages[indexPath.row])
        let newSize = CGSize(width:150, height:150)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        let rect = CGRect(x:0,y:0,width:newSize.width,height:newSize.height)
        hImage?.draw(in:rect)
        sImage?.draw(in:rect)
        iImage?.draw(in:rect)
        let image2=UIGraphicsGetImageFromCurrentImageContext()
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
