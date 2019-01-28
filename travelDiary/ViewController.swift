//
//  ViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2018/12/18.
//  Copyright © 2018年 Chihiro Kitano. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var resultMap:MKMapView!
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!

    // ボタン
    @IBOutlet weak var wantBtn: UIButton!
    @IBOutlet weak var wentBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultMap = MKMapView()
        
        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        // mapkitのぴプロパティ
        resultMap.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        wantBtn.frame = CGRect(x: 300, y: 550, width: 100, height: 40)
        wentBtn.frame = CGRect(x: 300, y: 600, width: 100, height: 40)
        
        // ビューに追加の処理
        view.addSubview(resultMap)
        resultMap.addSubview(wantBtn)
        resultMap.addSubview(wentBtn)
        view.backgroundColor = UIColor(hex: "FFE3A3")
    }


}

