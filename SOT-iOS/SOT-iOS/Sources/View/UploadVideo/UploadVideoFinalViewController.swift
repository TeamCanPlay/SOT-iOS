//
//  UploadVideoFinalViewController.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import UIKit
import RxSwift

class UploadVideoFinalViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = UploadVideoFinalViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK:- UI Components
    
    private let backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtnImg"), for: .normal)
    }
    
    private let explainLabel = UILabel().then {
        $0.text = "설명"
        $0.textColor = .white
        $0.font = UIFont.SOTFont(type: .SDBold, size: 16)
    }
    
    private let explainTextView = UITextView().then {
        $0.text = "액티비티에 대해 설명해주세요."
        $0.font = UIFont.SOTFont(type: .SDMed, size: 16)
        $0.textColor = UIColor.white.withAlphaComponent(0.5)
        $0.textContainerInset = UIEdgeInsets(top: 22, left: 16, bottom: 16, right: 0)
        $0.backgroundColor = .black
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        $0.layer.cornerRadius = 16
    }
    
    private let explainTextCount = UILabel().then {
        $0.text = "0/50"
        $0.font = UIFont.SOTFont(type: .SDMed, size: 12)
        $0.textColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    private let completeBtn = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.SOTColor.sotPurple
        $0.layer.cornerRadius = 16
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    //MARK:- Functions
    
    private func setUI() {
        view.backgroundColor = .black
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(explainLabel)
        explainLabel.snp.makeConstraints {
            $0.height.equalTo(19)
            $0.top.equalTo(backBtn.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(explainTextView)
        explainTextView.snp.makeConstraints {
            $0.height.equalTo(98)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(explainLabel.snp.bottom).offset(16)
        }
        
        view.addSubview(explainTextCount)
        explainTextCount.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(explainTextView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(completeBtn)
        completeBtn.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview().offset(-62)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
    }
    
    private func binding() {
        let initText = "액티비티에 대해 설명해주세요."
        
        explainTextView.rx.text
            .orEmpty
            .bind(onNext: { text in
                if text != initText && text != "" {
                    self.viewModel.input.textInput.onNext(text)
                }
            })
            .disposed(by: disposeBag)
        
        explainTextView.rx.didBeginEditing
            .bind {
                self.explainTextView.textColor = .white
                self.explainTextView.layer.borderColor = UIColor.white.cgColor
                if self.explainTextView.text == initText {
                    self.explainTextView.text = ""
                }
            }
            .disposed(by: disposeBag)
        
        explainTextView.rx.didEndEditing
            .bind {
                if self.explainTextView.text == "" {
                    self.explainTextView.text = initText
                    self.explainTextView.textColor = UIColor.white.withAlphaComponent(0.5)
                }
                self.explainTextView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            }
            .disposed(by: disposeBag)
        
        explainTextView.rx.text
            .orEmpty
            .scan("") { (previous, new) -> String in
                if new.count > 50 {
                    return previous ?? String(new.prefix(50))
                } else {
                    return new
                }
            }
            .subscribe(explainTextView.rx.text)
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        completeBtn.rx.tap
            .bind {
                self.tabBarController?.selectedIndex = 0
                self.navigationController?.popToRootViewController(animated: false)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.textCount
            .drive(onNext: { count in
                self.explainTextCount.text = "\(count)/50"
            })
            .disposed(by: disposeBag)
    }
}
