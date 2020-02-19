//
//  DetailMemeViewController.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/18/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class DetailMemeViewController: UIViewController {
    
    var meme: Meme? {
        didSet {
            updateImage()
        }
    }
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage()
    }
    
    //make this reusable
    func updateImage(){
        guard let passedInMeme = meme, isViewLoaded else {
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
            return
        }
        memeImageView.image = passedInMeme.memeImage
    }


}
