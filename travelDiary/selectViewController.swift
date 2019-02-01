//
//  selectViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2019/01/31.
//  Copyright © 2019年 Chihiro Kitano. All rights reserved.
//

import UIKit

class selectViewController: UIViewController {
    
    @IBOutlet weak var selectBtn: UISegmentedControl!
    
    var wentVC:UIViewController = WentViewController()
    var wantVC:UIViewController = WantViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 関数の呼び出し
        setup()
    }
    
    func setup(){
        selectBtn.setTitle("行った", forSegmentAt: 0)
        selectBtn.setTitle("行きたい", forSegmentAt: 1)
        self.view.addSubview(wantVC.view)
        self.view.addSubview(wentVC.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func selectBtn(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(wentVC.view)
        case 1:
            self.view.bringSubviewToFront(wantVC.view)
        default:
            print("")
        }
    }
}
