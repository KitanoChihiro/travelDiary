//
//  WentViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2018/12/18.
//  Copyright © 2018年 Chihiro Kitano. All rights reserved.
//

import UIKit

class WentViewController: UIViewController {

    
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
    let imageView = UIImageView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

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

        
        // プロパティ追加
        placeTextField.backgroundColor = .orange
        placeTextField.frame = CGRect(x: 20, y: 60, width: screenWidth - 40, height: 50)
        
        
        // 日時labelプロパティ
        dateLabel.text = "日時"
        dateLabel.frame = CGRect(x: 20, y: 110, width: screenWidth - 40, height: 40)
        
        
        datePicker.frame = CGRect(x: 20, y: 150, width: screenWidth - 40, height: 130)
        
        // 一緒に行った人labelプロパティ
        personLabel.text = "行った人"
        personLabel.frame = CGRect(x: 20, y: 260, width: screenWidth - 40, height: 40)
        
        // 一緒に行った人textFieldプロパティ
        personTextField.backgroundColor = .orange
        personTextField.frame = CGRect(x: 20, y: 300, width: screenWidth - 40, height: 50)
        
        // 詳細プロパティ
        detailLabel.text = "詳細"
        detailLabel.frame = CGRect(x: 20, y: 350, width: screenWidth - 40, height: 40)
        
        detailTextView.backgroundColor = .orange
        detailTextView.frame = CGRect(x: 20, y: 390, width: screenWidth - 40, height: 120)
        
        // イメージ追加プロパティ
        picLabel.text = "写真"
        picLabel.frame = CGRect(x: 20, y: 510, width: screenWidth - 40, height: 40)
        
        imageView.frame = CGRect(x: 20, y: 530, width: screenWidth - 40, height: 400)
        

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
        
        // UIScrollViewのコンテンツのサイズを指定
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 2)
        
        // ビューに追加
        self.view.addSubview(scrollView)
        
    }
    

}
