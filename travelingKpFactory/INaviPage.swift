//
//  INaviPage.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/5/29.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import UIKit

class INaviPage: UIViewController {
    @IBOutlet weak var ecoImage: UIImageView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var scanImage: UIImageView!
    @IBOutlet weak var hisImage: UIImageView!
    @IBOutlet weak var areaImage: UIImageView!
    @IBOutlet weak var insImage: UIImageView!
    var dataGroup = [SmartPageModel.SmartDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        ecoImage.isUserInteractionEnabled = true
        ecoImage.addGestureRecognizer(tapGesture)
        
        guard let jsonUrl = URL(string: "\(RootUrl.init().Url)/api/smarts") else {
            return
        }
        var request = URLRequest(url: jsonUrl)
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){(data, responds, error) in
            
            if error == nil{
                
                do{
                    let result = try JSONDecoder().decode(SmartPageModel.self, from: data!)
                    for item in result.data{
                        
                        let url = URL(string: "\(RootUrl.init().Url)/\(item.img)")
                        let data = try? Data(contentsOf: url!)
                        
                        DispatchQueue.main.async{
                            switch item.title{
                            case "生態導覽":
                                self.ecoImage.image = UIImage(data: data!)
                                
                            case "拍攝識別":
                                self.scanImage.image = UIImage(data: data!)
                                
                            case"使用說明":
                                self.insImage.image = UIImage(data: data!)
                                
                            case"歷史導覽":
                                self.hisImage.image = UIImage(data: data!)
                                
                            case"地區導覽":
                                self.areaImage.image = UIImage(data: data!)
                                
                            default: break
                                
                            }
                        }
                    }
                }catch{}
            }
            }.resume()
        
        topImage.image = UIImage(named: "village.jpg")
    }
    
    @objc func tapDetected(){
        performSegue(withIdentifier: "toINaviTable", sender: self)
    }
}
