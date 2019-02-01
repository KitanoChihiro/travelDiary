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
        placeLabel.frame = CGRect(x: 20, y: 70, width: screenWidth - 40, height: 40)
        
        
        // 場所textプロパティ追加
        placeTextField.backgroundColor = .white
        placeTextField.frame = CGRect(x: 20, y: 112, width: screenWidth - 40, height: placeTextFieldHeight)
        placeTextField.font = UIFont.systemFont(ofSize: 20)
        
        // 日時labelプロパティ
        dateLabel.text = "日時"
        dateLabel.frame = CGRect(x: 20, y: placeTextFieldHeight + 117, width: screenWidth - 40, height: 40)
        
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
        
        // イメージサイズごとにviewのサイズを変更する
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        // 写真追加のボタンのプロパティ
        chooseBtn.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 258, width: screenWidth - 60, height: 40)
        // ボタンのファンクションの追加(YPImagePickerの追加)
        chooseBtn.addTarget(self, action: #selector(chooseBtn(_:)), for: .touchUpInside)
        chooseBtn.setTitle("写真の追加する", for: .normal)
        
        // 決定ボタンのプロパティ
        decideBtn.frame = CGRect(x: 110, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + imageViewHeight + 310, width: screenWidth - 200, height: 40)
        decideBtn.setTitle("登録！！", for: .normal)
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
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 490)
        
        
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
        searchPlace.setTitle("場所を検索する", for: .normal)
        searchPlace.frame = CGRect(x: 100, y: 70, width: screenWidth - 300, height: 40)
        
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
        
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShow(notification:)),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide(notification:)),name:UIResponder.keyboardWillHideNotification,object: nil)
        
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
        config.library.maxNumberOfItems = 20
        //上記設定
        YPImagePickerConfiguration.shared = config
        
    }
    @objc func okBtn(_ sender: Any) {
        
        // 選択した画像と名前の配列を作る

        // ↓この関数をfor文で、回す
        //保存する用のパス
        //        let path = "file://" + fileInDocumentsDirectory(filename: "")
        //        let result = saveImage(image: UIImage(named: "togamin.JPG")!, path: path)
        //        //
        //        //        //読み取る用のパス
        //        let path2 = fileInDocumentsDirectory(filename: "togamin")
        //        print("memo:",result)
        //        let image = loadImageFromPath(path: path2)
        //        print("memo:image",image!)
        //        imageView.image = image
        
        
        // DB関数の呼び出し
        let wentDetail = WentDetail()
        
        // データの書き込み
        wentDetail.create(place: placeTextField.text, date: datePicker.date, person: personTextField.text, comment: detailTextView.text, imageURL: "path2", landitude: resultLatitude, longitude: resultLongitude, created: Date())
        // DB関係の関数呼び出し
        wentDetail.readAll()
        
        //部品のアラートを作る
        let alertController = UIAlertController(title: "e.g.こんにちは", message: "e.g.日本語だよ", preferredStyle: UIAlertController.Style.alert)
        //ちなみにUIAlertControllerStyle.alertをactionsheetに変えると下からにょきっと出てくるやつになるよ
        
        //OKボタン追加
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{(action: UIAlertAction!) in
            self.tabBarController?.selectedIndex = 1
            //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移するようにしてる
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                // 0.5秒後に実行したい処理
//                let storyboard: UIStoryboard = self.storyboard!
//                let nextView = storyboard.instantiateViewController(withIdentifier: "homeVC")
//                self.present(nextView, animated: true, completion: nil)
//            }
        }
        )
        
        alertController.addAction(okAction)
        
        //アラートを表示する
        present(alertController, animated: true, completion: nil)
        

        
        print("結果\(resultLatitude)")
        print("結果\(resultLongitude)")
    }
    func myMessage(){
        self.dismiss(animated: true, completion: nil)
        print("戻ります")
    }
}


//UIScrollViewの拡張
extension UIScrollView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
        print("touchesBegan")
    }
}

//キーボード関連の関数をまとめる。
extension WentViewController{
    
    //キーボードが表示された時に呼ばれる
    @objc func keyboardWillShow(notification: NSNotification) {
        let insertHeight:CGFloat = 260
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + insertHeight)
        let offset = CGPoint(x: 0, y: insertHeight)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    //キーボードが閉じる時に呼ばれる
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 260)
        
    }
    
    
    @objc func closeKeybord(_ sender:Any){
        self.view.endEditing(true)
    }
}

//画像をパスで保存するための関数
extension ViewController{
    //画像を保存するためのPathを生成
    func getDocumentsURL()->NSURL{
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        print("memo:",documentsURL)
        return documentsURL! as NSURL
    }
    //Pathの最後に画像の名前を追加
    func fileInDocumentsDirectory(filename: String)->String{
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        print("memo:",fileURL!)
        return fileURL!.path
    }
    //画像の保存
    func saveImage(image: UIImage, path: String)->Bool{
        let pngImageData = image.pngData()
        print("memo:path",path)
        do {
            try pngImageData!.write(to: URL(string: path)!, options: .atomic)
        }catch{
            print("memo:saveImage error is \(error)")
            return false
        }
        return true
    }
    //画像のロード
    func loadImageFromPath(path: String)->UIImage?{
        print("memo:画像のロード",path)
        let image = UIImage(contentsOfFile: path)
        if image == nil{
            print("missing image at: \(path)")
        }
        return image
    }
}



class WentDetail: Object {
    @objc dynamic var place = String()
    @objc dynamic var date = Date()
    @objc dynamic var person = String()
    @objc dynamic var comment = String()
    @objc dynamic var imageURL = String()
    @objc dynamic var landitude = Double()
    @objc dynamic var longitude = Double()
    @objc dynamic var created:Date = Date()
    
    // 辞書型配列としてデータを登録
    var wentDetail = [NSDictionary]()
    
    // DBに登録する処理
    func create(place:String, date:Date, person:String, comment:String, imageURL:String, landitude:Double, longitude:Double, created:Date){
        
        let realm = try!Realm()
        
        try! realm.write {
            
            // インスタンス化
            let wentDetail = WentDetail()
            wentDetail.place = place
            wentDetail.date = date
            wentDetail.person = person
            wentDetail.comment = comment
            wentDetail.imageURL = imageURL
            wentDetail.landitude = landitude
            wentDetail.longitude = longitude
            wentDetail.created = created
            
            print(wentDetail)
            
            // レルムにデータを追加
            realm.add(wentDetail)
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
            let detail = ["place":value.place, "date":value.date, "person":value.person, "comment":value.comment, "imageURL":value.imageURL, "landitude":value.landitude, "longitude":value.longitude, "created":value.created] as NSDictionary
            
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
