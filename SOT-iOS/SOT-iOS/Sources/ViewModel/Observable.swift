//
//  Observable.swift
//  SOT-iOS
//
//  Created by 이숭인 on 2021/11/23.
//

import UIKit

class ObservableT<T> {
    var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: ((T) -> Void)?) {
        self.listener = listener
    }
    
    init(value: T){
        self.value = value
    }
}

