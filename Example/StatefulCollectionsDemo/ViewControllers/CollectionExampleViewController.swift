//
//  CollectionExampleViewController.swift
//  StatefulCollectionsDemo
//
//  Created by Guillem Espejo on 28/02/2020.
//  Copyright © 2020 GuillemEspejo. All rights reserved.
//

import UIKit
import StatefulCollections

class CollectionExampleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var bookList = Seeds.getBookList()
    private var showData : Bool? = true {
        didSet {
            if showData != nil && showData! {
                bookList = Seeds.getBookList()
            }else{
                bookList.removeAll()
            }
        }
    }
    
    @IBOutlet weak var collectionview: StatefulCollectionView!
    @IBOutlet weak var btnEmpty: UIBarButtonItem!
    @IBOutlet weak var btnDefault: UIBarButtonItem!
    @IBOutlet weak var btnError: UIBarButtonItem!
    @IBOutlet weak var btnCustom: UIBarButtonItem!
    @IBOutlet weak var btnCustom2: UIBarButtonItem!
    
    // ------------------------------------------------------------
    // LIFECYCLE
    // ------------------------------------------------------------
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ------------------------------------------------------------
    // IBACTIONS
    // ------------------------------------------------------------
    // MARK: - IBActions
    @IBAction func defaultTapped(sender _:Any){
        // Default states
        resetStates()
        
        // Set desired fake results
        showData = true
        simulateLoading()
    }
    
    @IBAction func emptyTapped(_ sender: Any) {
        // Default states
        resetStates()
        
        // Set desired fake results
        showData = false
        simulateLoading()
    }
    
    @IBAction func errorTapped(_ sender: Any) {
        // Default states
        resetStates()
        
        // Set desired fake results
        showData = nil
        simulateLoading()
    }
    
    @IBAction func custom1Tapped(_ sender: Any) {
        // Set custom data 1
        self.collectionview.setText(to: "Parsing...", forState: .loading)
        self.collectionview.setText(to: "Empty results when parsing", forState: .empty)
        
        let image = UIImage(systemName: "trash")
        self.collectionview.setImage(to: image, forState: .empty)
        self.collectionview.setImageTint(to: .red)
        self.collectionview.setTextColor(to: .blue)
       
        // Set desired fake results
        showData = false
        simulateLoading()
    }
    
    @IBAction func custom2Tapped(_ sender: Any) {
        // Set custom data 2
        self.collectionview.setText(to: "Processing...", forState: .loading)
        self.collectionview.setText(to: "There was an error during processing", forState: .error)
        
        // Set desired fake results
        showData = nil
        simulateLoading()
    }
    
    // ------------------------------------------------------------
    // PRIVATE
    // ------------------------------------------------------------
    // MARK: - Private
    private func simulateLoading(){
        self.collectionview.setState(to: .loading)
        
        // Simulate processing time and show results
        enableButtons(false)
        let when = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.enableButtons(true)
            self.simulateResults()
        }
    }
    
    private func simulateResults(){
        if showData == nil {
            self.collectionview.setState(to: .error)
            
        }else if showData! {
            self.collectionview.setState(to: .normal)
            
        }else{
            self.collectionview.setState(to: .empty)
        }

        self.collectionview.reloadData()
    }
    
    private func resetStates(){
        self.collectionview.resetAllStates()
        self.collectionview.resetTextColor()
        self.collectionview.resetImageTint()
    }
    
    private func enableButtons(_ isEnabled:Bool){
        self.btnEmpty.isEnabled = isEnabled
        self.btnError.isEnabled = isEnabled
        self.btnDefault.isEnabled = isEnabled
        self.btnCustom.isEnabled = isEnabled
        self.btnCustom2.isEnabled = isEnabled
    }
    
    // ------------------------------------------------------------
    // DATASOURCE, DELEGATE
    // ------------------------------------------------------------
    // MARK: - Datasource, delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionview.dequeueReusableCell(withReuseIdentifier: "BasicCollectionCell", for: indexPath)
    }
    
}

