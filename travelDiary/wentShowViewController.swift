//
//  wentShowViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2018/12/29.
//  Copyright © 2018年 Chihiro Kitano. All rights reserved.
//

import UIKit
import MapKit

class wentShowViewController: UIViewController {
    // スクロールビューのデータを入れるための変数
    var scrollView:UIScrollView!
    // テーブルビューからデータを辞書型で受け取る
    var detail:NSDictionary!
    
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    var dateText:UITextField!
    
    // 各ラベルのインスタンス化
    let placeLabel = UILabel()
    let dateLabel = UILabel()
    let personLabel = UILabel()
    let detailLabel = UILabel()
    let picLabel = UILabel()
    
    // 各textfieldのインスタンス化
    let placeTextField = UITextView()
    let personTextField = UITextView()
    
    // textViewのインスタンス化
    let detailTextView = UITextView()
    
    // UIImageViewのインスタンス化
    let imageView = UIImageView()
    let mapView = MKMapView()
    
    // 前ページでこ送られてきたデータの型
    var selectedIndex = -1
    var selectedPlace:String!
    var selectedDate:String!
    var selectedperson:String!
    var selectedcomment:String!
    var selectedURL:String!
    var selectedLanditude:Double!
    var selectedLongitude:Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeTextFieldHeight:CGFloat = 50
        let datePickerViewHeight:CGFloat = 50
        let persontextfieldHeight:CGFloat = 50
        let detailTextViewHeight:CGFloat = 120
        let imageViewHeight:CGFloat = 400
        
        // UIScrollVIewのインスタンス化
        scrollView = UIScrollView()
        
        // datePickerのインスタンス化
        dateText = UITextField()

        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        // UIScrollViewのサイズと位置を設定
        scrollView.frame = CGRect(x:0,y:0,width: screenWidth, height: screenHeight)
        
        // 場所labelのプロパティ
        placeLabel.text = "場所"
        placeLabel.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: 40)
        
        
        // 場所textプロパティ追加
        placeTextField.backgroundColor = .white
        placeTextField.frame = CGRect(x: 20, y: 62, width: screenWidth - 40, height: placeTextFieldHeight)
        placeTextField.font = UIFont.systemFont(ofSize: 20)
        // テキストの入力を不可にする
        placeTextField.isEditable = false
        // 日時labelプロパティ
        dateLabel.text = "日付"
        dateLabel.frame = CGRect(x: 20, y: placeTextFieldHeight + 67, width: screenWidth - 40, height: 40)
        
        // dateのプロパティ
        dateText.frame = CGRect(x: 20, y: placeTextFieldHeight + 109, width: screenWidth - 40, height: datePickerViewHeight)
        dateText.backgroundColor = .white
        
        
        // 一緒に行った人labelプロパティ
        personLabel.text = "行った人"
        personLabel.frame = CGRect(x: 20, y: placeTextFieldHeight + datePickerViewHeight + 114, width: screenWidth - 40, height: 40)
        
        // 一緒に行った人textFieldプロパティ
        personTextField.backgroundColor = .white
        personTextField.frame = CGRect(x: 20, y: placeTextFieldHeight + datePickerViewHeight + 156, width: screenWidth - 40, height: persontextfieldHeight)
        personTextField.font = UIFont.systemFont(ofSize: 20)
        
        // 詳細ラベルプロパティ
        detailLabel.text = "詳細"
        detailLabel.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + 161, width: screenWidth - 40, height: 40)
        
        detailTextView.backgroundColor = .white
        detailTextView.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + 203, width: screenWidth - 40, height: detailTextViewHeight)
        detailTextView.font = UIFont.systemFont(ofSize: 20)
        
        
        // イメージ追加プロパティ
        picLabel.text = "写真"
        picLabel.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 208, width: screenWidth - 40, height: 40)
        
        
        imageView.backgroundColor = .white
        imageView.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 250, width: screenWidth - 40, height: imageViewHeight)
        
        mapView.frame = CGRect(x: 20, y: placeTextFieldHeight + datePickerViewHeight + persontextfieldHeight + detailTextViewHeight + imageViewHeight + 300, width: screenWidth - 40, height: 300)

        
        
        
        // 各オブジェクトをビューに追加
        scrollView.addSubview(placeLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(placeTextField)
        scrollView.addSubview(dateText)
        scrollView.addSubview(personLabel)
        scrollView.addSubview(personTextField)
        scrollView.addSubview(detailLabel)
        scrollView.addSubview(detailTextView)
        scrollView.addSubview(picLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(mapView)
        scrollView.backgroundColor = UIColor(hex: "FFE3A3")

        
        // UIScrollViewのコンテンツのサイズを指定
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 550)
        
        // ビューに追加
        self.view.addSubview(scrollView)
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
        backButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.leftItemsSupplementBackButton = true
    }
    
    @objc func back() {
        self.dismiss(animated: false, completion: nil)
    }
    
    //画面が現れる時に表示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShow(notification:)),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide(notification:)),name:UIResponder.keyboardWillHideNotification,object: nil)
        
        
        placeTextField.text = selectedPlace
        dateText.text = selectedDate
        personTextField.text = selectedperson
        detailTextView.text = selectedcomment
        
        resultLatitude = selectedLanditude
        resultLongitude = selectedLongitude
        
        // TODO:イメージビューを　StringからImageViewにする
        // 複数表示を可能にする
        // imageView.image = selectedURL
        // ピンをセットするファンクションの呼び出し
        setMapCenter()
        print("緯度:\(resultLatitude)")
        print("経度:\(resultLatitude)")
    }
    
    //画面が消える時に呼ばれる
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.removeObserver(self,name:UIResponder.keyboardWillHideNotification,object: nil)
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
        mapView.setRegion(region, animated: true)
        
        //ピンオブジェクトを作成
        let centerPin = MKPointAnnotation()
        
        //ピンの座標を設定
        centerPin.coordinate = coodinate
        
        //タイトル、サブタイトルを設定
        centerPin.title = placeTextField.text
        centerPin.subtitle = personTextField.text
        
        //ピンを地図上に追加
        mapView.addAnnotation(centerPin)
        
    }
}

//キーボード関連の関数をまとめる。
extension wentShowViewController{

    //キーボードが表示された時に呼ばれる
    @objc func keyboardWillShow(notification: NSNotification) {
        let insertHeight:CGFloat = 250
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + insertHeight)
        let offset = CGPoint(x: 0, y: insertHeight)
        scrollView.setContentOffset(offset, animated: true)
        
    }

    //キーボードが閉じる時に呼ばれる
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 340)
    }


    @objc func closeKeybord(_ sender:Any){
        self.view.endEditing(true)
    }
}

