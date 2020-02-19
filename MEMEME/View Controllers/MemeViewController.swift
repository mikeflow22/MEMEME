//
//  ViewController.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/17/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButtonProperties: UIBarButtonItem!
    @IBOutlet weak var shareButtonProperties: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(textField: topTextField, defaultText: "TOP")
        setup(textField: bottomTextField, defaultText: "BOTTTOM")
        cameraButtonProperties.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        if photoImage.image == nil {
            shareButtonProperties.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Subscribe to the keyboard notifications, to allow the view to raise when necessary
        subscribeToKeyboardNotifications()
        subscribeToKeyboardWillHideNotifications()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotification()
        unsubscribeFromKeyboardWillHideNotification()
        self.navigationController?.navigationBar.isHidden = false

    }
    
    func setup(textField: UITextField, defaultText: String){
        textField.delegate = self
        textField.text = defaultText.uppercased()
    }
    
    func hideToolbars(_ hide: Bool){
        topToolbar.isHidden = hide
        bottomToolbar.isHidden = hide
    }
    func createMemeImage()-> UIImage {
        //hide other views
        hideToolbars(true)
        
        //take "screen shot of screen"
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func resetView(){
        cameraButtonProperties.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        photoImage.image = nil
        setup(textField: topTextField, defaultText: "TOP")
        setup(textField: bottomTextField, defaultText: "BOTTTOM")
        if photoImage.image == nil {
            shareButtonProperties.isEnabled = false
        }
    }
    
    func saveMeme(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage){
        let _ = MemeController.shared.createMeme(with: memeImage, originalImage: originalImage, topText: topText, bottomText: bottomText)
        hideToolbars(false)
        resetView()
    }
    
    //get keyboard height
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        //slide the view up to make room for the keyboard
        if bottomTextField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        //slide the view up to make room for the keyboard
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications(){
        print("subscribed to notification")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification(){
        print("unsubscribe from notification")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardWillHideNotifications(){
        print("subscribed to will hide notification")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardWillHideNotification(){
        print("unsubscribe from will hide notification")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                return
            }
        }
    }
    
    @IBAction func cancelMemeButtonTapped(_ sender: UIBarButtonItem) {
        //clear everything
        resetView()
       self.navigationController?.popToRootViewController(animated: true)
    }
    
    func openImagePicker(_ type: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        //check to see if device has camera - if not disable button
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            openImagePicker(.camera)
        }
    }
    
    @IBAction func albumButtonTapped(_ sender: UIBarButtonItem) {
        openImagePicker(.photoLibrary)
    }
}

extension MemeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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

