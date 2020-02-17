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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func shareButttonTapped(_ sender: UIBarButtonItem) {
        //save new photo to library
    }
    
    @IBAction func cancelMemeButtonTapped(_ sender: UIBarButtonItem) {
        //clear everything
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        //check to see if device has camera - if not disable button
    }
    
    @IBAction func albumButtonTapped(_ sender: UIBarButtonItem) {
        //open up photoLibrary
    }
}

