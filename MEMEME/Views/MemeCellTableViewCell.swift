//
//  MemeCellTableViewCell.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/18/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class MemeCellTableViewCell: UITableViewCell {
    var meme: Meme? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topTextField: UILabel!
     
    private func updateViews(){
        guard let passedInMeme = meme else {
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
            return
        }
        memeImageView.image = passedInMeme.memeImage
        topTextField.text = passedInMeme.topText
    }
}
