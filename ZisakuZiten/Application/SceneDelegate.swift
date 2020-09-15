//
//  SceneDelegate.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/06/21.
//  Copyright © 2020 unkonow. All rights reserved.
//

import UIKit


//@available(iOS 13.0, *)
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let _ = (scene as? UIWindowScene) else { return }
//    }
//
//    func sceneDidDisconnect(_ scene: UIScene) {
//        // Called as the scene is being released by the system.
//        // This occurs shortly after the scene enters the background, or when its session is discarded.
//        // Release any resources associated with this scene that can be re-created the next time the scene connects.
//        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        // Called when the scene has moved from an inactive state to an active state.
//        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        // Called when the scene will move from an active state to an inactive state.
//        // This may occur due to temporary interruptions (ex. an incoming phone call).
//    }
//
//    func sceneWillEnterForeground(_ scene: UIScene) {
//        // Called as the scene transitions from the background to the foreground.
//        // Use this method to undo the changes made on entering the background.
//    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        // Called as the scene transitions from the foreground to the background.
//        // Use this method to save data, release shared resources, and store enough scene-specific state information
//        // to restore the scene back to its current state.
//    }
//
//
//}

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    let access = FileManager.default.url.startAccessingSecurityScopedResource()
    let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!

    var window: UIWindow?


    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let _ = (scene as? UIWindowScene) else { return }
//        print("hfeajifjfeafei ")
//        if connectionOptions.urlContexts.count == 1 {
//            let content = connectionOptions.urlContexts.first!
//            print(content.url)
//
//        }
         
//    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>){
           print(URLContexts)
        loadJSON(from: URLContexts.first!.url)
//        let json = String(data:getFileData(URLContexts.first!.url)!, encoding: .utf8)
//        let data = json!.data(using: .utf8)!
//        do{
////            let couponData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
//            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
////            print(json[0]["title"])
//        }catch{return}
        
//        let obj = try! JSONDecoder().decode(Group.self, from: data)
//        print(obj)

    }
    
    func getFileData(_ filePath: URL) -> Data? {
        let fileData: Data?
        do {
//            let fileUrl:URL = URL(fileURLWithPath: filePath)
            fileData = try Data(contentsOf: filePath)
        } catch {
            // ファイルデータの取得でエラーの場合
            fileData = nil
        }
        return fileData
    }
    //ykn
    func loadJSON(from url:URL){
        print("loadJSON func called")
        guard let rootVC = window?.rootViewController as? MainTabViewController,let navVC = rootVC.viewControllers?.first, let vc = navVC.children.first as? ViewController else{return}
        print("rootVC get ok.")
        
        /////////////////////////////////////////////////////
//        let testdict = """
//            {
//                "control": {
//                    "type": "Button",
//                    "name": "Save",
//                    "ui": {
//                        "scale": 0.5,
//                        "padding": {
//                            "top": 24,
//                            "bottom": 32
//                        }
//                    }
//                }
//            }
//        """
//        var resdict = convertToDictionary(text: testdict)! as [String:Any]
//        print(getDictValue(dict: resdict, path: "control.ui.padding.top"))
        ////////////////////////////////////////////////////
        
        do{
            let filedata = try Data(contentsOf: url)
            print("filedata get ok",filedata)
            var jsonArray = try JSONSerialization.jsonObject(with: filedata, options: []) as! NSDictionary
            print("jsonArray ok")
//            print(NSAnyDictparser(dict: jsonArray))
//            print(jsonArray["ziten_updT_List"] as? NSArray,"FIRST!!!")
            
            var tesst = jsonArray["ziten_updT_List"] as! NSArray
            var gdata = tesst.map{$0 as! NSDictionary}
            
            //            var test2 = tesst[0] as! NSDictionary
            print(gdata[0]["title"])
            print(jsonArray["title"])
//            var groupData = jsonArray.map{(data) -> [String: Any] in return data as! [String: Any]}
//            print("Group data ok")
//            groupData[0]["ziten_updT_List"] = groupData[0]["ziten_upT_list"] as! [[String:Any]]
//            jsonArray["ziten_updT_List"] = jsonArray["ziten_updT_List"] as! [[String:Any]]
//            print(jsonArray["ziten_updT_List"]["title"])
            
            let createTime = (jsonArray["createTime"] as! String).toDate()
            let updateTime = (jsonArray["updateTime"] as! String).toDate()
            
            vc.jsonDict2Group(title: jsonArray["title"] as! String, createTime: createTime,updateTime: updateTime, ziten_dict: gdata)
            
            
//            print(groupData)
//            vc.
            
        }catch{
            print("ERROR\(error)")
        }
    }
    
    func NSAnyDictparser(dict:NSDictionary){
        var nameOfIntegers = [String:Any]()
        nameOfIntegers["ping"] = "pong"
        nameOfIntegers["dict"] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        print("nameOfINtegers is ",nameOfIntegers)
        print("dictYYZ is ",nameOfIntegers["dict.YYZ"])
        
        var returndict = [String:Any]()
        
        for item in dict.allKeys{
            if dict[item] as? NSArray == nil{
                returndict[item as! String] = dict[item]
            }else{
                let arrayDict = dict[item] as! NSArray
                print("arrydict",(arrayDict[0] as! NSDictionary)["title"])
                let itemdict = arrayDict.map{$0 as! NSDictionary}
                print("ITEM DICT",itemdict[0])
                returndict[item as! String] = itemdict
            }
        }
        
        print("REUTNR DICT: ",((returndict["ziten_updT_List"] as! NSArray)[0] as! NSDictionary)["title"])
        
//        print("get ZZ",(getDictValue(dict: returndict, path: "ziten_updT_List") as! NSDictionary))
        print("HEY!!!",type(of:returndict))
        

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
    //path example: "control.ui.scale"
    func getDictValue(dict:[String: Any], path:String)->Any?{
        let arr = path.components(separatedBy: ".")
        if(arr.count == 1){
            return dict[String(arr[0])]
        }
        else if (arr.count > 1){
            let p = arr[1...arr.count-1].joined(separator: ".")
            let d = dict[String(arr[0])] as? [String: Any]
            if (d != nil){
                return getDictValue(dict:d!, path:p)
            }
        }
        return nil
    }


}
