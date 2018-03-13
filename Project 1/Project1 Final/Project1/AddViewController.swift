//
//  AddViewController.swift
//  Project1
//
//  Created by Kaelen Guthrie on 2/28/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//

import UIKit
import MobileCoreServices

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var vacationImagePath: URL?
    var vacationImageName: String?
    
    var newImagePath: URL?
    var newImageName: String?
    var newDestinationName: String?
    
    @IBOutlet weak var destinationName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "saveAdventure"{
            //let collectionVC = segue.destination as! CollectionViewController
            if imageView.image == nil{
                 //let collectionVC = segue.destination as! CollectionViewController
                 //collectionVC.adventure.imageName = nil
                 //collectionVC.adventure.imagePath = nil
            }else{
                newImagePath = vacationImagePath
                newImageName = vacationImageName
                if destinationName.text!.isEmpty == false{
                    newDestinationName = destinationName.text!
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        imageView.image = UIImage(imageName)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        
        destinationName.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Looks for single or multiple taps.
        
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPicture(_ sender: Any){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(image, 80) {
            try? jpegData.write(to: imagePath)
        }
        //        print(contentsOfFile: imagePath)
        //        print("image",image)
        //        print(imageName)
        vacationImagePath = imagePath
        vacationImageName = imageName
        //        print(jpegData)
        imageView.image = image
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
