//
//  MemeCollectionViewCell.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/19/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    var meme: Meme? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var memeImageView: UIImageView!
    
    private func updateViews(){
        guard let passedInMeme = meme else {
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
            return
        }
        memeImageView.image = passedInMeme.memeImage
    }
}
