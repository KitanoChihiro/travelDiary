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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // インスタンス化
        wantPlace = UILabel()
        wantDate = UILabel()
        wantPurpose = UILabel()

        wantPlace.frame = CGRect(x: 5, y: 5, width: 365, height: 55)
        wantPlace.backgroundColor = UIColor.red
        
        wantDate.frame = CGRect(x: 5, y: 5, width: 180, height: 30)
        wantDate.backgroundColor = UIColor.orange
        
        wantPurpose.frame = CGRect(x: 180, y: 65, width: 182, height: 30)
        wantPurpose.backgroundColor = UIColor.blue
        
        self.addSubview(wantPlace)
        self.addSubview(wantDate)
        self.addSubview(wantPurpose)
        
    }
    
    // cellに表示する内容
    func cellShow(chooseNum: IndexPath){
        self.wantPlace.text = String((chooseNum.row) + 1)
    }
}
