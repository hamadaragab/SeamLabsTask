//
//  NewsViewModel.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
import RxSwift
import RxCocoa
class NewsViewModel {
    private let disposeBag = DisposeBag()
    let newsServices : NewsServicesProtocol?
    let showLoading = BehaviorRelay<Bool>(value: false)
    let isFailedToGetData = BehaviorRelay<String>(value: "")
    let articles = BehaviorRelay<[Articles]>(value: [])
    lazy var dataBaseManager:DatabaseManager = {
        return DatabaseManager(context: PersistenceController.shared.container.viewContext)
    }()
    init(newsServices: NewsServicesProtocol? = NewsServices()){
        self.newsServices = newsServices
        // get Articles At Constants.testDate = "2023-08-24"
        getArticles(fromDate: Constants.testDate)
    }
    
    func getArticles(fromDate: String)  {
        self.showLoading.accept(true)
        self.articles.accept([])
        self.newsServices?.getArticles(fromDate: fromDate, completion: {[weak self] articles, error in
            guard let self = self else {return}
            self.showLoading.accept(false)
            if let articles = articles{
                self.articles.accept(articles)
                self.saveArticles(articles: articles)
            }else if let error = error, error == .NoInternet {
                self.isFailedToGetData.accept(error.rawValue)
                self.retrieveArticles()
            }else {
                self.isFailedToGetData.accept(error?.rawValue ?? "")
            }
        })
    }
    private func saveArticles(articles:[Articles]){
        dataBaseManager.saveNewArticls(articles)
    }
    private func retrieveArticles(){
        let savedArticles = dataBaseManager.fetchSavedArticles()
        self.articles.accept(savedArticles)
    }
}
