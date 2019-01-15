//
//  WentViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2018/12/18.
//  Copyright © 2018年 Chihiro Kitano. All rights reserved.
//

import UIKit
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
        
        
        imageView.backgroundColor = .white
        imageView.frame = CGRect(x: 20, y: persontextfieldHeight + datePickerViewHeight + placeTextFieldHeight + detailTextViewHeight + 250, width: screenWidth - 40, height: imageViewHeight)
        
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
