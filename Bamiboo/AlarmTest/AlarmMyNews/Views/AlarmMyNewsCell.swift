//
//  AlarmMyNewsCell.swift
//  Bamiboo
//
//  Created by Bamiboo on 2020/12/09.
//

import UIKit


class AlarmMyNewsCell: UICollectionViewCell {
    
    // MARK: Views
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .left
        l.textColor = .white
        l.font.withSize(100)
        l.numberOfLines = 2 // 최대 2줄
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
    
    
    // MARK: Public Functions
    func setData(data: AlarmMyNewsItem) {
        titleLabel.text = data.title
        timeLabel.text = data.getTimeString()
        
        if let url = data.getThumbnailUrl() {
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}


// MARK: AlarmMyNewsItem
struct AlarmMyNewsItem {
    private(set) var title: String?
    private(set) var thumbnail: String?
    private(set) var time: String?
    
    init(title: String, thumbnail: String, time: String) {
        self.title = title
        self.thumbnail = thumbnail
        self.time = time
    }
    
    
    // ------ get Functions
    func getThumbnailUrl() -> URL? {
        guard let thumbnail = thumbnail else { return nil }
        return URL(string: thumbnail)
    }
    
    // Date <-> String 하는 Common 함수가 있다면 그걸 사용
    func getDateTime() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        guard let thumbnail = thumbnail else { return nil }
        return formatter.date(from: thumbnail)
    }
    
    func getTimeString() -> String? {
        if time == nil { return nil }
        
        guard let timeDate = getDateTime() else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let nowDate = Date()
        let nowStr = formatter.string(from: nowDate)
        
        // TODO: 'ago' 공통정책 적용
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

