//
//  TableExampleViewController.swift
//  StatefulCollectionsDemo
//
//  Created by Guillem Espejo on 28/02/2020.
//  Copyright © 2020 GuillemEspejo. All rights reserved.
//

import UIKit
import StatefulCollections

class TableExampleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    @IBOutlet weak var tableview: StatefulTableView!
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
        self.tableview.resetAllStates()
        self.tableview.resetTextColor()
        self.tableview.resetImageTint()
        
        // Set desired fake results
        showData = true
        simulateLoading()
    }
    
    @IBAction func emptyTapped(_ sender: Any) {
        // Default states
        self.tableview.resetAllStates()
        self.tableview.resetTextColor()
        self.tableview.resetImageTint()
        
        // Set desired fake results
        showData = false
        simulateLoading()
    }
    
    @IBAction func errorTapped(_ sender: Any) {
        // Default states
        self.tableview.resetAllStates()
        self.tableview.resetTextColor()
        self.tableview.resetImageTint()
        
        // Set desired fake results
        showData = nil
        simulateLoading()
    }
    
    @IBAction func custom1Tapped(_ sender: Any) {
        // Set custom data 1
        self.tableview.setText(to: "Parsing...", forState: .loading)
        self.tableview.setText(to: "Empty results when parsing", forState: .empty)
        
        let image = UIImage(systemName: "trash")
        self.tableview.setImage(to: image, forState: .empty)
        self.tableview.setImageTint(to: .red)
        self.tableview.setTextColor(to: .blue)
       
        // Set desired fake results
        showData = false
        simulateLoading()
    }
    
    @IBAction func custom2Tapped(_ sender: Any) {
        // Set custom data 2
        self.tableview.setText(to: "Processing...", forState: .loading)
        self.tableview.setText(to: "There was an error during processing", forState: .error)
        
        // Set desired fake results
        showData = nil
        simulateLoading()
    }
    
    // ------------------------------------------------------------
    // PRIVATE
    // ------------------------------------------------------------
    // MARK: - Private
    private func simulateLoading(){
        enableButtons(false)
        
        self.tableview.setState(to: .loading)
        
        // Simulate processing time and show results
        let when = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.enableButtons(true)
            self.simulateResults()
        }
    }
    
    private func simulateResults(){
        if showData == nil {
            self.tableview.setState(to: .error)
            
        }else if showData! {
            self.tableview.setState(to: .normal)
            
        }else{
            self.tableview.setState(to: .empty)
        }

        tableview.reloadData()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")
        let bookData = bookList[indexPath.row]
        
        cell?.textLabel?.text = bookData.name
        cell?.detailTextLabel?.text = bookData.author
        
        return cell!
    }
    
}

