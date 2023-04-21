//
//  WorkFormViewController.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/13.
//

import UIKit
import RxSwift

protocol WorkFormDelegate: AnyObject {
    func send(data: Work)
}

final class WorkFormViewController: UIViewController {
    var viewModel: WorkFormViewModel?
    private let disposeBag = DisposeBag()
    weak var delegate: WorkFormDelegate?
    
    private let leftBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        return button
    }()
    
    private let rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "done"
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.backgroundColor = .systemBackground
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowOpacity = 0.3
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.clipsToBounds = false
        textView.backgroundColor = .systemBackground
        textView.layer.shadowOffset = CGSize(width: 0, height: 3)
        textView.layer.shadowOpacity = 0.3
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyTextView.delegate = self
        configureNavigationBar()
        configureLayout()
        configureBind()
    }
    
    private func configureBind() {
        if viewModel?.work.value != nil {
            leftBarButton.title = "edit"
            
            leftBarButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.viewModel?.isEdit
                        .accept(!(self?.viewModel?.isEdit.value ?? false))
                })
                .disposed(by: disposeBag)
        } else {
            leftBarButton.title = "cancel"
            leftBarButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.dismiss(animated: true)
                })
                .disposed(by: disposeBag)
        }
        
        rightBarButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel?.updateWork(title: self?.titleTextField.text,
                                      body: self?.bodyTextView.text,
                                      date: self?.datePicker.date ?? Date())
                self?.delegate?.send(data: (self?.viewModel?.work.value)!)
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        viewModel?.isEdit
            .subscribe(onNext: { [weak self] isEdit in
                self?.titleTextField.isEnabled = isEdit
                self?.bodyTextView.isEditable = isEdit
                self?.datePicker.isEnabled = isEdit
            })
            .disposed(by: disposeBag)
        
        viewModel?.textColor
            .subscribe(onNext: { [weak self] color in
                self?.titleTextField.textColor = color
                self?.bodyTextView.textColor = color
            })
            .disposed(by: disposeBag)
        
        viewModel?.work
            .subscribe(onNext: { [weak self] work in
                self?.titleTextField.text = work?.title
                self?.bodyTextView.text = work?.body
                self?.datePicker.date = work?.endDate ?? Date()
                self?.viewModel?.isEdit.accept((work == nil) ? true : false)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.navigationBar.backgroundColor = .systemGray5
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(bodyTextView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension WorkFormViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 1000 {
            textView.deleteBackward()
        }
    }
}
