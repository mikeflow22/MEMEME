//
//  MemeCollectionViewController.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/18/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    let memeController = MemeController.shared
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure the collectionViewLayout
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        collectionViewFlowLayout.minimumInteritemSpacing = space
        collectionViewFlowLayout.minimumLineSpacing = space
        collectionViewFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            guard let destinationVC = segue.destination as? DetailMemeViewController, let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                return
            }
            let memeToPass = memeController.memes[indexPath.item]
            destinationVC.meme = memeToPass
        }
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeController.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as! MemeCollectionViewCell
        let memeToPass = memeController.memes[indexPath.row]
        cell.meme = memeToPass
        
        return cell
    }
    
}
