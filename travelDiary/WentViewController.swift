//
//  WentViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2018/12/18.
//  Copyright © 2018年 Chihiro Kitano. All rights reserved.
//

import UIKit
import RealmSwift
import YPImagePicker


class WentViewController: UIViewController , UITextFieldDelegate{
    
    
    // スクロールビューのデータを入れるための変数
    var scrollView:UIScrollView!
    
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    var datePicker:UIDatePicker!
    
    // 各ラベルのインスタンス化
    let placeLabel = UILabel()
    let dateLabel = UILabel()
    let personLabel = UILabel()
    let detailLabel = UILabel()
    let picLabel = UILabel()
    let chooseBtn = UIButton()
    let decideBtn = UIButton()
    let searchPlace = UIButton()
    
    // 各textfieldのインスタンス化
    let placeTextField = UITextView()
    let personTextField = UITextView()
    
    // textViewのインスタンス化
    let detailTextView = UITextView()
    
    // UIImageViewのインスタンス化
    var imageView = UIImageView()
    var leftImageView = UIImageView()
    var rightImageView = UIImageView()
    
    
    // インスタカメラロール
    var willPostImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let placeTextFieldHeight:CGFloat = 50
        let datePickerViewHeight:CGFloat = 130
        let persontextfieldHeight:CGFloat = 50
        let detailTextViewHeight:CGFloat = 120
        let imageViewHeight:CGFloat = 400
        
        
        
        // UIScrollVIewのインスタンス化
        scrollView = UIScrollView()
        
        // datePickerのインスタンス化
        datePicker = UIDatePicker()
        
        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        // UIScrollViewのサイズと位置を設定
        scrollView.frame = CGRect(x:0,y:0,width: screenWidth, height: screenHeight)
        
        // 場所labelのプロパティ
        placeLabel.text = "場所"
        placeLabel.frame = CGRect(x: 20, y: 80, width: screenWidth - 40, height: 40)
        
        
        // 場所textプロパティ追加
        placeTextField.backgroundColor = .white
        placeTextField.frame = CGRect(x: 20, y: 122, width: screenWidth - 40, height: placeTextFieldHeight)
        placeTextField.font = UIFont.systemFont(ofSize: 20)
        
        // 日時labelプロパティ
        dateLabel.text = "日付"
        dateLabel.frame = CGRect(x: 20, y: placeTextFieldHeight + 127, width: screenWidth - 40, height: 40)
        
        // datePickerのプロパティ
        datePicker.frame = CGRect(x: 20, y: placeTextFieldHeight + 159, width: screenWidth - 40, height: datePickerViewHeight)
        datePicker.datePickerMode = .date
        
        // 一緒に行った人labelプロパティ
        personLabel.text = "行った人"
        personLabel.frame = CGRect(x: 20, y: placeTextFieldHeight + datePickerViewHeight + 164, width: screenWidth - 40, height: 40)
        
        // 一緒に行った人textFieldプロパティ
        personTextField.backgroundColor = .white
        personTextField.frame = CGRect(x: 20, y: placeTextFieldHeight + datePickerViewHeight + 206, width: screenWidth - 40, height: persontextfieldHeight)
        personTextField.font = UIFont.systemFont(ofSize: 20)
        
        // 詳細ラベルプロパティ
        detailLabel.text = "詳細"
        detailLabel.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + 211, width: screenWidth - 40, height: 40)
        
        detailTextView.backgroundColor = .white
        detailTextView.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + 253, width: screenWidth - 40, height: detailTextViewHeight)
        detailTextView.font = UIFont.systemFont(ofSize: 20)
        
        
        // イメージ追加プロパティ
        picLabel.text = "写真"
        picLabel.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 258, width: screenWidth - 40, height: 40)
        
        
        
        imageView.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 300, width: screenWidth - 40, height: imageViewHeight)
        
        leftImageView.frame = CGRect(x: -100, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 300, width: screenWidth - 40, height: imageViewHeight)
        
        imageView.backgroundColor = .white
        leftImageView.backgroundColor = .white
        rightImageView.backgroundColor = .white
        
        
        
        // イメージサイズごとにviewのサイズを変更する
        imageView.contentMode = UIView.ContentMode.scaleAspectFit

        // 写真追加のボタンのプロパティ
        chooseBtn.frame = CGRect(x: 60, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 258, width: screenWidth - 320, height: 40)
        // ボタンのファンクションの追加(YPImagePickerの追加)
        chooseBtn.addTarget(self, action: #selector(chooseBtn(_:)), for: .touchUpInside)
        chooseBtn.image("スクリーンショット 2019-02-05 20.03.28.png")
        
        // 決定ボタンのプロパティ
        decideBtn.frame = CGRect(x: 150, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + imageViewHeight + 310, width: screenWidth - 300, height: 40)
        decideBtn.image("スクリーンショット 2019-02-07 1.34.02.png")
        // 決定ボタンのファンクション追加（DBに登録処理）
        decideBtn.addTarget(self, action: #selector(okBtn(_:)), for: .touchUpInside)
        
        
        // 各オブジェクトをビューに追加
        scrollView.addSubview(placeLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(placeTextField)
        scrollView.addSubview(datePicker)
        scrollView.addSubview(personLabel)
        scrollView.addSubview(personTextField)
        scrollView.addSubview(detailLabel)
        scrollView.addSubview(detailTextView)
        scrollView.addSubview(picLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(chooseBtn)
        scrollView.addSubview(decideBtn)
        scrollView.backgroundColor = UIColor(hex: "FFE3A3")
        
        // UIScrollViewのコンテンツのサイズを指定
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 520)
        
        
        // インスタライクなカメラロール
        //ナビゲーションバーの背景画像
        let coloredImage = UIImage(named:"backImage.jpg")
        UINavigationBar.appearance().setBackgroundImage(coloredImage, for: UIBarMetrics.default)
        
        //ナビゲーションバーのTextColor
        //タイトル
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white ]
        //左のボタン
        UINavigationBar.appearance().tintColor = .white
        
        //ImagePickerの設定
        YPImagePickerConfiguration()
        
        // searchPlaceの設定
        searchPlace.addTarget(self, action: #selector(WentViewController.goNext(_:)), for: .touchUpInside)
        searchPlace.image("スクリーンショット 2019-02-05 20.03.27.png")
        searchPlace.frame = CGRect(x: 60, y: 80, width: screenWidth - 320, height: 40)
        
        // ビューに追加
        self.view.addSubview(scrollView)
        scrollView.addSubview(searchPlace)
        
    }
    
    //    // サーチボタンの設定
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //    }
    // サーチボタンを押したらジオコーディングの画面に遷移する
    @objc func goNext(_ sender: UIButton) {
        // selectorで呼び出す場合Swift4からは「@objc」をつける。
        let gcVC = geocordingViewController()
        self.present(gcVC, animated: true, completion: nil)
    }
    
    //画面が現れる時に表示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 場所の検索してから入力画面に値を渡す
        placeTextField.text = resultPlace
        print(resultLatitude)
        print(resultLongitude)
    }

    
    // 写真選択のボタンが押されたら
    @objc func chooseBtn(_ sender: UIButton) {
        let picker = YPImagePicker()
        var image:UIImage!
        
        YPImagePickerConfig()
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            for item in items {
                switch item {
                case .photo(let photo):
                    print("phote",photo.image)
                    image = photo.image
                case .video(let video):
                    print("video",video)
                }
            }
            
            
            if cancelled {
                //「cansel」ボタンが押された時の処理
                picker.dismiss(animated: true, completion: nil)
                
            }else{
                //「Next」ボタンが押された時の処理
                print("memo:次の画面に遷移します。")
                self.imageView.image = image
                // ピッカーを閉じる処理
                picker.dismiss(animated: true, completion: nil)
            }
            //            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //インスタ風ImagePickerの設定
    func YPImagePickerConfig(){
        var config = YPImagePickerConfiguration()
        let picker = YPImagePicker(configuration: config)
        
        
        // ナビゲーションバーのカラーの変更[タイトル・キャンセルボタン]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black ] // Title color
        UINavigationBar.appearance().tintColor = .blue // Left. bar buttons
        
        //ライブラリの写真を表示する際、1行に何枚写真を並べるか。
        config.library.numberOfItemsInRow = 5
        //どのスクリーンを最初に表示するか。
        config.startOnScreen = .library
        //ステータスバーを隠すかどうか
        config.hidesStatusBar = false
        //ナビゲーションの右側のボタン「Next」
        config.colors.tintColor = .blue
        // 一回の選択で選べる枚数の制限
//        config.library.maxNumberOfItems = 20
        // 下のバーカメラとライブラリの選択を隠す
        config.hidesBottomBar = true
        // カメラモードオフ
        config.screens = [.library]
        // フィルターなし
        config.showsFilters = false
        //上記設定
        YPImagePickerConfiguration.shared = config
    }
    
    @objc func okBtn(_ sender: Any) {
        
        let imageNsData = self.imageView.image!.jpegData(compressionQuality: 0.1)
        
        // DB関数の呼び出し
        let wentDetail = WentDetail()
        
        // データの書き込み
        wentDetail.create(place: placeTextField.text, date: datePicker.date, person: personTextField.text, comment: detailTextView.text, imageName: "path2", landitude: resultLatitude, longitude: resultLongitude, created: Date(), imageData: imageNsData!)
        // DB関係の関数呼び出し
        wentDetail.readAll()
        
        //部品のアラートを作る
        let alertController = UIAlertController(title: "登録完了！", message: "ホーム画面に戻ります！", preferredStyle: UIAlertController.Style.alert)
        //ちなみにUIAlertControllerStyle.alertをactionsheetに変えると下からにょきっと出てくるやつになるよ
        
        //OKボタン追加
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
            //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移するようにしてる
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // 0.5秒後に実行したい処理
                // tabで繊維先を指定している
                if let tabvc = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController  {
                    tabvc.selectedIndex = 1
                }
            }
        }
        )
        
        alertController.addAction(okAction)
        //アラートを表示する
        present(alertController, animated: true, completion: nil)
        
        print("結果\(resultLatitude)")
        print("結果\(resultLongitude)")
    }
}


//UIScrollViewの拡張
extension UIScrollView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
        print("touchesBegan")
    }
}




class WentDetail: Object {
    @objc dynamic var place = String()
    @objc dynamic var date = Date()
    @objc dynamic var person = String()
    @objc dynamic var comment = String()
    @objc dynamic var imageName = ""
    @objc dynamic var landitude = Double()
    @objc dynamic var longitude = Double()
    @objc dynamic var created:Date = Date()
    @objc dynamic var imageData: Data? = nil
    
    // 辞書型配列としてデータを登録
    var wentDetail = [NSDictionary]()
    
    // DBに登録する処理
    func create(place:String, date:Date, person:String, comment:String, imageName:String, landitude:Double, longitude:Double, created:Date, imageData: Data){
        
        let realm = try!Realm()
        
        try! realm.write {
            
            // インスタンス化
            let wentDetail = WentDetail()
            
            wentDetail.place = place
            wentDetail.date = date
            wentDetail.person = person
            wentDetail.comment = comment
            wentDetail.imageName = imageName
            wentDetail.landitude = landitude
            wentDetail.longitude = longitude
            wentDetail.created = created
            wentDetail.imageData = imageData
            
            print(wentDetail)
            
            // レルムにデータを追加
            realm.add(wentDetail)
        }
    }
    
    // DBのデータを一件消去する処理
    func delete(created:Date) {
        let realm = try! Realm()
        let results = realm.objects(WentDetail.self).filter("created == %", created)

        // (3)データの削除
        try! realm.write {
            realm.delete(results)
        }

    }
    
    
    // DBからデータを読み込む処理
    func readAll(){
        self.wentDetail = []
        
        
        let realm = try! Realm()
        var wentDetail = realm.objects(WentDetail.self)
        // ascending true→古いもの順　false→新しいもの順
        wentDetail = wentDetail.sorted(byKeyPath: "created", ascending: false)
        
        for value in wentDetail{
            let detail = ["place":value.place, "date":value.date, "person":value.person, "comment":value.comment, "imageName":value.imageName, "landitude":value.landitude, "longitude":value.longitude, "created":value.created,  "imageData":value.imageData] as NSDictionary
            
            self.wentDetail.append(detail)
        }
    }
    
    // DBから全件消去する
    func deleteAll(){
        let realm = try! Realm()
        try! realm.write(){
            realm.delete(realm.objects(WentDetail.self))
        }
    }
}

