//
//  DetailViewController.swift
//  SearchApp
//
//  Created by Cem Kazım on 6.05.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var scrollableStackView: ScrollableStackView = {
        let view = ScrollableStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var detailImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    var detailNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    lazy var detailHeaderLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [detailPriceLabel, detailGenreLabel, detailReleaseDateLabel])
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    var detailPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var detailGenreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var detailReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var detailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
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
        addSubviews()
        setupConstraints()
        loadDataIntoViews()
    }
    
    func addSubviews() {
        view.addSubview(scrollableStackView)
        scrollableStackView.stackView.addArrangedSubview(detailImageView)
        scrollableStackView.stackView.addArrangedSubview(detailNameLabel)
        scrollableStackView.stackView.addArrangedSubview(detailHeaderLabelStackView)
        scrollableStackView.stackView.addArrangedSubview(detailDescriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollableStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollableStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollableStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            detailImageView.centerXAnchor.constraint(equalTo: scrollableStackView.stackView.centerXAnchor),
            detailImageView.heightAnchor.constraint(equalToConstant: 200),
            
            detailNameLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 20),
            detailNameLabel.centerXAnchor.constraint(equalTo: scrollableStackView.stackView.centerXAnchor),
            
            detailHeaderLabelStackView.topAnchor.constraint(equalTo: detailNameLabel.bottomAnchor, constant: 20),
            detailHeaderLabelStackView.centerXAnchor.constraint(equalTo: scrollableStackView.stackView.centerXAnchor),
            
            detailDescriptionLabel.topAnchor.constraint(equalTo: detailHeaderLabelStackView.bottomAnchor, constant: 20),
            detailDescriptionLabel.centerXAnchor.constraint(equalTo: scrollableStackView.stackView.centerXAnchor)
        ])
    }
    
    func loadDataIntoViews() {
        if let model = detailViewModel?.searchItemModel {
            detailImageView.sd_setImage(with: model.imageURL, completed: nil)
            detailNameLabel.text = model.name
            detailPriceLabel.text = model.price
            detailGenreLabel.text = model.genre
            detailDescriptionLabel.text = model.description
            detailReleaseDateLabel.text = model.releaseDate
        }
    }
}
