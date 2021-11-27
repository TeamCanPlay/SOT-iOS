//
//  UploadVideoFirstViewModel.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import RxSwift
import RxCocoa

struct UploadVideoFirstViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var locationInput: AnyObserver<String?>
        var categorySelectInput: AnyObserver<String?>
    }
    
    struct Output {
        var categoryListData: Observable<[CategoryDataModel]>
        var nextButtonEnable: Driver<Bool>
    }
    
    let categoryList: [CategoryDataModel] = [
        CategoryDataModel(title: "육상 액티비티"),
        CategoryDataModel(title: "수상 액티비티"),
        CategoryDataModel(title: "항공 액티비티"),
        CategoryDataModel(title: "기타")
    ]
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let locationInput$ = BehaviorSubject<String?>(value: nil)
        let categorySelectInput$ = BehaviorSubject<String?>(value: nil)
        let categoryListData$ = Observable<[CategoryDataModel]>.just(categoryList)
        
        let nextButtonEnable$ = Observable.combineLatest(locationInput$, categorySelectInput$).map(nextValidation).asDriver(onErrorJustReturn: false)
        
        self.input = Input(locationInput: locationInput$.asObserver(), categorySelectInput: categorySelectInput$.asObserver())
        self.output = Output(categoryListData: categoryListData$, nextButtonEnable: nextButtonEnable$)
    }
}

private func nextValidation(locationInput: String?, categorySelectInput: String?) -> Bool {
    
    guard let location = locationInput else { return false }
    guard let category = categorySelectInput else { return false }
    
    return !location.isEmpty && !category.isEmpty
}
