//
//  tableWantViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2019/01/14.
//  Copyright © 2019年 Chihiro Kitano. All rights reserved.
//

import UIKit
import RealmSwift

class tableWantViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    let wantDetail = WantDetail()
    
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    // DBのデータを呼び出す
    let wantDitail = WantDetail()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DBからデータを取得して表示
        wantDetail.readAll()
        print(wantDetail.wantDetail)
        
        // デリゲートの選択
        tableView.delegate = self
        tableView.dataSource = self
        
        // テーブルビューにセルを紐付ける
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        // tableViewのインスタンス化
        tableView = UITableView()

        
        // カスタムセルのサイズを変更する
        tableView.rowHeight = 100
        
        let tableViewWidth:CGFloat = 370
        let tableViewHeight:CGFloat = 650
        
        // tableviewの表示位置を指定
        tableView.frame = CGRect(x: 20, y: 70, width: tableViewWidth, height: tableViewHeight)

        
        
  
        // Viewに追加する処理
        view.addSubview(tableView)
        
        // カスタムセルと紐付ける
        tableView.register (UINib(nibName: "WantTableCellTableViewCell", bundle: nil),forCellReuseIdentifier: "cell")

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wantDetail.wantDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WantTableCellTableViewCell
        
        // cellラベルの中に何を表示させるか
        cell.wantPlace.text = (wantDetail.wantDetail[indexPath.row]["place"] as! String)
        
        
        
        return cell
    }
    

    

}
