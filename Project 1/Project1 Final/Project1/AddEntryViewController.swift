//
//  AddEntryViewController.swift
//  Project1
//
//  Created by Kaelen Guthrie on 3/2/18.
//  Copyright © 2018 Kaelen Guthrie. All rights reserved.
//
//  textView placeholder: https://www.youtube.com/watch?v=dEGFADjp_q0
//
//

import UIKit

class AddEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var entryName: UITextField!
    @IBOutlet weak var entryText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var entryImageName: String?
    var entryImagePath: URL?
    
    var newEntryImageName = String()
    var newEntryImagePath: URL?
    var newEntryName = String()
    var newDate = String()
    var newEntryText = String()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        
        if segue.identifier == "saveEntry"{
            if(entryName.text?.isEmpty == false && entryText.text?.isEmpty == false && imageView.image != nil){
                newEntryName = entryName.text!
                newEntryText = entryText.text!
                newEntryImageName = entryImageName!
                newEntryImagePath = entryImagePath!
                newDate = strDate
            }
        }
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        newDate = strDate
        //print(strDate)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Tell a story about your adventure..."){
            textView.text = ""
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text == ""){
            textView.text = "Tell a story about your adventure..."
        }
        textView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        
        entryName.delegate = self
        entryText.delegate = self
        
        super.viewDidLoad()
        
        
        
        //datePicker.addTarget(self, action: #selector(AddEntryViewController.datePickerChanged(_:)), for: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
       
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPicture(_ sender: Any) {
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
        entryImagePath = imagePath
        entryImageName = imageName
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

