//
//  UploadVideoFinalViewController.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import RxSwift
import RxCocoa

struct UploadVideoFinalViewModel: ViewModelType {
    
    let dependency: Dependency
    var disposeBag: DisposeBag = DisposeBag()
    let input: Input
    let output: Output
    
    struct Dependency {
    }
    
    struct Input {
        var textInput: AnyObserver<String?>
    }
    
    struct Output {
        var textCount: Driver<Int>
    }
    
    init(dependency: Dependency = Dependency()) {
        self.dependency = dependency
        
        let textInput$ = BehaviorSubject<String?>(value: nil)
        let textCount$ = textInput$.map(getTextCount).asDriver(onErrorJustReturn: 0)
        
        self.input = Input(textInput: textInput$.asObserver())
        self.output = Output(textCount: textCount$)
    }
}

private func getTextCount(textInput: String?) -> Int {
    guard let text = textInput else { return 0 }
    
    return text.count
}
