//
//  WantShowViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2019/01/17.
//  Copyright © 2019年 Chihiro Kitano. All rights reserved.
//

import UIKit
import MapKit

class WantShowViewController: UIViewController {
    
    var scrollView:UIScrollView!
    
    // テーブルビューからのデータを辞書型で受け取る
    var detail:NSDictionary!
    
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    // 各textのheightの変数
    var placeHeight:CGFloat = 50
    var dateHeight:CGFloat = 50
    var purposeHeight:CGFloat = 50
    var detailHeight:CGFloat = 150
    var thingsHeight:CGFloat = 150
    var budgetHeight:CGFloat = 45
    
    // 各ラベルのインスタンス化
    let placeLabel = UILabel()
    let dateLabel = UILabel()
    let purposeLabel = UILabel()
    let detailLabel = UILabel()
    let thingsLabel = UILabel()
    let budgetLabel = UILabel()
    let yenFirstLabel = UILabel()
    let yenLastLabel = UILabel()
    
    // 各text系のインスタンス化
    let placeText = UITextField()
    let dateText = UITextField()
    let purposeText = UITextView()
    let detailText = UITextView()
    let thingsText = UITextView()
    let budgetText = UITextField()
    let budget2Text = UITextField()
    
    let map = MKMapView()
    
    
    // 前ページで送られてきたデータの型
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIScrollVIewのインスタンス化
        scrollView = UIScrollView()

        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        // UIScrollViewのサイズと位置を設定
        scrollView.frame = CGRect(x:0,y:0,width: screenWidth, height: screenHeight)
        
        // 場所プロパティ
        placeLabel.text = "場所"
        placeLabel.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: 40)
        
        placeText.backgroundColor = .white
        placeText.frame = CGRect(x: 20, y: 62, width: screenWidth - 40, height: placeHeight)
        placeText.font = UIFont.systemFont(ofSize: 20)
        
        // 日付プロパティ
        dateLabel.text = "日付"
        dateLabel.frame = CGRect(x: 20, y: placeHeight + 67, width: screenWidth - 40, height: 40)
        
        dateText.backgroundColor = .white
        dateText.frame = CGRect(x: 20, y: placeHeight + 109, width: screenWidth - 40, height: dateHeight)
        
        // 目的プロパティ
        purposeLabel.text = "目的"
        purposeLabel.frame = CGRect(x: 20, y: placeHeight + dateHeight + 114, width: screenWidth - 40, height: 40)
        
        purposeText.backgroundColor = .white
        purposeText.frame = CGRect(x: 20, y: placeHeight + dateHeight + 156, width: screenWidth - 40, height: purposeHeight)
        purposeText.font = UIFont.systemFont(ofSize: 20)
        
        
        // 詳細プロパティ
        detailLabel.text = "詳細"
        detailLabel.frame = CGRect(x: 20, y: placeHeight + dateHeight + purposeHeight + 161, width: screenWidth - 40, height: 40)
        
        detailText.backgroundColor = .white
        detailText.frame = CGRect(x: 20, y: placeHeight + dateHeight + purposeHeight + 203, width: screenWidth - 40, height: detailHeight)
        detailText.font = UIFont.systemFont(ofSize: 20)
        
        // 持ち物プロパティ
        thingsLabel.text = "持ち物"
        thingsLabel.frame = CGRect(x: 20, y: placeHeight + dateHeight + purposeHeight + detailHeight + 208, width: screenWidth - 40 , height: 40)
        
        thingsText.backgroundColor = .white
        thingsText.frame = CGRect(x: 20, y: placeHeight + dateHeight + purposeHeight + detailHeight + 250, width: screenWidth - 40, height: thingsHeight)
        thingsText.font = UIFont.systemFont(ofSize: 20)
        
        // 予算プロパティ
        budgetLabel.text = "予算"
        budgetLabel.frame = CGRect(x: 20, y: placeHeight + dateHeight + purposeHeight + detailHeight + thingsHeight + 255, width: screenWidth - 40, height: 40)
        
        budgetText.backgroundColor = .white
        budgetText.frame = CGRect(x: 20, y: placeHeight + dateHeight + purposeHeight + detailHeight + thingsHeight + 297, width: screenWidth - 280, height: budgetHeight)
        budgetText.font = UIFont.systemFont(ofSize: 20)
        
        budget2Text.backgroundColor = .white
        budget2Text.frame = CGRect(x: 230, y: placeHeight + dateHeight + purposeHeight + detailHeight + thingsHeight + 297, width: screenWidth - 280, height: budgetHeight)
        budgetText.font = UIFont.systemFont(ofSize: 20)
        
        // 円のプロパティ
        yenFirstLabel.text = "円　〜"
        yenFirstLabel.frame = CGRect(x: 160, y: placeHeight + dateHeight + purposeHeight + detailHeight + thingsHeight + 297, width: screenWidth - 280, height: budgetHeight)
        
        yenLastLabel.text = "円"
        yenLastLabel.frame = CGRect(x: 370, y: placeHeight + dateHeight + purposeHeight + detailHeight + thingsHeight + 297, width: screenWidth - 280, height: budgetHeight)
        
        map.frame = CGRect(x: 20, y: placeHeight + dateHeight + purposeHeight + detailHeight + thingsHeight + 400, width: screenWidth - 40, height: 300)
        
        // ビューに追加
        scrollView.addSubview(placeLabel)
        scrollView.addSubview(placeText)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(dateText)
        scrollView.addSubview(purposeLabel)
        scrollView.addSubview(purposeText)
        scrollView.addSubview(detailLabel)
        scrollView.addSubview(detailText)
        scrollView.addSubview(thingsLabel)
        scrollView.addSubview(thingsText)
        scrollView.addSubview(budgetLabel)
        scrollView.addSubview(budgetText)
        scrollView.addSubview(yenFirstLabel)
        scrollView.addSubview(budget2Text)
        scrollView.addSubview(yenLastLabel)
        scrollView.addSubview(map)
        scrollView.backgroundColor = UIColor(hex: "FFE3A3")
        
        // UIScrollViewのコンテンツのサイズを指定
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 450)
        
        // ビューに追加
        self.view.addSubview(scrollView)

    }
    
    //画面が現れる時に表示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShow(notification:)),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide(notification:)),name:UIResponder.keyboardWillHideNotification,object: nil)

        // セグエを通って表示させるもの
        placeText.text = selectedPlace
        dateText.text = selectedDate
        purposeText.text = selectedPurpose
        detailText.text = selectedComment
        thingsText.text = selectedThings
        budgetText.text = selecetdBuget
        budget2Text.text = selectedBuget2
        resultLatitude = selectedLanditude
        resultLongitude = selectedLongitude
        // mapにピンをさす関数
        setMapCenter()
        
    }
    
    //検索結果をもとに地図中央にピンをセット
    func setMapCenter(){
        //中心となる場所（検索ワード）の座標オブジェクトを作成
        let coodinate = CLLocationCoordinate2DMake(selectedLanditude, selectedLongitude)
        
        //縮尺を設定
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        //範囲オブジェクトを作成
        let region = MKCoordinateRegion(center: coodinate, span: span)
        
        //MapViewに範囲オブジェクトを設置
        map.setRegion(region, animated: true)
        
        //ピンオブジェクトを作成
        let centerPin = MKPointAnnotation()
        
        //ピンの座標を設定
        centerPin.coordinate = coodinate
        
        //タイトル、サブタイトルを設定
        centerPin.title = placeText.text
        centerPin.subtitle = purposeText.text
        
        //ピンを地図上に追加
        map.addAnnotation(centerPin)
        
    }
}

extension WantShowViewController{

    //キーボードが表示された時に呼ばれる
    @objc func keyboardWillShow(notification: NSNotification) {
        let insertHeight:CGFloat = 380
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + insertHeight)
        let offset = CGPoint(x: 0, y: insertHeight)
        scrollView.setContentOffset(offset, animated: true)
        print("スクリーンのサイズをキーボードの高さ分伸ばし伸ばした分動かす。")
    }

    //キーボードが閉じる時に呼ばれる
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 200)
        print("元の大きさへ")
    }


    @objc func closeKeybord(_ sender:Any){
        self.view.endEditing(true)
    }

}
