//
//  ActivityVideoRequest.swift
//  SOT-iOS
//
//  Created by 이숭인 on 2021/11/23.
//

import UIKit

struct ActivityVideoRequest {
    private var page: Int
    private var limit: Int
    
    var toDictionary: [String: Int] {
        let dict: [String: Int] = ["page": self.page,
                                   "limit": self.limit]
        return dict
    }
    
    init(page: Int, limit: Int){
        self.page = page
        self.limit = limit
    }
}
