
//
//  SigtSeeingPageView.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/5/30.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import UIKit

class SigtSeeingPage: UITableViewController {
    
    var getImage = [UIImage]()
    var passImage: UIImage?
    var getTitle = [String]()
    var passTitle: String?
    var getDesc = [String]()
    var passDesc: String?
    var dataGroup = [TourModel.TourDataModel]()
    var dispatch = DispatchSemaphore.init(value: 0)
    var getNil: Any?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let jsonUrl = URL(string: "\(RootUrl.init().Url)/api/photos") else { return }
        var request = URLRequest(url: jsonUrl)
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){(data, responds, error) in
            
            if error == nil{
                do{
                    let result = try JSONDecoder().decode(TourModel.self, from: data!)
                    
                    for item in result.data{
                        self.dataGroup.append(item)
                    }
                    
                    self.dispatch.signal()
                }catch{}
            }else{
                self.getNil = error
                self.dispatch.signal()
            }
            }.resume()
        //dispatch.wait()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataGroup.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell01", for: indexPath)
            
            if getNil == nil{
                let image = cell.viewWithTag(1) as! UIImageView
                let scrollImg = cell.viewWithTag(12) as! UIImageView
                let scrollTitle = cell.viewWithTag(10) as! UILabel
                let scrolldesc = cell.viewWithTag(11) as! UILabel
                let scrollView = cell.viewWithTag(100) as! UIScrollView
                let minView = cell.viewWithTag(150) as! UIView
                var imgframeContain = CGRect(x: 0, y: 0, width: 0, height: 0)
                var minFrameContain = CGRect(x: 0, y: 0, width: 0, height: 0)
                
                let url = URL(string: "\(RootUrl.init().Url)/\(dataGroup[0].img)")
                let data = try? Data(contentsOf: url!)
                
                scrollImg.image = UIImage(data: data!)
                scrollTitle.text = dataGroup[0].title
                scrolldesc.text = ""
                
                for index in 1..<5{
                    imgframeContain.origin.x = scrollView.bounds.width * CGFloat(index)
                    imgframeContain.size = scrollView.frame.size
                    imgframeContain.size.height = scrollImg.frame.height
                    
                    minFrameContain.origin.y = imgframeContain.height
                    minFrameContain.origin.x = scrollView.bounds.width * CGFloat(index)
                    minFrameContain.size = minView.frame.size
                    
                    let imgSubview = UIImageView(frame: imgframeContain)
                    let minSubview = UIView(frame: minFrameContain)
                    
                    minSubview.backgroundColor = UIColor.white
                    
                    imgSubview.image = scrollImg.image
                    scrollView.addSubview(imgSubview)
                    scrollView.addSubview(minSubview)
                }
                scrollView.contentSize = CGSize(width: scrollView.bounds.width * 5, height: scrollView.frame.size.height)
                scrollView.isPagingEnabled = true
                image.image = UIImage(named: "tourback.jpg")
            }
            
            
            
            return cell
            
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell02", for: indexPath)
            
            let myTitle = cell.viewWithTag(2) as! UILabel
            let myPic = cell.viewWithTag(3) as! UIImageView
            let url = URL(string: "\(RootUrl.init().Url)/\(dataGroup[indexPath.row - 1].img)")
            let data = try? Data(contentsOf: url!)
            
            myTitle.text = dataGroup[indexPath.row - 1].title
            myPic.image = UIImage(data: data!)
            
            if getImage.count != dataGroup.count{
                getImage.append(myPic.image!)
                getTitle.append(myTitle.text!)
                getDesc.append(dataGroup[indexPath.row - 1].info)
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 500
            
        default:
            return 200
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0{
            
            passImage = getImage[indexPath.row - 1]
            passTitle = getTitle[indexPath.row - 1]
            passDesc = getDesc[indexPath.row - 1]
            
            performSegue(withIdentifier: "toSSCellPage", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! SSCellToPageView
        segue.toImage = passImage
        segue.toTitle = passTitle
        segue.toDesc = passDesc
        segue.getImageArray = getImage
        segue.getDescArray = getDesc
        segue.getTitleArray = getTitle
    }
    
    
}

extension SigtSeeingPage: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItem01", for: indexPath)
        
        return cell
    }
    
}

