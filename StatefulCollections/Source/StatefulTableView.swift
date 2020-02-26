//
//  StatefulTableView.swift
//  StatefulCollectionsDemo
//
//  Created by Guillem Espejo on 20/02/2020.
//  Copyright © 2020 Guillem Espejo. All rights reserved.
//

import UIKit

public enum TableViewState : CaseIterable{ //CaseIterable allows the use of 'allCases'
    case normal
    case empty
    case loading
    case error
}

private class TableViewStateData{
    var stateId : TableViewState
    var image : UIImage?
    var text : String?
    var separatorStyle : UITableViewCell.SeparatorStyle
    var showIndicator : Bool
    
    init(identifier:TableViewState, image:UIImage? , text:String?,separatorStyle : UITableViewCell.SeparatorStyle,showIndicator:Bool) {
        self.stateId = identifier
        self.image = image
        self.text = text
        self.separatorStyle = separatorStyle
        self.showIndicator = showIndicator
        
    }
}

@IBDesignable public final class StatefulTableView: UITableView {

    // MARK: - Attributes
    private var currentImage : UIImageView!
    private var textLabel : UILabel!
    private var activityIndicator : UIActivityIndicatorView!
    private var stateList : [TableViewStateData] = []
    private var currentState : TableViewStateData?
    
    
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
    public func setState(to state:TableViewState){
        let data = getStateData(for: state)
        self.currentImage?.image = data?.image
        self.textLabel?.text = data?.text
        self.separatorStyle = data?.separatorStyle ?? .singleLine
        
        self.currentImage.isHidden = self.currentImage?.image == nil
        self.textLabel.isHidden = self.textLabel?.text == nil
        self.activityIndicator.isHidden = !(data?.showIndicator ?? true)
        
        self.currentState = data

    }
    
    public func setImage(to image:UIImage?, forState state:TableViewState){
        let data = getStateData(for: state)
        data?.image = image
        setStateIfNeeded()
    }
    
    public func setText(to text:String?, forState state:TableViewState){
        let data = getStateData(for: state)
        data?.text = text
        setStateIfNeeded()
    }
    
    public func setSeparator(to separator:UITableViewCell.SeparatorStyle, forState state:TableViewState){
        let data = getStateData(for: state)
        data?.separatorStyle = separator
        setStateIfNeeded()
    }

    public func reset(state:TableViewState){
        let index = self.stateList.firstIndex { (statedata) -> Bool in
            return statedata.stateId == state
        }
        
        guard let finalIndex = index else{
            print("StatefulTableView error: State '\(state)' not found!")
            return
        }
        
        let restoredState = createStateData(forIdentifier: state)
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
    private func createStateData(forIdentifier identifier:TableViewState) -> TableViewStateData{
        var stateData : TableViewStateData

        switch identifier {
            case .normal:
                stateData = TableViewStateData(identifier: .normal,
                                      image: nil,
                                      text: nil,
                                      separatorStyle:.singleLine,
                                      showIndicator: false)
            
            case .loading:
                stateData = TableViewStateData(identifier: .loading,
                                      image: nil,
                                      text: "Loading...",
                                      separatorStyle:.none,
                                      showIndicator: true)
            
            case .empty:
                stateData = TableViewStateData(identifier: .empty,
                                      image: UIImage(systemName: "text.badge.xmark"),
                                      text: "No results",
                                      separatorStyle:.none,
                                      showIndicator: false)
            
            case .error:
                stateData = TableViewStateData(identifier: .error,
                                      image: UIImage(systemName: "xmark.octagon"),
                                      text: "There was an unknown error",
                                      separatorStyle:.none,
                                      showIndicator: false)

        }
        
        return stateData
    }
    
    private func getStateData(for state:TableViewState) -> TableViewStateData? {
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
        for state in TableViewState.allCases {
            let data = createStateData(forIdentifier: state)
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
            rows += self.dataSource?.tableView(self, numberOfRowsInSection: i) ?? 0
        }
        return rows
    }
}

