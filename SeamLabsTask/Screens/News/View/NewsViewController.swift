//
//  NewsViewController.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import UIKit
import RxSwift
import RxCocoa
class NewsViewController: BaseViewController {
    
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
        handleResponseStatus()
        setUpUI()
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
        viewModel?.articles.bind(to: newsTableView.rx.items(cellIdentifier: "NewsCell",cellType: NewsCell.self)) { (index,article,cell) in
            cell.setUpCell(article: article)
        }.disposed(by: disposeBag)
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
                let selectedDate = self?.datePicker.date.toString(dateFormat: "yyyy-MM-dd")
                self?.view.endEditing(true)
                self?.dateTextFiled.text = selectedDate
                self?.viewModel?.getArticles(fromDate: selectedDate ?? "")
            })
            .disposed(by: disposeBag)
    }
    private func handleResponseStatus() {
        viewModel?.showLoading
            .asDriver()
            .drive(onNext: { [weak self] isLoading in
                self?.showHud(showLoding: isLoading)
            })
            .disposed(by: disposeBag)
        viewModel?.isFailedToGetData.filter{!$0.isEmpty}
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] message in
                self?.showAlert(message: message)
            })
            .disposed(by: disposeBag)
    }
    private func setUpUI() {
        let currentDate = Date().toString(dateFormat: "yyyy-MM-dd")
        dateTextFiled.text = currentDate
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
