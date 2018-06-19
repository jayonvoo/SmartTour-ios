//
//  INaviMenuListPage.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/5/29.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import UIKit

class INaviMenuListPage: UITableViewController {
    
    var getText: String?
    var tableRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableItemCell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "黃金隧道"
            
        default:
            cell.textLabel?.text = "空資料"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        getText = cell?.textLabel?.text
        
        if indexPath.row == 0{
            tableRow = 0
        }
        
        performSegue(withIdentifier: "toINaviCellItem", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toINaviCellItem"{
            
            let secondVC = segue.destination as! INaviCellItemDisplayPage
            secondVC.textPass = getText
            
            if tableRow == 0{
                secondVC.topImagePass = UIImage(named: "7295445492_5421043b48_o.jpg")
                secondVC.bottomImagePass = UIImage(named: "7295459614_9636f49588_b.jpg")
                secondVC.descPass = "「台灣玻璃館」最知名的，應該是以玻璃與LED燈所建構成極具光影效果的「黃金隧道」了。隧道共長72公尺，分不同區域，各有不同的視聽覺與觸覺的體驗效果，相當特別，是值得一遊的地方。參觀黃金隧道不用門票，但為維護隧道的鏡面與玻璃，參觀黃金隧道需購買隧道前櫃台的拖鞋，藍白拖印上台灣博物館字樣，很有台灣味。"
            }
        }
    }
}
