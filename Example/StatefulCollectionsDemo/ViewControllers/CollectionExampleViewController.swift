//
//  CollectionExampleViewController.swift
//  StatefulCollectionsDemo
//
//  Created by Guillem Espejo on 28/02/2020.
//  Copyright © 2020 GuillemEspejo. All rights reserved.
//

import UIKit
import StatefulCollections

class CollectionExampleViewController: UIViewController {

    //@IBOutlet weak var collectionView: StatefulCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  collectionView.setState(to: .error)
      //  collectionView.setText(to: "HOLY CRAP", forState: .loading)
    }

}

extension CollectionExampleViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    

}


