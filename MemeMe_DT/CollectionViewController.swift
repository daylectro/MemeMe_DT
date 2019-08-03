//
//  CollectionViewController.swift
//  MemeMe_DT
//
//  Created by Daniel Tiemor on 30.07.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController
{


    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!


    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }


    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return memes.count
    }



    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
//        let memes2 = self.memes[(indexPath as NSIndexPath).row]

        // Set the name and image
//        cell.nameLabel.text = villain.name
        cell.collectionImageView?.image = memes[indexPath.row].memedImage

        return cell
    }

//    // override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
//
//    // Grab the DetailVC from Storyboard
//    let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
//
//    //Populate view controller with data from the selected item
//    detailController.villain = allVillains[(indexPath as NSIndexPath).row]
//
//    // Present the view controller using navigation
//    navigationController!.pushViewController(detailController, animated: true)
//
//}



 

}
