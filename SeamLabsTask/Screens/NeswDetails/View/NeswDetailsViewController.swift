//
//  NeswDetailsViewController.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import UIKit
import RxSwift
import RxCocoa
class NeswDetailsViewController: BaseViewController {
    @IBOutlet weak var articleTime: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var ArticleContent: UILabel!
    @IBOutlet weak var ArticleTitle: UILabel!
    @IBOutlet weak var articleImge: UIImageView!
    weak var coordinator: NewsDateilsCoordinatorNavigaitons?
    var viewModel: NeswDetailsViewModel?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindArticleData()
        setUpUi()
    }
    private func bindArticleData() {
        viewModel?.selectedArticle.subscribe(onNext: {[weak self] articleData in
            self?.articleImge.setImage(from: articleData?.urlToImage ?? "")
            self?.articleTime.text = (articleData?.publishedAt ?? "").converStringDateFromFormatToAnotherFormat(fromFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", toFormat: "yyyy-MM-dd")
            self?.ArticleTitle.text = articleData?.title ?? ""
            self?.ArticleContent.text = articleData?.content ?? ""
            self?.articleAuthor.text = articleData?.author ?? ""
        }).disposed(by: disposeBag)
    }
    private func setUpUi() {
        articleAuthor.adjustsFontSizeToFitWidth = true
        articleTime.adjustsFontSizeToFitWidth = true
    }
  
}
