//
//  WokrFormViewModelRx.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/04/21.
//

import UIKit
import RxSwift
import RxCocoa

final class WorkFormViewModel {
    var work: BehaviorRelay<Work?>
    var isEdit: BehaviorRelay<Bool>
    var textColor: Observable<UIColor>
    
    init(work: Work? = nil, isEdit: Bool = true) {
        self.work = BehaviorRelay(value: work)
        self.isEdit = BehaviorRelay(value: isEdit)
        self.textColor = self.isEdit.map({
            $0 ? UIColor.black : UIColor.systemGray3
        }).asObservable()
    }
    
    func updateWork(title: String?, body: String?, date: Date) {
        if let work = work.value {
            self.work.accept(Work(id: work.id, category: work.category, title: title, body: body, endDate: date))
        } else {
            work.accept(Work(category: .todo, title: title, body: body, endDate: date))
        }
    }
}
