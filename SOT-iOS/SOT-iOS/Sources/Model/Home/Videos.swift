//
//  Videos.swift
//  SOT-iOS
//
//  Created by 이숭인 on 2021/11/23.
//

import UIKit

struct Videos: Codable {
    let videos: [Video]
    
    enum CodingKeys: String, CodingKey {
        case videos = "result"
    }
}

struct Video: Codable {
    let videoIdx: Int // 비디오 인덱스
    let videoUrl: String // 비디오 url
    let userNickname: String // 유저 닉네임
    let userProfileImg: String // 유저 프로필 이미지
    let comment: String // 코멘트
    let location: String // 위치
    let heartCount: Int // 하트 수
    let reviewCount: Int // 리뷰 수
    
}
