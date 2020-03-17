//
//  StatefulTableView.swift
//  StatefulCollections
//
//  Created by Guillem Espejo on 20/02/2020.
//  Copyright © 2020 Guillem Espejo. All rights reserved.
//

import UIKit


@IBDesignable public final class StatefulTableView: UITableView {

    // MARK: - Attributes
    private var currentImage : UIImageView!
    private var textLabel : UILabel!
    private var activityIndicator : UIActivityIndicatorView!
    private var stateList : [CollectionStateData] = []
    private var currentState : CollectionStateData?
    
    private var emptyDatasource : UITableViewDataSource?
    private var originalDatasource : UITableViewDataSource?
    private var currentSeparator : UITableViewCell.SeparatorStyle!
    
    private var imageTint : UIColor?
    private var textColor : UIColor?
    
    
    // ------------------------------------------------------------
    // INIT-DEINIT
    // ------------------------------------------------------------
    // MARK: - Init-Deinit
    override public func awakeFromNib(){
        super.awakeFromNib()
        
        self.currentSeparator = self.separatorStyle
        
        self.originalDatasource = self.dataSource
        self.emptyDatasource = StatefulEmptyDatasource()
        
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

        // Stack View
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing  = 16.0

        stackView.addArrangedSubview(self.currentImage!)
        stackView.addArrangedSubview(self.activityIndicator!)
        stackView.addArrangedSubview(self.textLabel!)
        
        // Misc
        self.backgroundView = stackView
        self.imageTint = self.currentImage.tintColor
        self.textColor = self.textLabel.textColor

        // Constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // When all the views are ready, we initialize state data
        fillStateData()
        setState(to: .normal)
        
    }
    
    // ------------------------------------------------------------
    // PUBLIC API METHODS
    // ------------------------------------------------------------
    // MARK: - Public API Methods
    /**
    Sets the tableview state. There are four available values: `normal`, `loading`, `empty` and `error`
    - Parameter state: The desired state value.
    */
    public func setState(to state:CollectionState){
        let data = getStateData(for: state)
        self.currentState = data
        
        self.textLabel?.text = data?.text
        self.textLabel.isHidden = self.textLabel?.text == nil
        self.currentImage?.image = data?.image
        self.currentImage.isHidden = self.currentImage?.image == nil
        
        if state == .loading{
            self.dataSource = self.emptyDatasource
            self.activityIndicator.isHidden = false
            self.separatorStyle = .none
    
        }else if state == .normal {
            self.dataSource = self.originalDatasource
            self.activityIndicator.isHidden = true
            self.separatorStyle = self.currentSeparator
                
        }else{
            self.dataSource = self.originalDatasource
            self.activityIndicator.isHidden = true
            self.separatorStyle = .none
            
        }
        
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
        self.currentImage.tintColor = color
    }
    
    /**
    Sets the color of the background texts. Any change in the color will affect all states simultaneously.
    - parameter color: The color to be used as tint for the state texts.
     */
    public func setTextColor(to color:UIColor){
        self.textLabel.textColor = color
    }
    
    /**
    Resets the tint of the background images to the default one. It will reset the tint of all states simultaneously.
     */
    public func resetImageTint(){
        self.currentImage.tintColor = self.imageTint
    }
    
    /**
    Resets the color of the background texts to the default one. It will reset the color of all states simultaneously.
     */
    public func resetTextColor(){
        self.textLabel.textColor = self.textColor
    }

    /**
    Resets the image and text of the selected state. Does not affect image tint or text color.
    - parameter state: The desired state value to reset.
     */
    public func reset(state:CollectionState){
        let index = self.stateList.firstIndex { (statedata) -> Bool in
            return statedata.stateId == state
        }
        
        guard let finalIndex = index else{
            print("StatefulTableView error: State '\(state)' not found!")
            return
        }
        
        let restoredState = CollectionStateData.create(forIdentifier: state)
        self.stateList[finalIndex] = restoredState
        
        setStateIfNeeded()
    }
    
    /**
    Resets the images and texts of all states. Does not affect image tint or text color.
     */
    public func resetAllStates(){
        self.stateList.removeAll()
        fillStateData()
        setStateIfNeeded()
    }
    
    
    // ------------------------------------------------------------
    // PRIVATE METHODS
    // ------------------------------------------------------------
    // MARK: - Private methods
    // Retrieves the state data.
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

