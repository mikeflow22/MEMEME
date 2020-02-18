//
//  ViewController.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/17/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButtonProperties: UIBarButtonItem!
    @IBOutlet weak var shareButtonProperties: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        cameraButtonProperties.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        if photoImage.image == nil {
            shareButtonProperties.isEnabled = false
        }
    }
    
    @IBAction func shareButttonTapped(_ sender: UIBarButtonItem) {
        //save new photo to library
        guard let top = topTextField.text, !top.isEmpty, let bottom = bottomTextField.text, !bottom.isEmpty, let originalImage = photoImage.image else {
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
            return
        }
        let memeImage = createMemeImage()
        //initialize an activity controller
        let activityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        
        //present activity controller modally
        activityController.modalPresentationStyle = .currentContext
        present(activityController, animated: true)
        
        //call activityController's completionWithItemsHandler and save meme if successful
        
        activityController.completionWithItemsHandler = { (nil, success, _, error ) in
            if let error = error {
                print("Error in file: \(#file) in the body of the function: \(#function)\n on line: \(#line)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)\n")
                return
            }
            if success {
                print("Success in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                //save meme
                self.saveMeme(topText: top, bottomText: bottom, originalImage: originalImage, memeImage: memeImage)
            } else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                return
            }
        }
    }
    
    func createMemeImage()-> UIImage {
        //hide other views
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        //take "screen shot of screen"
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func saveMeme(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage){
        MemeController.createMeme(withTopText: topText, bottomText: bottomText, andMemeImage: memeImage, originalImage: originalImage)
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
    }
    
    @IBAction func cancelMemeButtonTapped(_ sender: UIBarButtonItem) {
        //clear everything
        photoImage.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        //check to see if device has camera - if not disable button
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //REFACTOR
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
    
    @IBAction func albumButtonTapped(_ sender: UIBarButtonItem) {
        //open up photoLibrary -REFACTOR
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let choosenImage = info[.originalImage] as? UIImage else {
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
            return
        }
        photoImage.image = choosenImage
        shareButtonProperties.isEnabled = true
        dismiss(animated: true)
    }
    
}

