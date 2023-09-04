//
//  NewsViewController.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import UIKit
import RxSwift
import RxCocoa
class NewsViewController: UIViewController {
    
    @IBOutlet weak var dateTextFiled: UITextField!
    @IBOutlet weak var newsTableView: UITableView!
    weak var coordinator: NewsCoordinatorNavigaitons?
    var viewModel: NewsViewModel?
    private let disposeBag = DisposeBag()
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNewsTableView()
        setUpDatePicker()
    }
    private func configureNewsTableView() {
        registerCell()
        bindAritclesData()
    }
    private func registerCell() {
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        newsTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindAritclesData() {
        
    }
    private func didSelectAricle() {
        
    }
    private func setUpDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
       
        dateTextFiled.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                self?.dateTextFiled.inputView = self?.datePicker
            })
            .disposed(by: disposeBag)
        
        datePicker.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.dateTextFiled.text = self?.datePicker.date.description
                print(self?.datePicker.date)
            })
            .disposed(by: disposeBag)
    }
   }

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
