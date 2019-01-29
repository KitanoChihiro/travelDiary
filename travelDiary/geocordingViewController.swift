//
//  geocordingViewController.swift
//  travelDiary
//
//  Created by 北野千裕 on 2019/01/23.
//  Copyright © 2019年 Chihiro Kitano. All rights reserved.
//

import UIKit
import MapKit

// グローバル変数を作ってどこでも使えるように定義しておく
var resultPlace:String! = ""
var resultLatitude:Double! = 0.0
var resultLongitude:Double! = 0.0

class geocordingViewController: UIViewController {
    
    // スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    // 自分の発行したキー
    let apiKey = "AIzaSyD9jyEK8bPMmqAndBj7sGvvJ5TAIL4VxIw"
    
    var resultMap:MKMapView!
    var latitudeLabel:UILabel!
    var longitudeLabel:UILabel!
    var searchText:UITextField!
    
    
    // 緯度経度
    var searchLatCenter:Double = 0.0
    var searchLngCenter:Double = 0.0
    
    // 検索開始ボタン
    var goBtn:UIButton!
    // 前画面に戻る
    var backBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        resultMap = MKMapView()
        searchText = UITextField()
        latitudeLabel = UILabel()
        longitudeLabel = UILabel()
        goBtn = UIButton()
        backBtn  = UIButton()
        
        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height

        resultMap.frame = CGRect(x: 0, y: 300, width: screenWidth, height: 600)
        goBtn.frame = CGRect(x: 20, y: 150, width: 100, height: 40)
        goBtn.backgroundColor = .red
        searchText.frame = CGRect(x: 20, y: 200, width: 300, height: 40)
        searchText.backgroundColor = .white
        latitudeLabel.frame = CGRect(x: 20, y: 250, width: 100, height: 40)
        longitudeLabel.frame = CGRect(x: 230, y: 250, width: 100, height: 40)
        backBtn.frame = CGRect(x: 200, y: 150, width: 100, height: 40)
        backBtn.backgroundColor = .white
        view.backgroundColor = UIColor(hex: "FFE3A3")
        
    
        view.addSubview(backBtn)
        view.addSubview(resultMap)
        view.addSubview(searchText)
        view.addSubview(goBtn)
        view.addSubview(searchText)
        view.addSubview(latitudeLabel)
        view.addSubview(longitudeLabel)
        
        
        // バックボタン「決定」を押したときの動き
        backBtn.addTarget(self, action:  #selector(geocordingViewController.back(_:)), for: .touchUpInside)
        
        // goBtnを押したときの動き
        goBtn.addTarget(self, action:
            #selector(geocordingViewController.goBtn(_:)), for: .touchUpInside)
        // キーボードファンクションの呼び出し
        keyboad()
        
    }
    
    // セグエに関するコード
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func back(_ sender: UIButton) {
        
        resultPlace = searchText.text
        resultLatitude = searchLatCenter
        resultLongitude = searchLngCenter
        // selectorで呼び出す場合Swift4からは「@objc」をつける。
        self.dismiss(animated: true, completion: nil)
        
        // 前ページラベルに場所の名前をセットしておく
        resultPlace = searchText.text!
  
    }
    
    // 検索ボタンがタップされた時
    @IBAction func goBtn(_ sender: Any) {
        //ほんとはここで入力チェックとかのバリデーションした方がいいかも
        
        //地名をURLの一部にしてもいいようにエンコード（変換）する
        let urlencodekeyword = searchText.text!.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        //実行するためのURLを文字列で作成
        let urlstring = "https://maps.googleapis.com/maps/api/geocode/json?lang=ja&address=\(urlencodekeyword)&key=\(apiKey)"
        
        print(urlstring)
        //GoogleAPI(Web)を呼び出す
        let url = NSURL(string: urlstring)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let request = NSURLRequest(url: url! as URL)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            switch (data, response, error) {
            case (.some(data), .some(response), _):
                if (response as! HTTPURLResponse).statusCode == 200 {
                    var error: NSError?
                    do{
                        //取得結果は複雑なArrayとDicの組み合わせで返ってくるので解析して一階層ごとに取得
                        
                        let jsonDic = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                        
                        print(jsonDic)
                        
                        let resultsArray = jsonDic["results"] as! NSArray
                        
                        if(resultsArray.count == 0){
                            print("結果が何もありません")
                            break
                        }
                        
                        let firstArray = resultsArray[0] as! NSDictionary
                        
                        let geoDic = firstArray["geometry"] as! NSDictionary
                        
                        let location = geoDic["location"] as! NSDictionary
                        
                        // メインスレッドで実行（非同期処理内のデータをUIKit関係にセットするときはこの手順が必要）
                        DispatchQueue.main.async {
                            self.setLatLabel(lat:location["lat"] as! Double)
                            self.setLngLabel(lng:location["lng"] as! Double)
                            self.setMapCenter()
                        }
                        
                    }catch{
                    
                    }
                    
                } else {
                    // 処理
                }
            default:
                break
            }
        })
        
        
        task.resume()
    }
    //緯度ラベルにセット
    func setLatLabel(lat:Double){
        latitudeLabel.text = String(lat)
        searchLatCenter = lat
    }
    
    //経度ラベルにセット
    func setLngLabel(lng:Double){
        longitudeLabel.text = String(lng)
        searchLngCenter = lng
    }
    
    //検索結果をもとに地図中央にピンをセット
    func setMapCenter(){
        //中心となる場所（検索ワード）の座標オブジェクトを作成
        let coodinate = CLLocationCoordinate2DMake(searchLatCenter, searchLngCenter)
        
        //縮尺を設定
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        //範囲オブジェクトを作成
        let region = MKCoordinateRegion(center: coodinate, span: span)
        
        //MapViewに範囲オブジェクトを設置
        resultMap.setRegion(region, animated: true)
        
        //ピンオブジェクトを作成
        let centerPin = MKPointAnnotation()
        
        //ピンの座標を設定
        centerPin.coordinate = coodinate
        
        //タイトル、サブタイトルを設定
        centerPin.title = "検索結果"
        centerPin.subtitle = searchText.text
        
        //ピンを地図上に追加
        resultMap.addAnnotation(centerPin)
    }
}

extension geocordingViewController{
    func keyboad(){
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default
        kbToolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action:#selector(self.closeKeybord(_:)))
        kbToolBar.items = [spacer, commitButton]
        searchText.inputAccessoryView = kbToolBar
    }
    @objc func closeKeybord(_ sender:Any){
        self.view.endEditing(true)
    }
}
