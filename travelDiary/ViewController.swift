//
//  ViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2018/12/18.
//  Copyright © 2018年 Chihiro Kitano. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class ViewController: UIViewController, MKMapViewDelegate {
    
    var resultMap:MKMapView!
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!

    
    // データベースの変数
    let wantDetail = WantDetail()
    let wentDetail = WentDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        resultMap = MKMapView()
        resultMap.delegate = self
        
        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        // mapkitのぴプロパティ
        resultMap.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

        
        // ビューに追加の処理
        view.addSubview(resultMap)
        
        view.backgroundColor = UIColor(hex: "FFE3A3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // DBを呼び出して、情報を読み込む
        wantDetail.readAll()
        wentDetail.readAll()
        print(wantDetail.wantDetail)
        setPins(details: wentDetail.wentDetail)
        setPins(details: wantDetail.wantDetail)
        
    }
    
    // 取ってきたデータからピンをおくファンクション
    func setPins(details: [NSDictionary]){
        for detail in details{
            print("details")
            
            var annotation = MKPointAnnotation()
            let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(detail.object(forKey: "landitude") as! CLLocationDegrees, detail.object(forKey: "longitude") as! CLLocationDegrees)
                    annotation.coordinate = location
                    annotation.title = detail.object(forKey: "place") as! String
                    annotation.subtitle = detail.object(forKey: "comment") as! String
            
                    resultMap.addAnnotation(annotation)
        }
    }
}


