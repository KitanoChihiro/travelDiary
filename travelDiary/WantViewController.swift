//
//  WantViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2018/12/20.
//  Copyright © 2018年 Chihiro Kitano. All rights reserved.
//

import UIKit
import RealmSwift
import YPImagePicker

class WantViewController: UIViewController {
    
    @IBOutlet weak var okBtn: UIButton!
    
    
    // スクロールビューのデータを入れるための変数
    var scrollView:UIScrollView!
    
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    // 各textのheightの変数
    var placetextHeight:CGFloat = 50
    var datePickerHeight:CGFloat = 100
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
    let datePicker = UIDatePicker()
    let purposeText = UITextView()
    let detailText = UITextView()
    let thingsText = UITextView()
    let budgetText = UITextField()
    let budget2Text = UITextField()
    
    
    
    
    

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
        placeText.frame = CGRect(x: 20, y: 62, width: screenWidth - 40, height: placetextHeight)
        placeText.font = UIFont.systemFont(ofSize: 20)
        
        // 日付プロパティ
        dateLabel.text = "日付"
        dateLabel.frame = CGRect(x: 20, y: placetextHeight + 67, width: screenWidth - 40, height: 40)
        
        datePicker.frame = CGRect(x: 20, y: placetextHeight + 109, width: screenWidth - 40, height: datePickerHeight)
        datePicker.datePickerMode = .date
        
        // 目的プロパティ
        purposeLabel.text = "目的"
        purposeLabel.frame = CGRect(x: 20, y: placetextHeight + datePickerHeight + 114, width: screenWidth - 40, height: 40)
        
        purposeText.backgroundColor = .white
        purposeText.frame = CGRect(x: 20, y: placetextHeight + datePickerHeight + 156, width: screenWidth - 40, height: purposeHeight)
        purposeText.font = UIFont.systemFont(ofSize: 20)
        // 詳細プロパティ
        detailLabel.text = "詳細"
        detailLabel.frame = CGRect(x: 20, y: placetextHeight + datePickerHeight + purposeHeight + 161, width: screenWidth - 40, height: 40)
        
        detailText.backgroundColor = .white
        detailText.frame = CGRect(x: 20, y: placetextHeight + datePickerHeight + purposeHeight + 203, width: screenWidth - 40, height: detailHeight)
        detailText.font = UIFont.systemFont(ofSize: 20)
        
        // 持ち物プロパティ
        thingsLabel.text = "持ち物"
        thingsLabel.frame = CGRect(x: 20, y: placetextHeight + datePickerHeight + purposeHeight + detailHeight + 208, width: screenWidth - 40 , height: 40)
        
        thingsText.backgroundColor = .white
        thingsText.frame = CGRect(x: 20, y: placetextHeight + datePickerHeight + purposeHeight + detailHeight + 250, width: screenWidth - 40, height: thingsHeight)
        thingsText.font = UIFont.systemFont(ofSize: 20)
        
        // 予算プロパティ
        budgetLabel.text = "予算"
        budgetLabel.frame = CGRect(x: 20, y: placetextHeight + datePickerHeight + purposeHeight + detailHeight + thingsHeight + 255, width: screenWidth - 40, height: 40)
        
        budgetText.backgroundColor = .white
        budgetText.frame = CGRect(x: 20, y: placetextHeight + datePickerHeight + purposeHeight + detailHeight + thingsHeight + 297, width: screenWidth - 280, height: budgetHeight)
        budgetText.font = UIFont.systemFont(ofSize: 20)
        
        budget2Text.backgroundColor = .white
        budget2Text.frame = CGRect(x: 230, y: placetextHeight + datePickerHeight + purposeHeight + detailHeight + thingsHeight + 297, width: screenWidth - 280, height: budgetHeight)
        budgetText.font = UIFont.systemFont(ofSize: 20)
        
        // 円のプロパティ
        yenFirstLabel.text = "円　〜"
        yenFirstLabel.frame = CGRect(x: 160, y: placetextHeight + datePickerHeight + purposeHeight + detailHeight + thingsHeight + 297, width: screenWidth - 280, height: budgetHeight)
        
        yenLastLabel.text = "円"
        yenLastLabel.frame = CGRect(x: 370, y: placetextHeight + datePickerHeight + purposeHeight + detailHeight + thingsHeight + 297, width: screenWidth - 280, height: budgetHeight)
        
        // 決定ボタンのプロパティ
        okBtn.frame = CGRect(x: 160, y: placetextHeight + datePickerHeight + purposeHeight + detailHeight + thingsHeight + 357, width: screenWidth - 320, height: 40)
        
       
        
        // ビューに追加
        scrollView.addSubview(placeLabel)
        scrollView.addSubview(placeText)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(datePicker)
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
        scrollView.addSubview(okBtn)
        
        
        // UIScrollViewのコンテンツのサイズを指定
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 200)
        
        // ビューに追加
        self.view.addSubview(scrollView)
        
    }
    
    //画面が現れる時に表示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShow(notification:)),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide(notification:)),name:UIResponder.keyboardWillHideNotification,object: nil)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        
        // DB関数の呼び出し
        let wantDetail = WantDetail()
        
        
        // DBへのよ登録処理の関数の呼び出し
        wantDetail.create(place: placeText.text!, date: datePicker.date, purpose: purposeText.text, comment: detailText.text, things: thingsText.text, mLess: budgetText.text!, mUpper: budget2Text.text!)
        // DBからデータを取得して呼び出す処理
        wantDetail.readAll()
        
        print(wantDetail.wantDetail)
        print("ボタン押した")
        
    }
}





//キーボード関連の関数をまとめる。
extension WantViewController{
    
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

class WantDetail: Object{
    @objc dynamic var place = String()
    @objc dynamic var date = Date()
    @objc dynamic var purpose = String()
    @objc dynamic var comment = String()
    @objc dynamic var things = String()
    @objc dynamic var mLess = String()
    @objc dynamic var mUpper = String()
    
    // 辞書型配列としてデータを登録
    var wantDetail = [NSDictionary]()
    
    // DBに登録する
    func create(place:String, date:Date, purpose:String, comment:String, things:String, mLess:String, mUpper:String){
        
        let realm = try!Realm()
        
        try! realm.write {
            
            // インスタンス化
            let wantDetail = WantDetail()
            wantDetail.place = place
            wantDetail.date = date
            wantDetail.purpose = purpose
            wantDetail.comment = comment
            wantDetail.things = things
            wantDetail.mLess = mLess
            wantDetail.mUpper = mUpper
            
            print(wantDetail)
            
            // レルムにデータを追加
            realm.add(wantDetail)
        }
    }
    
    // DBからデータを読み込んで取得する
    func readAll(){
        self.wantDetail = []
        
        let realm = try! Realm()
        let wantDetail = realm.objects(WantDetail.self)
        for value in wantDetail{
            let detail = ["place": value.place, "date": value.date, "purpose": value.purpose, "comment": value.comment, "things": value.things, "mLess": value.mLess, "mUpper": value.mUpper] as NSDictionary

            self.wantDetail.append(detail)
        }
    }
    
    // DBから全件消去する
    func deleteAll(){
        let realm = try! Realm()
        try! realm.write(){
            realm.delete(realm.objects(WantDetail.self))
        }
    }
}

