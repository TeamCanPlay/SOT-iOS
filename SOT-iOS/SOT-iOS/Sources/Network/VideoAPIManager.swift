//
//  VideoAPIManager.swift
//  SOT-iOS
//
//  Created by 이숭인 on 2021/11/23.
//

import UIKit
import Alamofire

enum RequestType{
    static let videoActivity = "/activity-video"
}

class VideoAPIManager {
    static let shared = VideoAPIManager()
    private init(){ }
    
    private let baseURL = "https://playteam.site"
    
    func requestActivityVideo(parameter: ActivityVideoRequest, completion: @escaping (Videos)->(Void)){
        let requestURL = baseURL + RequestType.videoActivity
        
        AF.request(requestURL, method: .get,parameters: parameter.toDictionary, encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(Videos.self, from: jsonData)

                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
    
}
