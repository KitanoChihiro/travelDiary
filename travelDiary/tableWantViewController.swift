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
    
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    // DBのデータを呼び出す
    let wantDetail = WantDetail()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DBからデータを取得して表示
        wantDetail.readAll()
        print(wantDetail.wantDetail)
        
        // デリゲートの選択
        tableView.delegate = self
        tableView.dataSource = self
        
        // テーブルにセルを紐付ける
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        // tableViewのインスタンス化
//        tableView = UITableView()

        // カスタムセルのサイズを変更する
        tableView.rowHeight = 100
        
        
        let tableViewWidth:CGFloat = 370
        let tableViewHeight:CGFloat = 650
        
        // tableviewの表示位置を指定
        tableView.frame = CGRect(x: 20, y: 70, width: tableViewWidth, height: tableViewHeight)

  
        // Viewに追加する処理
        view.addSubview(tableView)
        
        // カスタムセルと紐付ける
//        tableView.register (UINib(nibName: "WantTableCellTableViewCell", bundle: nil),forCellReuseIdentifier: "customcell")
        let cellNib = WantTableCellTableViewCell.self
        tableView.register(cellNib, forCellReuseIdentifier: "customecell")
        tableView.reloadData()
    }
    
    // 何件表示するか
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(wantDetail.wantDetail.count)
        
        return wantDetail.wantDetail.count
    }
    
    
    // セルの内容を決める
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("こんにちは")
        
        // カスタムセルのインスタンス化
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! WantTableCellTableViewCell
        
        // cellラベルの中に何を表示させるか
        cell.wantPlace.text = (wantDetail.wantDetail[indexPath.row]["place"] as! String)
        
        // Date型をString型に変更
        // TODO: 表示の仕方をdatepickerと揃える
        let changeDate = stringFromDate(date: wantDetail.wantDetail[indexPath.row]["date"] as! Date, format: "yyyy年MM月dd日")
        cell.wantDate.text = changeDate
        
        cell.wantPurpose.text = (wantDetail.wantDetail[indexPath.row]["purpose"] as! String)

        return cell
    }
    
    // date型をstring型に変更するファンクション
    func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    

}
