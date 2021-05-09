//
//  DetailViewController.swift
//  SearchApp
//
//  Created by Cem Kazım on 6.05.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties -
    
    private var scrollableStackView: ScrollableStackView = {
        let view = ScrollableStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var detailImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    private var detailNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var detailHeaderLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [detailPriceLabel, detailGenreLabel, detailReleaseDateLabel])
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private var detailPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private var detailGenreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private var detailReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private var detailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    public var detailViewModel: DetailViewModel?
    
    // MARK: - Lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods -
    
    private func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        loadDataIntoViews()
    }
    
    private func addSubviews() {
        view.addSubview(scrollableStackView)
        scrollableStackView.addViewToStackView(detailImageView)
        scrollableStackView.addViewToStackView(detailNameLabel)
        scrollableStackView.addViewToStackView(detailHeaderLabelStackView)
        scrollableStackView.addViewToStackView(detailDescriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollableStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollableStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollableStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            detailImageView.centerXAnchor.constraint(equalTo: scrollableStackView.centerXAnchor),
            detailImageView.heightAnchor.constraint(equalToConstant: 200),
            
            detailNameLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 20),
            detailNameLabel.centerXAnchor.constraint(equalTo: scrollableStackView.centerXAnchor),
            
            detailHeaderLabelStackView.topAnchor.constraint(equalTo: detailNameLabel.bottomAnchor, constant: 20),
            detailHeaderLabelStackView.centerXAnchor.constraint(equalTo: scrollableStackView.centerXAnchor),
            
            detailDescriptionLabel.topAnchor.constraint(equalTo: detailHeaderLabelStackView.bottomAnchor, constant: 20),
            detailDescriptionLabel.centerXAnchor.constraint(equalTo: scrollableStackView.centerXAnchor)
        ])
    }
    
    private func loadDataIntoViews() {
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
