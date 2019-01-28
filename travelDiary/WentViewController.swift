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
    
    // 各textfieldのインスタンス化
    let placeTextField = UITextView()
    let personTextField = UITextView()
    
    // textViewのインスタンス化
    let detailTextView = UITextView()
    
    // UIImageViewのインスタンス化
    var imageView = UIImageView()
    
    
    // インスタカメラロール
    var willPostImage:UIImage!
    
    // 写真選択ボタンのインスタンス化
    @IBOutlet weak var chooseBtn: UIButton!
    
    // 決定ボタンのインスタンス化
    @IBOutlet weak var decideBtn: UIButton!
    
    
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
        placeLabel.frame = CGRect(x: 20, y: 20, width: screenWidth - 40, height: 40)
        
        
        // 場所textプロパティ追加
        placeTextField.backgroundColor = .white
        placeTextField.frame = CGRect(x: 20, y: 62, width: screenWidth - 40, height: placeTextFieldHeight)
        placeTextField.font = UIFont.systemFont(ofSize: 20)
        
        // 日時labelプロパティ
        dateLabel.text = "日時"
        dateLabel.frame = CGRect(x: 20, y: placeTextFieldHeight + 67, width: screenWidth - 40, height: 40)
        
        // datePickerのプロパティ
        datePicker.frame = CGRect(x: 20, y: placeTextFieldHeight + 109, width: screenWidth - 40, height: datePickerViewHeight)
        datePicker.datePickerMode = .date
        
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
        
        
        
        imageView.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 250, width: screenWidth - 40, height: imageViewHeight)
        
        // イメージサイズごとにviewのサイズを変更する
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        // 写真追加のボタンのプロパティ
        chooseBtn.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 208, width: screenWidth - 60, height: 40)
        
        // 決定ボタンのプロパティ
        decideBtn.frame = CGRect(x: 110, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + imageViewHeight + 260, width: screenWidth - 200, height: 40)
        
        
        
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
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 340)
        
        
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
        
        // ビューに追加
        self.view.addSubview(scrollView)
        
        
    }
    
    //画面が現れる時に表示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShow(notification:)),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide(notification:)),name:UIResponder.keyboardWillHideNotification,object: nil)
    }
    
    
    // 写真選択のボタンが押されたら
    @IBAction func chooseBtn(_ sender: Any) {
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
    @IBAction func okBtn(_ sender: Any) {
        
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
        wentDetail.create(place: placeTextField.text, date: datePicker.date, person: personTextField.text, comment: detailTextView.text, imageURL: "path2")
        wentDetail.readAll()
        
        print(wentDetail.wentDetail)
        
        
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
        let insertHeight:CGFloat = 250
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + insertHeight)
        let offset = CGPoint(x: 0, y: insertHeight)
        scrollView.setContentOffset(offset, animated: true)
        print("スクリーンのサイズをキーボードの高さ分伸ばし伸ばした分動かす。")
    }
    
    //キーボードが閉じる時に呼ばれる
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 340)
        print("元の大きさへ")
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
    
    // 辞書型配列としてデータを登録
    var wentDetail = [NSDictionary]()
    
    // DBに登録する処理
    func create(place:String, date:Date, person:String, comment:String, imageURL:String){
        
        let realm = try!Realm()
        
        try! realm.write {
            
            // インスタンス化
            let wentDetail = WentDetail()
            wentDetail.place = place
            wentDetail.date = date
            wentDetail.person = person
            wentDetail.comment = comment
            wentDetail.imageURL = imageURL
            
            print(wentDetail)
            
            // レルムにデータを追加
            realm.add(wentDetail)
        }
    }
    
    // DBからデータを読み込む処理
    func readAll(){
        self.wentDetail = []
        
        let realm = try! Realm()
        let wentDetail = realm.objects(WentDetail.self)
        for value in wentDetail{
            let detail = ["place":value.place, "date":value.date, "person":value.person, "comment":value.comment, "imageURL":value.imageURL] as NSDictionary
            
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
