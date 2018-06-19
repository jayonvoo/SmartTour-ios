//
//  UserMenu.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/5/23.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import UIKit

class UserMenu: UIViewController{
    
    @IBOutlet weak var userTableList: UITableView!
    var userName: String?
    var menuList = [UserMenuModel.DataModel]()
    var dispatch = DispatchSemaphore.init(value: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let jsonUrl = URL(string: "\(RootUrl.init().Url)/api/categories") else {return}
        var request = URLRequest(url: jsonUrl)
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){(data, responds, error) in
            
            if error == nil{
                do{
                    let result = try JSONDecoder().decode(UserMenuModel.self, from: data!)
                    
                    for getData in result.data{
                        self.menuList.append(getData)
                        
                    }
                    
                    self.menuList.sort(by: {(first: UserMenuModel.DataModel, second: UserMenuModel.DataModel) -> Bool in
                        first.order < second.order
                    })
                    self.dispatch.signal()
                }catch{}
            }else {
                self.dispatch.signal()
            }
            }.resume()
        //dispatch.wait()
    }
}

extension UserMenu: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
            let myName = cell.viewWithTag(1) as! UILabel
            myName.text = userName
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
            let data: Data?
            
            let myLabel = cell.viewWithTag(1) as! UILabel
            let myIcon = cell.viewWithTag(2) as! UIImageView
            
            myLabel.text = menuList[indexPath.row - 1].title
            
            
            if self.menuList[indexPath.row - 1].icon != nil{
                let url = URL(string: "\(RootUrl.init().Url)/\(self.menuList[indexPath.row - 1].icon!)")
                data = try? Data(contentsOf: url!)
                myIcon.image = UIImage(data: data!)
            }else{
                
                myIcon.image = UIImage(named: "empty.jpg")
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 90
        }else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            self.performSegue(withIdentifier: "toMultiPage", sender: self)
        }else if menuList[indexPath.row - 1].title == "我的遊記"{
            self.performSegue(withIdentifier: "toTour", sender: self)
        }
    }
}
