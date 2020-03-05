//
//  StatefulCollectionView.swift
//  StatefulCollections
//
//  Created by Guillem Espejo on 28/02/2020.
//  Copyright © 2020 Guillem Espejo. All rights reserved.
//

/*
import UIKit

@IBDesignable public final class StatefulCollectionView: UICollectionView {

    // MARK: - Attributes
    private var currentImage : UIImageView!
    private var textLabel : UILabel!
    private var activityIndicator : UIActivityIndicatorView!
    private var stateList : [CollectionStateData] = []
    private var currentState : CollectionStateData?
    
    
    // ------------------------------------------------------------
    // INIT-DEINIT
    // ------------------------------------------------------------
    // MARK: - Init-Deinit
    override public func awakeFromNib(){
        super.awakeFromNib()

        // Image View
        self.currentImage = UIImageView()
        self.currentImage?.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        self.currentImage?.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        self.currentImage?.contentMode = .scaleAspectFill
        
        // Text Label
        self.textLabel = UILabel()
        self.textLabel?.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        self.textLabel?.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        self.textLabel?.textAlignment = .center
        
        // Activity indicator for loading state
        self.activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.activityIndicator.startAnimating()

        //Stack View
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing  = 16.0

        stackView.addArrangedSubview(self.currentImage!)
        stackView.addArrangedSubview(self.activityIndicator!)
        stackView.addArrangedSubview(self.textLabel!)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundView = stackView

        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        // When all the views are ready, we initialize state data
        fillStateData()
        setState(to: .normal)
    }
    
    override public func reloadData() {
        if numberOfRowsInAllSections() != 0 {
            setState(to: .normal)
        }
        
        super.reloadData()
    }
    
    // ------------------------------------------------------------
    // PUBLIC API METHODS
    // ------------------------------------------------------------
    // MARK: - Public API Methods
    public func setState(to state:CollectionState){
        let data = getStateData(for: state)
        self.currentImage?.image = data?.image
        self.textLabel?.text = data?.text
        
        self.currentImage.isHidden = self.currentImage?.image == nil
        self.textLabel.isHidden = self.textLabel?.text == nil
        self.activityIndicator.isHidden = !(data?.showIndicator ?? true)
        
        self.currentState = data

    }
    
    public func setImage(to image:UIImage?, forState state:CollectionState){
        let data = getStateData(for: state)
        data?.image = image
        setStateIfNeeded()
    }
    
    public func setText(to text:String?, forState state:CollectionState){
        let data = getStateData(for: state)
        data?.text = text
        setStateIfNeeded()
    }

    public func reset(state:CollectionState){
        let index = self.stateList.firstIndex { (statedata) -> Bool in
            return statedata.stateId == state
        }
        
        guard let finalIndex = index else{
            print("StatefulCollectionView error: State '\(state)' not found!")
            return
        }
        
        let restoredState = CollectionStateData.create(forIdentifier: state)
        self.stateList[finalIndex] = restoredState
        
        setStateIfNeeded()
    }
    
    public func resetAllStates(){
        self.stateList.removeAll()
        fillStateData()
        setStateIfNeeded()
    }
    
    
    // ------------------------------------------------------------
    // PRIVATE METHODS
    // ------------------------------------------------------------
    // MARK: - Private methods
    private func getStateData(for state:CollectionState) -> CollectionStateData? {
        let stateData = self.stateList.first { (statedata) -> Bool in
            return statedata.stateId == state
        }
        
        guard let data = stateData else{
            print("StatefulTableView error: State '\(state)' not found!")
            return nil
        }
        
        return data
    }
    
    private func fillStateData(){
        for state in CollectionState.allCases {
            let data = CollectionStateData.create(forIdentifier: state)
            stateList.append(data)
        }
    }
    
    private func setStateIfNeeded(){
        // If the current state is the one being modified, we refresh all its data
        if let currentId = currentState?.stateId {
            setState(to: currentId)
        }
    }

    private func numberOfRowsInAllSections() -> Int {
        let numberOfSections = self.dataSource?.numberOfSections?(in: self) ?? 1
        var rows = 0
        for i in 0 ..< numberOfSections {
            rows += self.dataSource?.collectionView(self, numberOfItemsInSection: i) ?? 0
        }
        return rows
    }
}
*/


