//
//  ViewController.swift
//  TableView
//
//  Created by Richard Richard on 8/31/17.
//  Copyright © 2017 Richard Richard. All rights reserved.
//

import UIKit

class TableViewController: TableController {
    
    let refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create Navigation Bar item
        let addBar = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.moveToAddView))
        
        // Create Table View
        dataTable = UITableView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight - barHeight))
        dataTable?.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        dataTable?.delegate = self
        dataTable?.dataSource = self
        
        // Create pull to refresh tableview
        refresher.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refresher.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        
        self.getuserList()
        self.view.addSubview(dataTable!)
        dataTable?.addSubview(refresher)
        self.navigationItem.rightBarButtonItem = addBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getuserList()
    }
    
    func refreshTable() {
        getuserList()
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(stopRefreshing), userInfo: nil, repeats: false)
        print("\(timer) is refreshing dataTable")
    }
    
    func stopRefreshing() {
        refresher.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}

