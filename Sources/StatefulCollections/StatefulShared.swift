//
//  StatefulShared.swift
//  StatefulCollections
//
//  Created by Guillem Espejo on 28/02/2020.
//  Copyright © 2020 Guillem Espejo. All rights reserved.
//

import Foundation
import UIKit

public enum CollectionState : CaseIterable{ //CaseIterable allows the use of 'allCases'
    case normal
    case empty
    case loading
    case error
}

class CollectionStateData{
    var stateId : CollectionState
    var image : UIImage?
    var text : String?
    
    private init(identifier:CollectionState, image:UIImage?, text:String?) {
        self.stateId = identifier
        self.image = image
        self.text = text
    }
    
    static func create(forIdentifier identifier:CollectionState) -> CollectionStateData{
        var stateData : CollectionStateData

        switch identifier {
            case .normal:
                stateData = CollectionStateData(identifier: .normal,
                                      image: nil,
                                      text: nil)
            
            case .loading:
                stateData = CollectionStateData(identifier: .loading,
                                      image: nil,
                                      text: "Loading...")
            
            case .empty:
                stateData = CollectionStateData(identifier: .empty,
                                      image: UIImage(systemName: "text.badge.xmark"),
                                      text: "No results")
            
            case .error:
                stateData = CollectionStateData(identifier: .error,
                                      image: UIImage(systemName: "xmark.octagon"),
                                      text: "There was an unknown error")

        }
        
        return stateData
    }

}
