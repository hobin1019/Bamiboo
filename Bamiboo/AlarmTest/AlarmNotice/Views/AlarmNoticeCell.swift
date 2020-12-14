//
//  AlarmNoticeCell.swift
//  Bamiboo
//
//  Created by 한호빈 on 2020/12/11.
//

import UIKit


struct AlarmNoticeItem {
    var title: String = ""
    var time: String = ""
    var contents: String = ""
}

class AlarmNoticeCell: UICollectionViewCell {
    
    // MARK: Views
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 19.0)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .lightGray
        return label
    }()
    private lazy var contentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var lineViews: [UIView] = {
        var views: [UIView] = []
        for i in 0..<2 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .lightGray
            views.append(view)
        }
        return views
    }()
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(contentsView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(iconImageView)
        titleView.addSubview(timeLabel)
        contentsView.addSubview(lineViews[0])
        contentsView.addSubview(lineViews[1])
        contentsView.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: iconImageView.leadingAnchor, constant: -10),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1),
            iconImageView.firstBaselineAnchor.constraint(equalTo: titleLabel.firstBaselineAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            timeLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -8),
            
            lineViews[0].topAnchor.constraint(equalTo: contentsView.topAnchor),
            lineViews[0].leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            lineViews[0].trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor),
            lineViews[0].heightAnchor.constraint(equalToConstant: 0.5),
            
            contentLabel.topAnchor.constraint(equalTo: lineViews[0].bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: lineViews[0].leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: lineViews[0].trailingAnchor),
            
            lineViews[1].topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            lineViews[1].leadingAnchor.constraint(equalTo: lineViews[0].leadingAnchor),
            lineViews[1].trailingAnchor.constraint(equalTo: lineViews[0].trailingAnchor),
            lineViews[1].heightAnchor.constraint(equalToConstant: 0.5),
            lineViews[1].bottomAnchor.constraint(equalTo: contentsView.bottomAnchor),
        ])
        
        contentsView.isHidden = true
    }
    
    
    // MARK: Public Functions
    func setData(data: AlarmNoticeItem) {
        titleLabel.text = data.title
        timeLabel.text = data.time
        contentLabel.text = data.contents
    }
    
    func setContentsView(isHidden: Bool) {
        contentsView.isHidden = isHidden
        iconImageView.image = UIImage(systemName: isHidden ? "xmark" : "message")
    }
}
