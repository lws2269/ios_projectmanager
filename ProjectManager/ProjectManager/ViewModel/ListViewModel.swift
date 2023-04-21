//
//  ListViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/18.
//

import RxSwift
import RxCocoa

class ListViewModel {
    let category: Category
    let workList: BehaviorRelay<[Work]> = .init(value: [])
    let categoryCount: Observable<Int>
    
    init(category: Category) {
        self.category = category
        categoryCount = workList.map { works in
            works.count
        }.asObservable()
    }
}
