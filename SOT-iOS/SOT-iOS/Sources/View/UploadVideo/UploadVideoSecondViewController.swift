//
//  UploadVideoSecondViewController.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/23.
//

import UIKit
import AVFoundation

class UploadVideoSecondViewController: UIViewController, RecordingDelegate {
    
    //MARK:- Properties
    
    private var videoURL: URL?
    private var recordingStatus = false
    private var tapGestureStatus = false
    var playerView: MediaPlayerView?
    let cameraManager = CameraManager()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.SOTFont(type: .SDMed, size: 14)
        $0.alpha = 0.5
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(nextBtnAction), for: .touchUpInside)
    }
    
    private let centerPlayBtn = UIImageView().then {
        $0.image = UIImage(named: "playBtnImg")
        $0.isHidden = true
    }
    
    private let lightBtn = UIButton().then {
        $0.setImage(UIImage(named: "lightOffBtnImg"), for: .normal)
    }
    
    private let galaryAndMusicBtn = UIButton().then {
        $0.setImage(UIImage(named: "galaryBtnImg"), for: .normal)
    }
    
    private let turnAndSoundBtn = UIButton().then {
        $0.setImage(UIImage(named: "turnBtnImg"), for: .normal)
    }
    
    private let preView = UIView()
    
    private let recordingBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 36
        $0.addTarget(self, action: #selector(recordingBtnAction), for: .touchUpInside)
    }
    
    private let recordingStopView = UIView().then {
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 28
        $0.isUserInteractionEnabled = false
        $0.isHidden = true
    }
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pauseVideo()
    }
    
    //MARK:- Functions
    
    private func setupView() {
        if cameraManager.cameraAndAudioAccessPermitted {
            setUpSession()
        } else {
            askForCameraAccess()
            askForMicrophoneAccess()
        }
    }
    
    private func setUpSession(){
        cameraManager.delegate = self
        cameraManager.addPreviewLayerToView(view: preView)
        view.sendSubviewToBack(preView)
    }
    
    private func askForCameraAccess(){
        cameraManager.askForCameraAccess({ access in
            if access {
                if self.cameraManager.cameraAndAudioAccessPermitted {
                    self.setUpSession()
                }
            }
        })
    }
    
    private func askForMicrophoneAccess(){
        cameraManager.askForMicrophoneAccess({ access in
            if access {
                if self.cameraManager.cameraAndAudioAccessPermitted {
                    self.setUpSession()
                }
            }
        })
    }
    
    func finishRecording(_ videoURL: URL?) {
        self.videoURL = videoURL
        presentPlayerView()
    }
    
    private func presentPlayerView(){
        if let url = videoURL {
            playerView = MediaPlayerView(frame: preView.frame, videoURL: url)
            playerView!.tag = 1
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentTapGestureAction))
            playerView?.addGestureRecognizer(tapGesture)
            view.addSubview(playerView!)
            view.bringSubviewToFront(backBtn)
            view.bringSubviewToFront(nextBtn)
            view.bringSubviewToFront(galaryAndMusicBtn)
            view.bringSubviewToFront(turnAndSoundBtn)
            view.bringSubviewToFront(centerPlayBtn)
            nextBtn.alpha = 1
            playerView?.play()
        }
    }
    
    private func setUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
        
        view.addSubview(preView)
        preView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(lightBtn)
        lightBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(58)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(galaryAndMusicBtn)
        galaryAndMusicBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview().offset(60)
            $0.bottom.equalToSuperview().offset(-86)
        }
        
        view.addSubview(recordingBtn)
        recordingBtn.snp.makeConstraints {
            $0.width.height.equalTo(72)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-62)
        }
        
        recordingBtn.addSubview(recordingStopView)
        recordingStopView.snp.makeConstraints {
            $0.width.height.equalTo(56)
            $0.centerX.centerY.equalToSuperview()
        }
        
        view.addSubview(turnAndSoundBtn)
        turnAndSoundBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.trailing.equalToSuperview().inset(60)
            $0.bottom.equalToSuperview().offset(-86)
        }
        
        view.addSubview(centerPlayBtn)
        centerPlayBtn.snp.makeConstraints {
            $0.top.equalTo(lightBtn.snp.bottom).offset(232)
            $0.bottom.equalTo(galaryAndMusicBtn.snp.top).offset(-260)
            $0.leading.equalTo(galaryAndMusicBtn.snp.trailing).offset(38)
            $0.trailing.equalTo(turnAndSoundBtn.snp.leading).offset(-37)
        }
    }
    
    private func pauseVideo() {
        guard let presentView = self.view.viewWithTag(1) as? MediaPlayerView else { return }
        presentView.pause()
    }
    
    @objc func recordingBtnAction() {
        switch recordingStatus {
        case false:
            recordingStatus.toggle()
            cameraManager.startRecording()
            galaryAndMusicBtn.setImage(UIImage(named: "galaryBtnImg"), for: .normal)
            turnAndSoundBtn.setImage(UIImage(named: "turnBtnImg"), for: .normal)
            nextBtn.alpha = 0.5
            recordingStopView.isHidden = false
        case true:
            recordingStatus.toggle()
            cameraManager.stopRecording()
            galaryAndMusicBtn.setImage(UIImage(named: "musicBtnImg"), for: .normal)
            turnAndSoundBtn.setImage(UIImage(named: "soundBtnImg"), for: .normal)
            nextBtn.alpha = 1
            nextBtn.isEnabled = true
            recordingStopView.isHidden = true
        }
    }
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func nextBtnAction() {
        self.navigationController?.pushViewController(UploadVideoFinalViewController(), animated: true)
    }
    
    @objc func presentTapGestureAction() {
        let presentView = self.view.viewWithTag(1) as! MediaPlayerView
        switch tapGestureStatus {
        case false:
            tapGestureStatus.toggle()
            presentView.pause()
            centerPlayBtn.isHidden = false
        case true:
            tapGestureStatus.toggle()
            presentView.play()
            centerPlayBtn.isHidden = true
        }
    }
}
