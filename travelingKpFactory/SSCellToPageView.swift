//
//  SSCellToPageView.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/5/30.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import UIKit

class SSCellToPageView: UIViewController {
    
    var getImageArray = [UIImage]()
    var getTitleArray = [String]()
    var getDescArray = [String]()
    var toImage: UIImage?
    var toTitle: String?
    var toDesc: String?
    @IBOutlet var popUpTableView: UIView!
    @IBOutlet weak var miniTableView: UITableView!
    @IBAction func popUpShareAction(_ sender: Any) {
        
        let shareView = UIActivityViewController(activityItems: ["hello",UIImage(named: "user.png")!], applicationActivities: [])
        present(shareView, animated: true, completion: nil)
    }
    
    @IBAction func popUpTableAction(_ sender: Any) {
        
        popUpTableView.frame.origin.y = self.view.bounds.height
        popUpTableView.frame.size.width = self.view.bounds.width
        popUpTableView.frame.size.height = 500
        
        view.addSubview(popUpTableView)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations:{
            self.popUpTableView.center.y = self.view.bounds.maxY - 250
            self.popUpTableView.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func hideOutTableAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations:{
            self.popUpTableView.frame.origin.y = self.view.bounds.maxY
            self.popUpTableView.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SSCellToPageView: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == miniTableView{
            return getImageArray.count
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == miniTableView{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "miniTableCell", for: indexPath)
            
            let myImage = cell.viewWithTag(10) as! UIImageView
            let myDesc = cell.viewWithTag(11) as! UITextView
            let myTitle = cell.viewWithTag(12) as! UILabel
            
            myImage.image = getImageArray[indexPath.row]
            myDesc.text = getDescArray[indexPath.row]
            myTitle.text = getTitleArray[indexPath.row]
            
            return cell
            
        }else{
            
            switch indexPath.row {
            case 0:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell01", for: indexPath)
                
                return cell
                
            case 1:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell02", for: indexPath)
                
                let myTitle = cell.viewWithTag(2) as! UILabel
                
                myTitle.text = toTitle
                
                return cell
            case 2:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell03", for: indexPath)
                
                let myImage = cell.viewWithTag(7) as! UIImageView
                let myDesc = cell.viewWithTag(8) as! UITextView
                
                myImage.image = toImage
                myDesc.text = toDesc
                
                return cell
                
            default:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell03", for: indexPath)
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == miniTableView{
            
            return 117
            
        }else{
            
            switch indexPath.row {
            case 0:
                return 300
            case 1:
                return 200
            case 2:
                return 530
            default:
                return 530
            }
        }
    }
}
