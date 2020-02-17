//
//  MemeController.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/17/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class MemeController {
    static func createMeme(withTopText: String, bottomText: String, andMemeImage: UIImage, originalImage: UIImage)  {
        let _ = Meme(memeImage: andMemeImage, orginalImage: originalImage, topText: withTopText, bottomText: bottomText)
    }

}
