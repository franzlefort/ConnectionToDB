//
//  ViewController.swift
//  ConnectionToDB
//
//  Created by Avefranz on 12/06/2019.
//  Copyright © 2019 Avefranz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HomeModelDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tv: UITableView!
    var homeModel = HomeModel();
    var customers = [Customer]();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv.delegate = self;
        tv.dataSource = self;
        
        // Do any additional setup after loading the view.
        homeModel.getItems();
        homeModel.delegate = self;
    }
    
    func itemsDownloaded(customers: [Customer]) {
        
        self.customers = customers
        
        tv.reloadData();
    }
    
    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return customers.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath);
        
        cell.textLabel?.text = customers[indexPath.row].name;
        
        return cell;
    }
}

