//
//  ViewController.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/23.
//

import UIKit
import SnapKit
import Then
import AVFoundation



class HomeViewController: UIViewController {
    //MARK: - Properties

    let homeViewModel = HomeViewModel()
    private var videoIndex: VideoCell?
    
    //MARK: - UI Components
    
    private let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = .zero
        $0.minimumInteritemSpacing = .zero
    }
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.isPagingEnabled = true
        $0.contentInsetAdjustmentBehavior = .never
        $0.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        setUI()
        setBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false
        homeViewModel.requestActivityVideos()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        pauseVideo()
    }
    
    //MARK: - Functions

    private func setBind(){
        homeViewModel.videos.bind { videos in
            self.collectionView.reloadData()
        }
    }
    
    
    private func setUI(){
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    private func pauseVideo() {
        videoIndex?.playerView.player?.pause()
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.videos.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell else{
            return UICollectionViewCell()
        }
        
        return cell
    }

}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? VideoCell else { return }

        let videoURL = homeViewModel.videos.value[indexPath.row].videoUrl
        
        guard let url = URL(string: videoURL) else { return }
        
        let playerItem = AVPlayerItem(url: url) // item 생성
        let queuePlayer = AVQueuePlayer(playerItem: playerItem) //queue player 생성
        
        playerItem.preferredForwardBufferDuration = TimeInterval(0.5)
        videoIndex = cell
        cell.playerView.player = queuePlayer
        cell.playerView.playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        cell.playerView.player?.play()
        cell.playButton.isSelected = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? VideoCell else { return }
        
        cell.playerView.player?.pause()
        cell.playButton.isSelected = true
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    // cell의 width, height 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
}

