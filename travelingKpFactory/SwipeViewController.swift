//
//  DemoViewController.swift
//  SlidingContainerViewController
//
//  Created by Cem Olcay on 10/04/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController, SlidingContainerViewControllerDelegate {
    
    var dropArray = ["台灣 +886", "美國 +1", "馬來西亞 +60", "新加坡 +65", "日本 +81"]
    var getCurrentTitle: String?
    var captData: CaptchaModel?
    var getStringCaptcha: String?
    var getUserName: String?
    @IBOutlet weak var captchaHolder: UITextField!
    @IBOutlet var phoneAuthPage: UIView!
    @IBOutlet var loginPage: UIView!
    @IBOutlet weak var regButton: UIButton!
    @IBOutlet weak var regButton2: UIButton!
    @IBOutlet weak var dropTable: UITableView!
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var editTextValue: UITextField!
    
    @IBAction func SubmitBtn(_ sender: Any) {  //註冊和驗證
        
        let params = [
            "email" : editTextValue.text,
            "code" : captchaHolder.text
        ]
        
        let data = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        HTTPPostJSON(url: "\(RootUrl.init().Url)/api/captcha/verifyCaptcha", data: data!){(error, result) in
            
            if(error != nil){
                print(error!.localizedDescription)
                return
            }else {
                print(result ?? "")  ///回傳驗證結果
                let parseData: Data = result!.data(using: .utf8)!
                
                do{
                    let parseJson = try JSONDecoder().decode(CaptchaModel.VerifyModel.self, from: parseData)
                    
                    if parseJson.status == "success"{
                        
                        DispatchQueue.main.async{
                            let popData = self.navigationController?.viewControllers[0] as! UserMenu
                            popData.userName = self.editTextValue.text
                            popData.userTableList.reloadData()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                        self.showToast(message: "驗證失敗!")
                    }
                    
                }catch{}
            }
        }
    }
    
    @IBAction func emailCodeSubmit(_ sender: Any) {
        
        var dict = Dictionary<String, Any>()
        dict["email"] = editTextValue.text
        
        
        ///把email上傳到線上資料
        let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
        
        HTTPPostJSON(url: "\(RootUrl.init().Url)/api/captcha", data: data!){ (error, result) in
            
            if(error != nil){
                print(error!.localizedDescription)
                return
            }
            
            //取得email和驗證碼資料
            do{
                let parseData: Data = result!.data(using: .utf8)!
                let parseJson = try JSONDecoder().decode(CaptchaModel.self, from: parseData)
                
                DispatchQueue.main.async { // Correct
                    self.captchaHolder.placeholder = parseJson.data.code  //顯示輸入碼
                }
            }catch{}
        }
    }
    
    @IBAction func mainBtn(_ sender: Any) {
        self.dropTable.isHidden = !self.dropTable.isHidden
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "旅遊管家歡迎你"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Light", size: 20)!
        ]
        
        regButton.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.5725490196, blue: 0.137254902, alpha: 1)
        regButton2.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.5725490196, blue: 0.137254902, alpha: 1)
        
        self.dropTable.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //let vc1 = viewControllerWithColorAndTitle(UIColor.white, title: "First View Controller")
        let vc2 = viewControllerWithColorAndTitle(UIColor.white, title: "賬號登入")
        let vc3 = viewControllerWithColorAndTitle(UIColor.white, title: "手機驗證碼登入")
        //let vc4 = viewControllerWithColorAndTitle(UIColor.white, title: "Forth View Controller")
        
        let slidingContainerViewController = SlidingContainerViewController (
            parent: self,
            contentViewControllers: [vc2, vc3],
            titles: ["賬號登入", "手機驗證碼登入"])
        
        view.addSubview(slidingContainerViewController.view)
        
        slidingContainerViewController.sliderView.appearance.outerPadding = 0
        slidingContainerViewController.sliderView.appearance.innerPadding = 50
        slidingContainerViewController.sliderView.appearance.fixedWidth = true
        slidingContainerViewController.setCurrentViewControllerAtIndex(0)
        slidingContainerViewController.delegate = self
    }
    
    func viewControllerWithColorAndTitle (_ color: UIColor, title: String) -> UIViewController {
        let vc = UIViewController ()
        
        if title == "賬號登入"{
            
            loginPage.frame.origin.y += 30
            loginPage.frame.size.width = self.view.bounds.width
            
            vc.view.addSubview(loginPage)
        }else{
            
            phoneAuthPage.frame.origin.y += 50
            phoneAuthPage.frame.size.width = self.view.bounds.width
            
            vc.view.addSubview(phoneAuthPage)
        }
        return vc
    }
    
    // MARK: SlidingContainerViewControllerDelegate
    
    func slidingContainerViewControllerDidMoveToViewController(_ slidingContainerViewController: SlidingContainerViewController, viewController: UIViewController, atIndex: Int) {
        
    }
    
    func slidingContainerViewControllerDidShowSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidHideSliderView(_ slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    //建立訪問URL
    func HTTPsendRequest(request: URLRequest,
                         callback: @escaping (Error?, String?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if (err != nil) {
                callback(err,nil)
            } else {
                callback(nil, String(data: data!, encoding: String.Encoding.utf8))
            }
        }
        task.resume()
    }
    
    // post JSON
    func HTTPPostJSON(url: String,  data: Data,
                      callback: @escaping (Error?, String?) -> Void) {
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        request.httpBody = data
        HTTPsendRequest(request: request, callback: callback)
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
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
        
        
        //getGlobalToast = toastLabel
        
    }
}

extension SwipeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dropArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropCell", for: indexPath)
        
        cell.textLabel?.text = dropArray[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        btnLabel.setTitle(cell?.textLabel?.text, for: .normal)
        getCurrentTitle = cell?.textLabel?.text
        
        self.dropTable.isHidden = true
    }
    
}

extension SwipeViewController: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? UserMenu)?.userName = getUserName
    }
}
