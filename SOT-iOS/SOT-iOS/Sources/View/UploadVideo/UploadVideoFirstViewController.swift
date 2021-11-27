//
//  UpoadVideoCategoryViewController.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/23.
//

import UIKit
import RxSwift

class UploadVideoFirstViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var viewModel = UploadVideoFirstViewModel()
    private let disposeBag = DisposeBag()
    
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
        $0.addTarget(self, action: #selector(goToNextVC), for: .touchUpInside)
    }
    
    private let locationLabel = UILabel().then {
        $0.text = "액티비티 장소는 어디인가요?"
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
        $0.attributedPlaceholder = NSAttributedString(string: "도시를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
    
    private let clearBtn = UIButton().then {
        $0.setImage(UIImage(named: "clearBtnImg"), for: .normal)
        $0.addTarget(self, action: #selector(clearBtnAction), for: .touchUpInside)
    }
    
    private let categoryLabel = UILabel().then {
        $0.text = "카테고리를 선택해주세요."
        $0.font = UIFont.SOTFont(type: .SDBold, size: 16)
        $0.textColor = .white
    }
    
    private let categoryCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionView()
        binding()
        bindingCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clearView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
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
        
        locationTextField.addSubview(clearBtn)
        clearBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
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
        
        view.addSubview(categoryCV)
        categoryCV.snp.makeConstraints {
            $0.height.equalTo(220)
            $0.top.equalTo(categoryLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .horizontal
        categoryCV.setCollectionViewLayout(layout, animated: false)
        categoryCV.backgroundColor = .black
        categoryCV.showsHorizontalScrollIndicator = false
        categoryCV.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    private func binding() {
        locationTextField.rx.text
            .bind(to: self.viewModel.input.locationInput)
            .disposed(by: disposeBag)
        
        categoryCV.rx.modelSelected(CategoryDataModel.self)
            .bind(onNext: { model in
                self.viewModel.input.categorySelectInput.onNext(model.title)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.nextButtonEnable
            .drive(onNext: { status in
                self.nextBtn.alpha = status ? 1 : 0.5
            })
            .disposed(by: disposeBag)
    }
    
    private func bindingCollectionView() {
        categoryCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.categoryListData
            .bind(to: categoryCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.categoryCV.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: IndexPath.init(row: row, section: 0)) as? CategoryCollectionViewCell {
                    cell.setData(model: item)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
    
    private func clearView() {
        locationTextField.text = ""
        categoryCV.allowsSelection = false
        categoryCV.allowsSelection = true
        view.endEditing(true)
    }
    
    @objc func goToNextVC() {
        self.navigationController?.pushViewController(UploadVideoSecondViewController(), animated: true)
    }
    
    @objc func clearBtnAction() {
        self.locationTextField.text = ""
    }
    
    @objc func closeBtnAction() {
        self.tabBarController?.selectedIndex = 0
    }
}

extension UploadVideoFirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 60) / 2, height: 100)
    }
}
