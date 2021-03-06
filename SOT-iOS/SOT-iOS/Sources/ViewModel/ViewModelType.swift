//
//  ViewModelType.swift
//  SOT-iOS
//
//  Created by 한상진 on 2021/11/28.
//

import RxSwift

protocol ViewModelType {
    associatedtype Dependency
    associatedtype Input
    associatedtype Output
    
    var dependency: Dependency { get }
    var disposeBag: DisposeBag { get set}
    
    var input: Input { get }
    var output: Output { get }
    
    init(dependency: Dependency)
}
