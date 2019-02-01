//
//  tableWentViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2019/01/15.
//  Copyright © 2019年 Chihiro Kitano. All rights reserved.
//

import UIKit
import RealmSwift

class tableWentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    
    // セグエを通ってデータを送るためのへ変数
    var selectedIndex = -1
    var selectedPlace:String!
    var selectedDate:String!
    var selectedPerson:String!
    var selectedComment:String!
    var selectedURL:String!
    var selectedLanditude:Double!
    var selectedLongitude:Double!
    
    // DBのデータを呼び出す
    let wentDetail = WentDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DBからデータを取得して表示
        wentDetail.readAll()
        print(wentDetail.wentDetail)
        
        // デリゲートの選択
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        
        // カスタムセルのサイズを変更する
        tableView.rowHeight = 100
        
        
        let tableViewWidth:CGFloat = 370
        let tableViewHeight:CGFloat = 650
        
        // tableviewの表示位置を指定
        tableView.frame = CGRect(x: 20, y: 70, width: tableViewWidth, height: tableViewHeight)
        
        
        // Viewに追加する処理
        view.addSubview(tableView)
        view.backgroundColor = UIColor(hex: "FFE3A3")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // テーブルビューが読み込まれるたびに、データを読み込む
        tableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // テーブルビューに追加するセルの数
        return wentDetail.wentDetail.count
    }
    
    // TODO: セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = wentTableViewCell()
        // セルの中に矢印
        cell.accessoryType = .disclosureIndicator
        
        cell.wentCell()
        
        cell.wentPlace.text = (wentDetail.wentDetail[indexPath.row]["place"] as! String)
        
        // Date型をString型に変更
        // TODO: 表示の仕方をdatepickerと揃える
        let changeDate = stringFromDate(date: wentDetail.wentDetail[indexPath.row]["date"] as! Date, format: "yyyy年MM月dd日")
        
        cell.wentDate.text = changeDate
        
        return cell
        
    }
    
    // date型をstring型に変更するファンクション
    func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // セルが選択された時に行う処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)行目を選択")
        
        // セグエが選択された時にどのデータを取ってくるかの指定
        // （今選択されているおパスの指定）
        selectedIndex = indexPath.row
        selectedPlace = (wentDetail.wentDetail[indexPath.row]["place"] as! String)
        
        // Date型からString型に変更
        let changeDate = stringFromDate(date: wentDetail.wentDetail[indexPath.row]["date"] as! Date, format: "yyyy年MM月dd日")
        // 上記でDate型からString型に変更されたので、selectedDateに型変更したDateのデータを代入する
        selectedDate = changeDate
        
        selectedPerson = (wentDetail.wentDetail[indexPath.row]["person"] as! String)
        selectedComment = (wentDetail.wentDetail[indexPath.row]["comment"] as! String)
        
        // TODO: Imageに関して挿入できるようにする
        selectedURL = (wentDetail.wentDetail[indexPath.row]["imageURL"] as! String)
        
        selectedLanditude = (wentDetail.wentDetail[indexPath.row]["landitude"] as! Double)
        selectedLongitude = (wentDetail.wentDetail[indexPath.row]["longitude"] as! Double)
        
        // 遷移画面のインスタンス化
        let wesVC = wentShowViewController()
        
        // 渡す準備
        wesVC.selectedIndex = selectedIndex
        wesVC.selectedPlace = selectedPlace
        wesVC.selectedDate = selectedDate
        wesVC.selectedperson = selectedPerson
        wesVC.selectedcomment = selectedComment
        //        wesVC.selectedURL = selectedURL
        wesVC.selectedLanditude = selectedLanditude
        wesVC.selectedLongitude = selectedLongitude
        
        // データを渡す
        self.present(wesVC, animated: true, completion: nil)
    }
}
