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
    let showLoading = BehaviorRelay<Bool>(value: false)
    let isFailedToGetData = BehaviorRelay<String>(value: "")
    let articles = BehaviorRelay<[Articles]>(value: [])
    lazy var dataBaseManager:DatabaseManager = {
       return DatabaseManager(context: PersistenceController.shared.container.viewContext)
    }()

    init(){
        getArticles(fromDate: "2023-08-24")
    }
     func getArticles(fromDate: String) {
        self.showLoading.accept(true)
         self.articles.accept([])
        let newsURL = "https://newsapi.org/v2/everything?q=tesla&from=\(fromDate)&sortBy=publishedAt&apiKey=ce637c49af384243b6907c0b26147f22"
        NetworkManager.makeRequest(withURL: newsURL, responseType: ArticlesResponseData.self, method: .GET
                          , parameters: nil)
        .subscribe(onNext: { [weak self] response in
            self?.showLoading.accept(false)
            self?.didGetArticle(response: response)
        }, onError: {[weak self]  error in
            self?.showLoading.accept(false)
            self?.didFalidToGetArticles(error: error)
        })
        .disposed(by: disposeBag)
    }
    private func didGetArticle(response: ArticlesResponseData) {
        guard let status = response.status, status == "ok" else {
            self.isFailedToGetData.accept("error Status not Ok")
            return
        }
        if let articles = response.articles , !articles.isEmpty {
            self.articles.accept(articles)
            self.saveArticles(articles: articles)
        }else {
            self.isFailedToGetData.accept("No articles found please select another Date")
        }
    }
    private func didFalidToGetArticles(error: Error) {
        guard let error = error as? ErrorStatus else {return}
           if error == .NoInternet {
               // get article from Core Data
               self.isFailedToGetData.accept(error.rawValue)
               retrieveArticles()
        }else {
            self.isFailedToGetData.accept(error.rawValue)
        }
    }
    private func saveArticles(articles:[Articles]){
        dataBaseManager.saveNewArticls(articles)
    }
    private func retrieveArticles(){
        let savedArticles = dataBaseManager.fetchSavedArticles()
        self.articles.accept(savedArticles)
    }
}
