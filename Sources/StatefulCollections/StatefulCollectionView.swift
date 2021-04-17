//
//  StatefulCollectionView.swift
//  StatefulCollections
//
//  Created by Guillem Espejo on 28/02/2020.
//  Copyright © 2020 Guillem Espejo. All rights reserved.
//

import UIKit

@IBDesignable public final class StatefulCollectionView: UICollectionView {

    // MARK: - Attributes
    private var currentImage : UIImageView!
    private var textLabel : UILabel!
    private var activityIndicator : UIActivityIndicatorView!
    private var stateList : [CollectionStateData] = []
    private var currentState : CollectionStateData?
    
    private var emptyDatasource : UICollectionViewDataSource?
    private var originalDatasource : UICollectionViewDataSource?
    
    private var imageTint : UIColor?
    private var textColor : UIColor?
    
    // ------------------------------------------------------------
    // MARK: - Init-Deinit
    override public func awakeFromNib(){
        super.awakeFromNib()
        
        originalDatasource = dataSource
        emptyDatasource = StatefulEmptyDatasource()
        
        // Image View
        currentImage = UIImageView()
        currentImage?.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        currentImage?.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        currentImage?.contentMode = .scaleAspectFill
        
        // Text Label
        textLabel = UILabel()
        textLabel?.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        textLabel?.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        textLabel?.textAlignment = .center
        
        // Activity indicator for loading state
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.startAnimating()

        // Stack View
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing  = 16.0

        stackView.addArrangedSubview(currentImage!)
        stackView.addArrangedSubview(activityIndicator!)
        stackView.addArrangedSubview(textLabel!)
        
        // Misc
        let background = UIView()
        background.addSubview(stackView)
        backgroundView = background
        imageTint = currentImage.tintColor
        textColor = textLabel.textColor

        // Constraints
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
 
        // When all the views are ready, we initialize state data
        fillStateData()
        setState(to: .normal)
        
    }
    
    // ------------------------------------------------------------
    // MARK: - Public API Methods
    /**
    Sets the collectionview state. There are four available values: `normal`, `loading`, `empty` and `error`
    - Parameter state: The desired state value.
    */
    public func setState(to state:CollectionState){
        let data = getStateData(for: state)
        currentState = data
        
        textLabel?.text = data?.text
        textLabel.isHidden = textLabel?.text == nil
        currentImage?.image = data?.image
        currentImage.isHidden = currentImage?.image == nil
        
        if state == .loading{
            dataSource = emptyDatasource
            activityIndicator.isHidden = false
    
        }else if state == .normal {
            dataSource = originalDatasource
            activityIndicator.isHidden = true
                
        }else{
            dataSource = originalDatasource
            activityIndicator.isHidden = true
        }
        
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    /**
    Sets the image of the selected state.
    - parameter image: The image to be used with the selected state.
    - parameter state: The desired state value to modify.
     */
    public func setImage(to image:UIImage?, forState state:CollectionState){
        let data = getStateData(for: state)
        data?.image = image
        setStateIfNeeded()
    }
    
    /**
    Sets the text of the selected state.
    - parameter text: The text to be used with the selected state.
    - parameter state: The desired state value to modify.
     */
    public func setText(to text:String?, forState state:CollectionState){
        let data = getStateData(for: state)
        data?.text = text
        setStateIfNeeded()
    }
    
    /**
    Sets the tint of the background images. Any change in the tint will affect all states simultaneously.
    - parameter color: The color to be used as tint for the state images.
     */
    public func setImageTint(to color:UIColor){
        currentImage.tintColor = color
    }
    
    /**
    Sets the color of the background texts. Any change in the color will affect all states simultaneously.
    - parameter color: The color to be used as tint for the state texts.
     */
    public func setTextColor(to color:UIColor){
        textLabel.textColor = color
    }
    
    /**
    Resets the tint of the background images to the default one. It will reset the tint of all states simultaneously.
     */
    public func resetImageTint(){
        currentImage.tintColor = imageTint
    }
    
    /**
    Resets the color of the background texts to the default one. It will reset the color of all states simultaneously.
     */
    public func resetTextColor(){
        textLabel.textColor = textColor
    }

    /**
    Resets the image and text of the selected state. Does not affect image tint or text color.
    - parameter state: The desired state value to reset.
     */
    public func reset(state:CollectionState){
        let index = stateList.firstIndex { (statedata) -> Bool in
            return statedata.stateId == state
        }
        
        guard let finalIndex = index else{
            print("StatefulCollectionView error: State '\(state)' not found!")
            return
        }
        
        let restoredState = CollectionStateData.create(forIdentifier: state)
        stateList[finalIndex] = restoredState
        
        setStateIfNeeded()
    }
    
    /**
    Resets the images and texts of all states. Does not affect image tint or text color.
     */
    public func resetAllStates(){
        stateList.removeAll()
        fillStateData()
        setStateIfNeeded()
    }
    
    // ------------------------------------------------------------
    // MARK: - Private methods
    // Retrieves the state data.
    private func getStateData(for state:CollectionState) -> CollectionStateData? {
        let stateData = stateList.first { (statedata) -> Bool in
            return statedata.stateId == state
        }
        
        guard let data = stateData else{
            print("StatefulCollectionView error: State '\(state)' not found!")
            return nil
        }
        
        return data
    }
    
    // Creates the state data for each available state and adds it to the list.
    private func fillStateData(){
        for state in CollectionState.allCases {
            let data = CollectionStateData.create(forIdentifier: state)
            stateList.append(data)
        }
    }
    
    // Reloads state data, used when a state is being modified and needs to update its corresponding view.
    private func setStateIfNeeded(){
        if let currentId = currentState?.stateId {
            setState(to: currentId)
        }
    }
}

