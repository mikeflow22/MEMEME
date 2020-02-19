//
//  SentMemesTableViewController.swift
//  MEMEME
//
//  Created by Michael Flowers on 2/18/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

    let memeController = MemeController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memeController.memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath) as! MemeCellTableViewCell
        let memeToPassToCell = memeController.memes[indexPath.row]
        cell.meme = memeToPassToCell
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            guard let destinationVC = segue.destination as? DetailMemeViewController, let indexPath = tableView.indexPathForSelectedRow else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                return
            }
            let memeToPass = memeController.memes[indexPath.row]
            destinationVC.meme = memeToPass
        }
    }
 

}
