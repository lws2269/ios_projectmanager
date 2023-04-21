//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    private let viewModel: MainViewModelRx = .init()
    private let disposeBag: DisposeBag = .init()
    
    private let todoListView: ListView = .init(viewModel: ListViewModel(category: .todo))
    private let doingListView: ListView = .init(viewModel: ListViewModel(category: .doing))
    private let doneListView: ListView = .init(viewModel: ListViewModel(category: .done))
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray3
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLayout()
        configureListView()
        configureBind()
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemGray6
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoListView)
        stackView.addArrangedSubview(doingListView)
        stackView.addArrangedSubview(doneListView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureListView() {
        [todoListView, doingListView, doneListView].forEach {
            $0.delegate = self
        }
    }
    
    private func configureBind() {
        viewModel.todoList
            .bind(to: todoListView.viewModel.workList)
            .disposed(by: disposeBag)
        viewModel.doingList
            .bind(to: doingListView.viewModel.workList)
            .disposed(by: disposeBag)
        viewModel.doneList
            .bind(to: doneListView.viewModel.workList)
            .disposed(by: disposeBag)
        
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        let workFormViewController = WorkFormViewController()
        let navigationViewController = UINavigationController(rootViewController: workFormViewController)
        
        workFormViewController.viewModel = WorkFormViewModel()
        workFormViewController.delegate = self
        navigationViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationViewController, animated: true)
    }
}

extension MainViewController: WorkFormDelegate, CellDelegate, ListViewDelegate {
    func deleteWork(work: Work) {
        viewModel.deleteWork(data: work)
    }
    
    func presentModal(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated)
    }
    
    func showPopover(soruceView: UIView?, work: Work?) {
        guard let work else { return }
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        viewModel.categoryToOthers(category: work.category).forEach { (category: Category, title: String) in
            actionSheet.addAction(UIAlertAction(title: title, style: .default, handler: { _ in
                self.viewModel.moveWork(data: work, category: category)
            }))
        }
        
        actionSheet.popoverPresentationController?.sourceView = soruceView
        present(actionSheet, animated: true)
    }
    
    func send(data: Work) {
        viewModel.updateWork(data: data)
    }
    
}
