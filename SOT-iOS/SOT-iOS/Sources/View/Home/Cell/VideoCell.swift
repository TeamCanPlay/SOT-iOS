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
    //MARK: - Properties
    
    //MARK: - Properies
    static let identifier: String = "videoCell"
    var viewModel: HomeViewModelProtocol?
    
    //MARK: - UI Components
    let playerView = PlayerView().then{
        $0.backgroundColor = .black
    }
    
    var topGraView = UILabel().then{
        $0.frame = CGRect(x: 0, y: 0, width: 450, height: 148)
    }
    
    var bottomGraView = UILabel().then{
        $0.frame = CGRect(x: 0, y: 0, width: 450, height: 220)
    }
    
    lazy var topGradient = CAGradientLayer().then{
        $0.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor,
                         UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor,
                         UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
                        ]
        $0.locations = [0, 0.5, 1]
        $0.bounds = self.topGraView.bounds
        $0.position = topGraView.center
    }
    
    lazy var bottomGradient = CAGradientLayer().then{
        $0.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor,
                         UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor,
                         UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
                        ]
        $0.locations = [0, 0.5, 1]
        $0.startPoint = CGPoint(x: 0.5, y: 1)
        $0.endPoint = CGPoint(x: 0.5, y: 0)
        $0.bounds = self.topGraView.bounds
        $0.position = topGraView.center
    }
    
    let profileImageView = UIImageView().then{
        $0.image = UIImage(named: "profile_test")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40 / 2
    }
    
    lazy var nicknameLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.text = "nickname label"
        $0.textColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shouldRasterize = true
    }
    
    let locationLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.text = "location label"
        $0.textColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shouldRasterize = true
    }
    
    let contentLabel = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.text = "Content Label test hahahhahaha"
        $0.textColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shouldRasterize = true
    }
    
    lazy var moreBtn = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "more"), for: .normal)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shouldRasterize = true
        $0.addTarget(self, action: #selector(moreBtnPressed(_:)), for: .touchUpInside)
    }
    
    lazy var likeBtn = UIButton().then{
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shouldRasterize = true
        $0.setBackgroundImage(UIImage(named: "like"), for: .normal)
        $0.tag = 0
        $0.addTarget(self, action: #selector(btnBarPressed(_:)), for: .touchUpInside)
    }
    
    let likeLabel = UILabel().then{
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shouldRasterize = true
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .white
        $0.text = "12.4K"
    }
    
    let commentLabel = UILabel().then{
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shouldRasterize = true
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .white
        $0.text = "12.4K"
    }

    lazy var commentBtn = UIButton().then{
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shouldRasterize = true
        $0.setBackgroundImage(UIImage(named: "comment"), for: .normal)
        $0.tag = 1
        $0.addTarget(self, action: #selector(btnBarPressed(_:)), for: .touchUpInside)
    }
    
    lazy var shareBtn = UIButton().then{
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowRadius = 2.0
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 1, height: 0)
        $0.layer.shouldRasterize = true
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
        $0.isHidden = true
    }
    
    lazy var lookAroundBtn = UIButton().then{
        $0.layer.cornerRadius = 22.0
        $0.layer.borderWidth = 2.0
        $0.layer.borderColor = UIColor.white.cgColor
        $0.setTitle("액티비티 둘러보기", for: .normal)
        $0.setImage(UIImage(named: "rightArrow"), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10.0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: -22)
    }
    
    lazy var blurView = UIImageView().then{
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        visualEffectView.frame = self.contentView.frame
        $0.addSubview(visualEffectView)
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
            self.playButton.isHidden = false
            self.playButton.isSelected = true
        }else{
            player.play()
            self.playButton.isSelected = false
        }
    }
  
    func setUI(){
        self.contentView.addSubview(playerView)
        self.contentView.addSubview(topGraView)
        self.contentView.addSubview(bottomGraView)
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
        topGraView.layer.addSublayer(topGradient)
        bottomGraView.layer.addSublayer(bottomGradient)
        
        playerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(56.0)
            $0.leading.equalTo(self.contentView.safeAreaLayoutGuide).offset(20.0)
            $0.width.height.equalTo(40.0)
        }
        
        topGraView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(topGraView.snp.width).multipliedBy(0.39466666666)
        }
        
        bottomGraView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(bottomGraView.snp.width).multipliedBy(0.39466666666)
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
            $0.top.equalTo(locationLabel.snp.bottom).offset(6.0)
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
            $0.width.height.equalTo(24.0)
        }
        
        commentLabel.snp.makeConstraints{
            $0.top.equalTo(commentBtn.snp.bottom).offset(3.0)
            $0.bottom.equalTo(shareBtn.snp.top).offset(-16.0)
            $0.centerX.equalTo(likeBtn.snp.centerX)
        }
        
        shareBtn.snp.makeConstraints{
            $0.bottom.equalTo(lookAroundBtn.snp.top).offset(-42.0)
            $0.centerX.equalTo(likeBtn.snp.centerX)
        }
        
        playButton.snp.makeConstraints{
            $0.centerX.centerY.equalTo(self.contentView.safeAreaLayoutGuide)
            $0.width.height.equalTo(100.0)
        }
        
        lookAroundBtn.snp.makeConstraints{
            $0.centerX.equalTo(self.contentView.snp.centerX)
            $0.bottom.equalTo(playerView.snp.bottom).offset(-120.0)
            $0.width.equalTo(256.0)
            $0.height.equalTo(44.0)
        }
    }
}
