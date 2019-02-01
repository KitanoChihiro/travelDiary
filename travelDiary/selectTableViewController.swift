//
//  selectTableViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2019/01/31.
//  Copyright © 2019年 Chihiro Kitano. All rights reserved.
//

import UIKit

class selectTableViewController: UIViewController {
    
    // セグメンティッドコントロールのインスタンス化
    @IBOutlet weak var selectedBtn: UISegmentedControl!
    
    // 遷移先のビューの定義
    var wentTVC:UIViewController = tableWentViewController()
    var wantTVC:UIViewController = tableWantViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 関数の呼び出し
        setup()
        
    }
    func setup(){
        // ボタンの名前定義
        // ページを開いたときに後から表示したいものを先に書く
        selectedBtn.setTitle("行った", forSegmentAt: 0)
        selectedBtn.setTitle("行きたい", forSegmentAt: 1)
        
        // ビューに追加
        self.view.addSubview(wantTVC.view)
        self.view.addSubview(wentTVC.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // 切り替えられた時の動作
    @IBAction func selectedBtn(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(wentTVC.view)
        case 1:
            self.view.bringSubviewToFront(wantTVC.view)
        default:
            print("")
        }
    }
    
}
