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
    
    // WantShowViewController用
    var selectedIndex = -1
    var selectedPlace:String!
    var selectedDate:String!
    var selectedPurpose:String!
    var selectedComment:String!
    var selectedThings:String!
    var selecetdBuget:String!
    var selectedBuget2:String!
    var selectedLanditude:Double!
    var selectedLongitude:Double!
    
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
    
    // 何件表示するか
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wantDetail.wantDetail.count
    }
    
    
    // セルの内容を決める
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // カスタムセルのインスタンス化
        var cell = WantTableCellTableViewCell()
        
        cell.customCell()
        
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
    
    
    
    // セルが選択された時に行う処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(indexPath.row)行目選択")

        // セグエが選択されたときにどのデータをとってくるかの指定
        // (今選択されているパスの指定)
        selectedIndex = indexPath.row
        selectedPlace = (wantDetail.wantDetail[indexPath.row]["place"] as! String)
        
        // DatePickerのDate型からストリング型に変換する
        let changeDate = stringFromDate(date: wantDetail.wantDetail[indexPath.row]["date"] as! Date, format: "yyyy年MM月dd日")
        
        selectedDate = changeDate
        
        selectedPurpose = (wantDetail.wantDetail[indexPath.row]["purpose"] as! String)
        selectedComment = (wantDetail.wantDetail[indexPath.row]["comment"] as! String)
        selectedThings = (wantDetail.wantDetail[indexPath.row]["things"] as! String)
        selecetdBuget = (wantDetail.wantDetail[indexPath.row]["mLess"] as! String)
        selectedBuget2 = (wantDetail.wantDetail[indexPath.row]["mUpper"] as! String)
        selectedLanditude = (wantDetail.wantDetail[indexPath.row]["landitude"] as! Double)
        selectedLongitude = (wantDetail.wantDetail[indexPath.row]["longitude"] as! Double)
        
        
        // 画面遷移のインスタンス化
        let wsVC = WantShowViewController()
        
        // 渡す情報準備
        wsVC.selectedIndex = selectedIndex
        wsVC.selectedPlace = selectedPlace
        wsVC.selectedDate = selectedDate
        wsVC.selectedPurpose = selectedPurpose
        wsVC.selectedComment = selectedComment
        wsVC.selectedThings = selectedThings
        wsVC.selecetdBuget = selecetdBuget
        wsVC.selectedBuget2 = selectedBuget2
        wsVC.selectedLanditude = selectedLanditude
        wsVC.selectedLongitude = selectedLongitude
        
        let nextViewController = UINavigationController(rootViewController: wsVC)
        
        // データを渡す
        self.present(nextViewController, animated: true, completion: nil)
    }
    // セルをスライドして消去する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        wantDetail.wantDetail.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
