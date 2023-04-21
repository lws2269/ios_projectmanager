//
//  ListCellViewModel.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/17.
//

import UIKit
import RxSwift
import RxCocoa

final class ListCellViewModel {
    let work: BehaviorRelay<Work>
    let dateColor: Observable<UIColor>
//    var work: Work {
//        didSet {
//            cellHandler?(work)
//            colorHandler?(checkEndDateColor(date: work.endDate))
//        }
//    }

    private var cellHandler: ((Work) -> Void)?
    private var colorHandler: ((UIColor) -> Void)?
    
    init(work: Work) {
        self.work = .init(value: work)
        self.dateColor = self.work.map {
            $0.endDate < Date() ? UIColor.red : UIColor.black
        }.asObservable()
    }
    
    func pressEndedIsValid(state: UIGestureRecognizer.State, delegate: CellDelegate?, sourceView: UIView) {
        if state == .ended {
            delegate?.showPopover(soruceView: sourceView, work: work.value)
        }
    }
}
