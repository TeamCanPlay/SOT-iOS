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
    
    private let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
        $0.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.SOTFont(type: .SDMed, size: 14)
        $0.alpha = 0.5
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
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setUI()
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
            view.bringSubviewToFront(closeBtn)
            view.bringSubviewToFront(nextBtn)
            view.bringSubviewToFront(galaryAndMusicBtn)
            view.bringSubviewToFront(turnAndSoundBtn)
            view.bringSubviewToFront(centerPlayBtn)
            nextBtn.alpha = 1
            playerView?.play()
        }
    }
    
    private func setUI() {
        view.backgroundColor = .black
        
        view.addSubview(preView)
        preView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
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
    
    @objc func recordingBtnAction() {
        switch recordingStatus {
        case false:
            recordingStatus.toggle()
            cameraManager.startRecording()
            galaryAndMusicBtn.setImage(UIImage(named: "galaryBtnImg"), for: .normal)
            turnAndSoundBtn.setImage(UIImage(named: "turnBtnImg"), for: .normal)
            nextBtn.alpha = 0.5
        case true:
            recordingStatus.toggle()
            cameraManager.stopRecording()
            galaryAndMusicBtn.setImage(UIImage(named: "musicBtnImg"), for: .normal)
            turnAndSoundBtn.setImage(UIImage(named: "soundBtnImg"), for: .normal)
            nextBtn.alpha = 1
        }
    }
    
    @objc func closeBtnAction() {
        self.navigationController?.popViewController(animated: true)
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
