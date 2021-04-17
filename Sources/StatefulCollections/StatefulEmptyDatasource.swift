//
//  StatefulDatasources.swift
//  StatefulCollections
//
//  Created by Guillem Espejo on 05/03/2020.
//  Copyright © 2020 GEspejo. All rights reserved.
//

import Foundation
import UIKit

// Basic empty datasource used when StatefulCollections are loading data
class StatefulEmptyDatasource : NSObject, UITableViewDataSource , UICollectionViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
