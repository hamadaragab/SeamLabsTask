//
//  NewsCell.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var articleDescriptions: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(article: Articles) {
        self.articleTitle.text = article.title ?? ""
        self.articleDescriptions.text = article.description ?? ""
        self.articleImage.setImage(from: article.urlToImage ?? "")
    }
}
