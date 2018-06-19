//
//  FirstPage.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/5/21.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import UIKit

class FirstPage: UIViewController, UISearchBarDelegate {
    
    var colorArray = [#colorLiteral(red: 0.9921568627, green: 0.4941176471, blue: 0.1607843137, alpha: 1),#colorLiteral(red: 0.3411764706, green: 0.6431372549, blue: 0.8823529412, alpha: 1),#colorLiteral(red: 0.5607843137, green: 0.7725490196, blue: 0.2117647059, alpha: 1),#colorLiteral(red: 0.6666666667, green: 0.768627451, blue: 0.2705882353, alpha: 1),#colorLiteral(red: 0.9647058824, green: 0.7647058824, blue: 0.2705882353, alpha: 1),#colorLiteral(red: 0.7921568627, green: 0.431372549, blue: 0.9176470588, alpha: 1),#colorLiteral(red: 0.2823529412, green: 0.8078431373, blue: 0.6901960784, alpha: 1),#colorLiteral(red: 0.9411764706, green: 0.3254901961, blue: 0.5176470588, alpha: 1)]
    var headerIcon = ["旅遊介紹","飯店","交通","周邊景點","智慧導覽","旅行視頻","客服","照片分享"]
    var searchBar = UISearchBar()
    var countRow = 1
    var objJSONArray = [FirstPageModel.UserDataModel]()
    var dispatch = DispatchSemaphore.init(value: 0)
    var getErrorCode: Int?
    
    @IBAction func textField(_ sender: Any) {
        
        performSegue(withIdentifier: "toSearchPage", sender: self)
        
        //showSearchBar()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("get document: \(getDocumentsDirectory())")
        
        guard let jsonURL = URL(string: "\(RootUrl.init().Url)/api/articles") else { return }
        var request = URLRequest(url: jsonURL)
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response
            , error) in
            
            if error != nil{
                self.getErrorCode = (error! as NSError).code
            }
            
            if self.getErrorCode != nil{
                if self.getErrorCode == -1004{
                    self.dispatch.signal()
                }
            }else{
                self.dispatch.signal()
            }
            
            guard let data = data else { return }
            
            do{
                let result = try JSONDecoder().decode(FirstPageModel.self, from: data)
                
                for getData in result.data{
                    
                    self.objJSONArray.append(getData)
                }
                
                self.dispatch.signal()
                
            } catch let jsonErr{
                print("Error getting json", jsonErr)
            }
            }.resume()
        //dispatch.wait()
        
        if getErrorCode != nil{
            if abs(getErrorCode!) == 1004 {
                showToast(message: "連線失敗")
            }
        }
    }
    
    func showSearchBar() {
        searchBar.alpha = 0
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        navigationItem.setLeftBarButton(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel clicked")
    }
    
    //MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //hideSearchBar()
    }
    
    @objc func myTargetFunction(textField: UITextField) {
        print("myTargetFunction")
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func showToast(message : String) {
        
        DispatchQueue.main.async{
            
            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 200, height: 35))
            toastLabel.center = self.view.center
            toastLabel.center.y = 650
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            
            UIView.animate(withDuration: 1, delay: 3, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
            
        }
    }
}

extension FirstPage: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objJSONArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            
            return cell
        }else {
            let data: Data?
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableContentCell", for: indexPath)
            
            let myLabel = cell.viewWithTag(3) as! UITextView
            let myTitle = cell.viewWithTag(1) as! UILabel
            let myPic = cell.viewWithTag(2) as! UIImageView
            
            myLabel.textContainer.lineBreakMode = .byTruncatingTail
            
            myLabel.text = self.objJSONArray[indexPath.row - 1].info
            myTitle.text = self.objJSONArray[indexPath.row - 1].title
            
            if self.objJSONArray[indexPath.row - 1].img != nil{
                let url = URL(string: "\(RootUrl.init().Url)/\(self.objJSONArray[indexPath.row - 1].img!)")
                data = try? Data(contentsOf: url!)
                myPic.image = UIImage(data: data!)
            }else{
                myPic.image = UIImage(named: "emptyImage")
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            
            return 310
        } else{
            
            return 250
        }
        
    }
    
}

extension FirstPage: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout    {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return headerIcon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItem", for: indexPath)
        
        let cellImage = cell.viewWithTag(10) as! UIImageView
        let cellName = cell.viewWithTag(11) as! UILabel
        
        cellImage.backgroundColor = colorArray[indexPath.row]
        cellName.text = headerIcon[indexPath.row]
        cellName.textColor = colorArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collHeader", for: indexPath)
            
            return headerView
            
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "collFooter", for: indexPath)
            
            return footerView
            
        default:
            assert(false, "Unexpected element kind")
        }
        
        let reuseableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "collHeader", for: indexPath)
        
        return reuseableview
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 4{
            
            performSegue(withIdentifier: "toCell04Page", sender: self)
        }
    }
}
