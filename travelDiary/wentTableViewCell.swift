//
//  wentTableViewCell.swift
//  travelDiary
//
//  Created by 北野千裕 on 2019/01/15.
//  Copyright © 2019年 Chihiro Kitano. All rights reserved.
//

import UIKit

class wentTableViewCell: UITableViewCell {
    
    var wentImage = UIImageView()
    var wentPlace = UILabel()
    var wentDate = UILabel()

    
    // カスタムセルの設定
    func wentCell(){
        wentImage.frame = CGRect(x: 5, y: 5, width: 100, height: 90)
        wentImage.backgroundColor = .orange
        
        wentPlace.frame = CGRect(x: 115, y: 5, width: 250, height: 60)
        wentPlace.font = wentPlace.font?.withSize(30)
        
        
        
        wentDate.frame = CGRect(x: 115, y: 70, width: 250, height: 20)
        
        
        
        self.addSubview(wentPlace)
        self.addSubview(wentImage)
        self.addSubview(wentDate)
    }

}
