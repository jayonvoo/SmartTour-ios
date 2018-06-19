//
//  MainSearchPage.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/5/29.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import UIKit

class MainSearchPage: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var keyw01: UILabel!
    @IBOutlet weak var keyw02: UILabel!
    @IBOutlet weak var keyw03: UILabel!
    @IBOutlet weak var keyw04: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    var testArray = [String]()
    var backupArr = [String]()
    var search: String = ""
    var isSearch = false
    var keywordObject = [KeywordModel.KeywordData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        backupArr = testArray
        
        guard let jsonUrl = URL(string: "\(RootUrl.init().Url)/api/keywords") else{return}
        var request = URLRequest(url: jsonUrl)
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){(data, responds, error) in
            
            if error == nil{
                
                do{
                    
                    let result = try JSONDecoder().decode(KeywordModel.self, from: data!)
                    
                    for getData in result.data{
                        self.testArray.append(getData.keyword)
                        
                        DispatchQueue.main.async{
                            switch getData.keyword{
                            case "黑橋牌":
                                self.keyw01.text = getData.keyword
                                
                            case "熱門工廠":
                                self.keyw02.text = getData.keyword
                                
                            case "味噌":
                                self.keyw03.text = getData.keyword
                                
                            case "緞帶王":
                                self.keyw04.text = getData.keyword
                                
                            default: break
                            }
                        }
                    }
                    
                }catch{
                    
                }
                
            }
            }.resume()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        search = textField.text! + string
        
        
        
        if string == ""{
            search = String(search[..<search.index(before: search.endIndex)])
        }
        
        if search == ""{
            isSearch = false
            searchTableView.reloadData()
            
        }else{
            let predicate = NSPredicate(format: "SELF CONTAINS[c] %@", search)
            backupArr = (testArray as NSArray).filtered(using: predicate) as! [String]
            isSearch = true
            searchTableView.reloadData()
        }
        
        return true
        
    }
}


extension MainSearchPage: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch{
            return backupArr.count
        }else {
            
            return testArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSearch", for: indexPath)
        
        if isSearch{
            cell.textLabel?.text = backupArr[indexPath.row]
        }else{
            
            cell.textLabel?.text = testArray[indexPath.row]
        }
        /*
         let data = backupArr[indexPath.row]
         
         cell.textLabel?.text = data
         cell.selectionStyle = .none
         */
        
        return cell
    }
    
}


