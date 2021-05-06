//
//  DetailViewController.swift
//  SearchApp
//
//  Created by Cem Kazım on 6.05.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailItemImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    var detailItemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var detailItemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var detailItemReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    var detailViewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        setupConstraints()
        loadDataIntoViews()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
    
    func loadDataIntoViews() {
        if let model = detailViewModel?.searchItemModel {
            detailItemImageView.sd_setImage(with: model.imageURL, completed: nil)
            detailItemNameLabel.text = model.name
            detailItemPriceLabel.text = model.price
            detailItemReleaseDateLabel.text = model.releaseDate
        }
    }
}
