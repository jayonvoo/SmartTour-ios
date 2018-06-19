//
//  GlobalModel.swift
//  travelingKpFactory
//
//  Created by 創意遊玩 on 2018/6/12.
//  Copyright © 2018年 創意遊玩. All rights reserved.
//

import Foundation

///json路徑
struct RootUrl {
    var Url = "https://sightseeing-factory.travelingkp.com"
    //var webUrl = "http://127.0.0.1:8000"
}

///首頁模組
struct FirstPageModel: Codable {
    struct UserDataModel: Codable{
        
        var title: String
        var info: String
        var img: String?
    }
    
    var data: [UserDataModel]
}

//個人頁模組
struct UserMenuModel: Codable {
    struct DataModel: Codable{
        
        var id: Int
        var icon: String?
        var parent_id: Int
        var title: String
        var url: String
        var order: Int
    }
    var data: [DataModel]
}

//手機驗證模組
struct CaptchaModel: Codable{
    struct DataModel: Codable {
        var email: String
        var code: String
    }
    
    struct VerifyModel: Codable {
        var messege: String
        var status: String
    }
    
    var data: DataModel
}

//搜尋頁模組
struct KeywordModel: Codable{
    struct KeywordData: Codable{
        var id: Int
        var keyword: String
        var created_at: String
        var updated_at: String
    }
    
    var data: [KeywordData]
}

//智慧導覽頁模組
struct SmartPageModel: Codable {
    struct SmartDataModel: Codable {
        var title: String
        var img: String
        var url: String
    }
    
    var data: [SmartDataModel]
}

//看遊記頁模組
struct TourModel: Codable {
    struct TourDataModel: Codable {
        var order: Int
        var title: String
        var info: String
        var img: String
    }
    
    var data: [TourDataModel]
}




