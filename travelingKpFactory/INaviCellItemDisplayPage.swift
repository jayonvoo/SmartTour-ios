//
//  INaviCellItemDisplayPage.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/5/29.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import UIKit

class INaviCellItemDisplayPage: UIViewController {
    
    var textPass: String?
    var topImagePass: UIImage?
    var bottomImagePass: UIImage?
    var descPass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension INaviCellItemDisplayPage: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell01", for: indexPath)
            
            let topImage = cell.viewWithTag(1) as! UIImageView
            
            
            if textPass == "黃金隧道"{
                topImage.image = topImagePass
                
            }
            
            return cell
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell02", for: indexPath)
            
            let title = cell.viewWithTag(2) as! UILabel
            
            
            
            title.text = textPass
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell03", for: indexPath)
            
            let bottomImage = cell.viewWithTag(3) as! UIImageView
            let desc = cell.viewWithTag(4) as! UITextView
            
            if textPass == "黃金隧道"{
                bottomImage.image = bottomImagePass
                desc.text = descPass
            }
            
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell01", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            return 200
        case 2:
            return 500
        default:
            return 100
        }
        
    }
}
