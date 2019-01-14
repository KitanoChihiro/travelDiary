//
//  wantTableViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2019/01/08.
//  Copyright © 2019年 Chihiro Kitano. All rights reserved.
//

import UIKit


class wantTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }


}


