//
//  MemeController.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/18/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class MemeController {
    static let shared = MemeController()
    var memes: [Meme] = []
    
    func createMeme(with memeImage: UIImage, originalImage: UIImage, topText: String, bottomText: String){
        let meme = Meme(memeImage: memeImage, orginalImage: originalImage, topText: topText, bottomText: bottomText)
        memes.append(meme)
    }
}
