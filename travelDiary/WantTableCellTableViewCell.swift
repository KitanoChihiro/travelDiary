//
//  WantTableCellTableViewCell.swift
//  
//
//  Created by 北野千裕 on 2019/01/11.
//

import UIKit

class WantTableCellTableViewCell: UITableViewCell {
    
    var wantPlace = UILabel()
    var wantDate = UILabel()
    var wantPurpose = UILabel()
    
    
    
    
    
    // cellに表示する内容
    func cellShow(chooseNum: IndexPath){
        self.wantPlace.text = String((chooseNum.row) + 1)
    }
    
    func customCell(){
        
        
        wantPlace.frame = CGRect(x: 5, y: 5, width: 355, height: 55)
        //        wantPlace.backgroundColor = UIColor.red
        wantPlace.font = wantPlace.font?.withSize(30)
        
        wantDate.frame = CGRect(x: 5, y: 65, width: 180, height: 30)
        //        wantDate.backgroundColor = UIColor.orange
        
        wantPurpose.frame = CGRect(x: 190, y: 65, width: 170, height: 30)
        //        wantPurpose.backgroundColor = UIColor.blue
        
        self.addSubview(wantPlace)
        self.addSubview(wantDate)
        self.addSubview(wantPurpose)
    }
}

