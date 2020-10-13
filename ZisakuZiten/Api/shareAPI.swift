//
//  shareAPI.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/06.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation

class ShareAPI{
    enum Result:String {
        case ok = "ok"
        case ng = "ng"
    }
    
//    let posturlString = "https://http3.herokuapp.com/post"
//    let geturlString = "https://http3.herokuapp.com/get/"
    public let baseurl = "http://192.168.0.104:8000"
    var posturlString = ""
    var geturlString = ""
    
    init() {
        self.posturlString = self.baseurl + "/post"
        self.geturlString = self.baseurl + "/get/"
        
    }

    func post(params:String,result:@escaping(_ res: Result, _ id: String, _ passwd: String)->Void){
        let request = NSMutableURLRequest(url: URL(string: posturlString)!)

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var jsonres:Dictionary<String, Any>!
        do{
            request.httpBody = params.data(using: .utf8)

            let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) -> Void in
                if data == nil{
                    result(Result.ng ,"","")
                    return
                }
                do{
                    jsonres = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                    result(Result(rawValue: jsonres["res"] as! String)!,jsonres["id"] as! String,jsonres["passwd"] as! String)
                }catch{
                    result(.ng, "", "")
                    return
                }
                let resultData = String(data: data!, encoding: .utf8)!
                print("result:\(resultData)")
//                print("response:\(response)")

            })
            task.resume()
        }catch{
            print("Error:\(error)")
            result(Result.ng ,"","")
//            return (res: Result.ng, id: "", passwd: "")
        }
    }
    
    func parse(response: String){
        
    }
    
    func get(id:String ,result:@escaping(_ res: Result, _ data: String)->Void){
        if id.lengthOfBytes(using: .utf8) != 36{
            result(.ng ,"")
            return
        }
        do{
            let request:NSMutableURLRequest = NSMutableURLRequest(url: URL(string: geturlString+id)!)

            var jsonres:Dictionary<String, Any>!
            let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) -> Void in
                if data == nil{
                    result(.ng ,"")
                    return
                }
                do{
                    jsonres = try JSONSerialization.jsonObject(with: data!) as? Dictionary<String, Any>
                    result(Result(rawValue: jsonres["res"] as! String)!,jsonres["data"] as! String)
                }catch{
                    result(.ng, "")
                    return
                }
            })
            task.resume()
        }catch{
            result(.ng ,"")
        }
    }
}
