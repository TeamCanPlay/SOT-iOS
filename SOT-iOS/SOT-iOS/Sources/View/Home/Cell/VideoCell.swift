//
//  VideoCell.swift
//  SOT-iOS
//
//  Created by 이숭인 on 2021/11/23.
//

import UIKit
import SnapKit
import Then
import AVKit

class VideoCell: UICollectionViewCell {
    //MARK: - Properies
    static let identifier: String = "videoCell"
    var viewModel: HomeViewModelProtocol?
    
    //MARK: - UI Components
    let playerView = PlayerView().then{
        $0.backgroundColor = .black
    }
    
    let profileImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40 / 2
    }
    
    let nicknameLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.text = "nickname label"
        $0.textColor = .white
    }
    
    let locationLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.text = "location label"
        $0.textColor = .white
    }
    
    let contentLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.text = "Content Label test hahahhahaha"
        $0.textColor = .white
    }
    
    lazy var moreBtn = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "more"), for: .normal)
        $0.addTarget(self, action: #selector(moreBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var likeBtn = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "like"), for: .normal)
        $0.tag = 0
        $0.addTarget(self, action: #selector(btnBarPressed(_:)), for: .touchUpInside)
    }
    
    let likeLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .white
        $0.text = "12.4K"
    }
    
    let commentLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .white
        $0.text = "12.4K"
    }

    lazy var commentBtn = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "comment"), for: .normal)
        $0.tag = 1
        $0.addTarget(self, action: #selector(btnBarPressed(_:)), for: .touchUpInside)
    }
    
    lazy var shareBtn = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "share"), for: .normal)
        $0.tag = 2
        $0.addTarget(self, action: #selector(btnBarPressed(_:)), for: .touchUpInside)
    }
    
    lazy var playButton = UIButton().then{
        $0.setImage(UIImage(named: "pause"), for: .normal)
        $0.setImage(UIImage(named: "play"), for: .selected)
        $0.tintColor = .white
        $0.isSelected = false
        $0.addTarget(self, action: #selector(playBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var lookAroundBtn = UIButton().then{
        $0.layer.cornerRadius = 20.0
        $0.layer.borderWidth = 2.0
        $0.layer.borderColor = UIColor.white.cgColor
        $0.setTitle("액티비티 둘러보기", for: .normal)
        $0.setImage(UIImage(named: "rightArrow"), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
    }
    
    //MARK: - Life Cycle
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setUI()
        print("cell init  method")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    //MARK: - Functions
    @objc func btnBarPressed(_ sender: UIButton){
        switch sender.tag {
        case 0:
            print("like btn pressed")
            break
        case 1:
            print("comment btn pressed")
            break
        case 2:
            print("share btn pressed")
            break
        default:
            print("잘못된 입력입니당")
        }
    }
    
    @objc func moreBtnPressed(_ sender: UIButton){
        
    }
    
    @objc func playBtnPressed(_ sender: UIButton){
        guard let player = playerView.player else { return }
        if player.isPlaying {
            player.pause()
            self.playButton.isSelected = true
        }else{
            player.play()
            self.playButton.isSelected = false
        }
    }
    
    func setUI(){
        self.contentView.addSubview(playerView)
        self.contentView.addSubview(playButton)
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nicknameLabel)
        self.contentView.addSubview(locationLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(moreBtn)
        self.contentView.addSubview(likeBtn)
        self.contentView.addSubview(likeLabel)
        self.contentView.addSubview(commentBtn)
        self.contentView.addSubview(commentLabel)
        self.contentView.addSubview(shareBtn)
        self.contentView.addSubview(lookAroundBtn)
        
        playerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints{
            $0.top.equalTo(self.contentView.safeAreaLayoutGuide).offset(10.0)
            $0.leading.equalTo(self.contentView.safeAreaLayoutGuide).offset(20.0)
            $0.width.height.equalTo(40.0)
        }
        
        nicknameLabel.snp.makeConstraints{
            $0.top.equalTo(profileImageView.snp.top)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8.0)
        }
        
        locationLabel.snp.makeConstraints{
            $0.bottom.equalTo(profileImageView.snp.bottom)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8.0)
        }
        
        contentLabel.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(9.0)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8.0)
        }
        
        moreBtn.snp.makeConstraints{
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.trailing.equalTo(self.contentView.safeAreaLayoutGuide).offset(-20.0)
            $0.width.height.equalTo(24.0)
        }
        
        likeBtn.snp.makeConstraints{
            $0.trailing.equalTo(self.contentView.safeAreaLayoutGuide).offset(-24.0)
            $0.width.height.equalTo(24.0)
        }
        
        likeLabel.snp.makeConstraints{
            $0.top.equalTo(likeBtn.snp.bottom).offset(3.0)
            $0.centerX.equalTo(likeBtn.snp.centerX)
        }
        
        commentBtn.snp.makeConstraints{
            $0.top.equalTo(likeLabel.snp.bottom).offset(16.0)
            $0.centerX.equalTo(likeBtn.snp.centerX)
            $0.centerY.equalTo(self.contentView.snp.centerY).multipliedBy(1.5)
            $0.width.height.equalTo(24.0)
        }
        
        commentLabel.snp.makeConstraints{
            $0.top.equalTo(commentBtn.snp.bottom).offset(3.0)
            $0.centerX.equalTo(likeBtn.snp.centerX)
        }
        
        shareBtn.snp.makeConstraints{
            $0.top.equalTo(commentLabel.snp.bottom).offset(16.0)
            $0.centerX.equalTo(likeBtn.snp.centerX)
        }
        
        playButton.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.contentView.safeAreaLayoutGuide)
            $0.width.height.equalTo(100.0)
        }
        
        lookAroundBtn.snp.makeConstraints{
            $0.centerX.equalTo(self.contentView.snp.centerX)
            $0.bottom.equalTo(self.contentView.safeAreaLayoutGuide).offset(-32.0)
            $0.width.equalTo(256.0)
            $0.height.equalTo(36.0)
        }
    }
}
