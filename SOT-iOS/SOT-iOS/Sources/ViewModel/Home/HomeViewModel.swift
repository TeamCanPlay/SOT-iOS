//
//  HomeViewModel.swift
//  SOT-iOS
//
//  Created by 이숭인 on 2021/11/23.
//

import UIKit
import AVFoundation

protocol HomeViewModelProtocol{
//    func play()
//    func pause()
//    func reset()
//    func getPlayer()->AVPlayer
//    func replaceCurrentItem(url: String)
}

class HomeViewModel: HomeViewModelProtocol {
    //MARK: - Properties
    private let videoApiManager = VideoAPIManager.shared
    var videos: ObservableT<[Video]> = ObservableT(value: [])
    
    //MARK: - Functions
    
    func requestActivityVideos(){
        //TODO: 파라미터 넣어서 서버로 request , 일단은 더미쿼리 넣장
        let dummyQuery = ActivityVideoRequest(page: 0, limit: 5)
        videoApiManager.requestActivityVideo(parameter: dummyQuery){ response in
            self.videos.value.append(contentsOf: response.videos) // 재생할 비디오 목록 추가
        }
    }
}
