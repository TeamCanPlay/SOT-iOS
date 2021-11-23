//
//  UpoadVideoCategoryViewController.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/23.
//

import UIKit
import SnapKit
import Then

class UploadVideoFirstViewController: UIViewController {
    
    //MARK:- Properties
    
    private let closeBtn = UIButton().then {
        $0.setImage(UIImage(named: "closeBtnImg"), for: .normal)
    }
    
    private let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.SOTFont(type: .SDMed, size: 14)
        $0.alpha = 0.5
        $0.addTarget(self, action: #selector(goToNextVC), for: .touchUpInside)
    }
    
    private let locationLabel = UILabel().then {
        $0.text = "장소"
        $0.textColor = .white
        $0.font = UIFont.SOTFont(type: .SDBold, size: 16)
    }
    
    private let locationTextField = UITextField().then {
        $0.backgroundColor = .black
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.cornerRadius = 16
        
        $0.textColor = .white
        $0.attributedPlaceholder = NSAttributedString(string: "액티비티 장소를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        
        $0.clearButtonMode = .always
    }
    
    private let categoryLabel = UILabel().then {
        $0.text = "카테고리"
        $0.font = UIFont.SOTFont(type: .SDBold, size: 16)
        $0.textColor = .white
    }
    
    //MARK:- UI Components
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    //MARK:- Functions
    
    private func setUI() {
        view.backgroundColor = .black
        
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.height.equalTo(19)
            $0.top.equalTo(closeBtn.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(locationTextField)
        locationTextField.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(locationLabel.snp.bottom).offset(16)
        }
        
        view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.height.equalTo(19)
            $0.top.equalTo(locationTextField.snp.bottom).offset(44)
            $0.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.top.equalToSuperview().offset(58)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc func goToNextVC() {
        self.navigationController?.pushViewController(UploadVideoSecondViewController(), animated: true)
    }
}
