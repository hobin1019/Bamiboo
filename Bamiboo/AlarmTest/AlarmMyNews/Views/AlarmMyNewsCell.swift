//
//  AlarmMyNewsCell.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import UIKit


class AlarmMyNewsCell: UICollectionViewCell {
    
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .left
        l.textColor = .white
        l.font.withSize(100)
        l.numberOfLines = 2
        l.text = ""
        return l
    }()
    private var timeLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .left
        l.textColor = .lightGray
        l.text = ""
        return l
    }()
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.backgroundColor = .black
        
        self.addSubview(titleLabel)
        self.addSubview(timeLabel)
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            // titleLabel
            titleLabel.firstBaselineAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            // timeLabel
            timeLabel.firstBaselineAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            // imageView
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])
    }
    
    
    func setData(data: AlarmMyNewsItem) {
        titleLabel.text = data.getTitle()
        timeLabel.text = data.getTime()
        
        if let url = data.getImageUrl() {
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}


struct AlarmMyNewsItem {
    private var title: String!
    private var imageUrl: String!
    private var time: String!
    
    init(title: String, imageUrl: String, time: String) {
        self.title = title
        self.imageUrl = imageUrl
        self.time = time
    }
    
    
    // ------ get Functions
    func getTitle() -> String? {
        return title
    }
    
    func getImageUrl() -> URL? {
        return URL(string: imageUrl)
    }
    
    func getTime() -> String? {
        if time == nil { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        guard let timeDate = formatter.date(from: time) else {return nil}
        
        let nowDate = Date()
        let nowStr = formatter.string(from: nowDate)
        
        let diff = Calendar.current.dateComponents([.day, .hour, .second], from: timeDate, to: nowDate)
        if nowStr == time {
            return "\(diff.hour ?? 0)시간 전"
        } else if (diff.day ?? 0 < 7) {
            return "\(diff.day ?? 0)일 전"
        } else {
            return time
        }
    }
}

