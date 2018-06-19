//
//  ShopPageView.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/5/25.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import UIKit

class ShopPageView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ShopPageView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell01", for: indexPath)
            
            tableView.separatorStyle = .none
            
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell02", for: indexPath)
            
            tableView.separatorStyle = .singleLine
            
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell03", for: indexPath)
            
            tableView.separatorStyle = .singleLine
            
            return cell
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell04", for: indexPath)
            
            tableView.separatorStyle = .singleLine
            
            return cell
            
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell05", for: indexPath)
            
            return cell
            
        case 5:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell06", for: indexPath)
            
            return cell
            
        case 6:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell07", for: indexPath)
            
            return cell
            
        case 7:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell08", for: indexPath)
            
            return cell
            
        case 8:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell09", for: indexPath)
            
            return cell
            
        case 9:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell10", for: indexPath)
            
            tableView.separatorStyle = .none
            
            return cell
            
        case 10:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell11", for: indexPath)
            
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell01", for: indexPath)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 150
            
        case 1:
            return 100
            
        case 2:
            return 150
            
        case 3:
            
            return 230
            
        case 4:
            
            return 220
            
        case 5:
            
            return 300
            
        case 6:
            
            return 120
            
        case 7:
            
            return 300
            
        case 8:
            
            return 300
            
        default:
            return 200
        }
    }
}

extension ShopPageView: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        case "collrow01":
            return 8
            
        case "collrow02":
            return 5
            
        case "collrow03":
            return 10
            
        case "collrow04":
            return 10
            
        case "collrow05":
            return 10
            
        case "collrow06":
            return 2
            
        case "collrow07":
            return 2
            
        default:
            return 2
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.restorationIdentifier {
        case "collrow01":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItem01", for: indexPath)
            
            return cell
            
        case "collrow02":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItem02", for: indexPath)
            
            return cell
            
        case "collrow03":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItem03", for: indexPath)
            
            return cell
            
        case "collrow04":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItem04", for: indexPath)
            
            return cell
            
        case "collrow05":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItem05", for: indexPath)
            
            return cell
            
        case "collrow06":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItem06", for: indexPath)
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItem07", for: indexPath)
            
            return cell
        }
    }
}
