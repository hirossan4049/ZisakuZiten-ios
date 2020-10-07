//
//  shareAPI.swift
//  ZisakuZiten
//
//  Created by unkonow on 2020/10/06.
//  Copyright © 2020 unkonow. All rights reserved.
//

import Foundation

class ShareAPI{
    init() {

    }
    
    enum Result:String {
        case ok = "ok"
        case ng = "ng"
    }
    
    let urlString = "https://http3.herokuapp.com/post"
//    let urlString = "http://127.0.0.1:8000/post"

    
    func post(params:String,result:@escaping(_ res: Result, _ id: String, _ passwd: String)->Void){
        let request = NSMutableURLRequest(url: URL(string: urlString)!)

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
        if jsonres == nil{
//            return (res: Result.ng, id: "", passwd: "")
        }else{
//            return (res: Result(rawValue: jsonres["res"] as! String)!, id: jsonres["id"] as! String, passwd: jsonres["passwd"] as! String)
        }
    }
    
    func parse(response: String){
        
        
        
    }
}
