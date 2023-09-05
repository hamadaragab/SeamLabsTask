//
//  NeswDetailsViewController.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Cosmos
class NeswDetailsViewController: BaseViewController {
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var rateText: UITextView!
    @IBOutlet weak var articleTime: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var ArticleContent: UILabel!
    @IBOutlet weak var ArticleTitle: UILabel!
    @IBOutlet weak var articleImge: UIImageView!
    @IBOutlet weak var rateme: UIButton!
    weak var coordinator: NewsDateilsCoordinatorNavigaitons?
    var viewModel: NeswDetailsViewModel?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindArticleData()
        setUpUi()
        rateArticle()
        bindRatingData()
    }
    private func bindRatingData() {
        rateText.rx.text.orEmpty.bind(to: viewModel!.rateText).disposed(by: disposeBag)
        rateView.rx.didFinishTouchingCosmos.onNext {[weak self] rating in
            self?.viewModel?.rateValue.accept(rating)
        }
        viewModel?.validationMessage.asDriver(onErrorJustReturn: "").drive(onNext: { [weak self] messgae in
            self?.showAlert(message: messgae)
        }).disposed(by: disposeBag)
        viewModel?.didRateArticle.asDriver(onErrorJustReturn: ()).drive(onNext: { [weak self] _ in
            self?.showAlert(message: "Article successfully Rated !")
        }).disposed(by: disposeBag)
    }
    private func bindArticleData() {
        viewModel?.selectedArticle.subscribe(onNext: {[weak self] articleData in
            self?.articleImge.setImage(from: articleData?.urlToImage ?? "")
            self?.articleTime.text = (articleData?.publishedAt ?? "").converStringDateFromFormatToAnotherFormat(fromFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", toFormat: "yyyy-MM-dd")
            self?.ArticleTitle.text = articleData?.title ?? ""
            self?.ArticleContent.text = articleData?.content ?? ""
            self?.articleAuthor.text = "by  " + (articleData?.author ?? "")
        }).disposed(by: disposeBag)
    }
    private func setUpUi() {
        articleAuthor.adjustsFontSizeToFitWidth = true
        articleTime.adjustsFontSizeToFitWidth = true
    }
    private func rateArticle() {
        rateme.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.viewModel?.rateArticle()
        }).disposed(by: disposeBag)
    }
    
}
