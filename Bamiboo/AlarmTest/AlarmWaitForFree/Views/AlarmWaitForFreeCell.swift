//
//  AlarmWaitForFreeCell.swift
//  Bamiboo
//
//  Created by 한호빈 on 2020/12/11.
//

import UIKit

class AlarmWaitForFreeCell: UICollectionViewCell {
    
    // MARK: Views
    private var titleView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    private var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .left
        l.textColor = .white
        l.font = UIFont.boldSystemFont(ofSize: 20.0)
        l.numberOfLines = 2 // 최대 2줄
        l.text = ""
        return l
    }()
    private var timeLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .left
        l.textColor = .gray
        l.text = ""
        return l
    }()
    private var redDotView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        v.layer.cornerRadius = 3
        return v
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
        
        self.addSubview(imageView)
        self.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(timeLabel)
        titleView.addSubview(redDotView)
        
        NSLayoutConstraint.activate([
            // imageView
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            // titleView
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            // titleLabel
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            // timeLabel
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            // redDotView
            redDotView.widthAnchor.constraint(equalToConstant: 6),
            redDotView.heightAnchor.constraint(equalTo: redDotView.widthAnchor, multiplier: 1),
            redDotView.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            redDotView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 10),
            redDotView.trailingAnchor.constraint(lessThanOrEqualTo: titleView.trailingAnchor),
        ])
    }
    
    
    // MARK: Public Functions
    func setData(data: AlarmWaitForFreeItem) {
        titleLabel.text = data.title
        timeLabel.text = data.getTimeString()
        timeLabel.textColor = data.getIsTimerDone() ? .purple : .lightGray
        redDotView.isHidden = !(data.readable ?? true)
        
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


// MARK: AlarmWaitForFreeItem
struct AlarmWaitForFreeItem {
    private(set) var title: String?         // 타이틀
    private(set) var thumbnail: String?     // 썸네일 이미지
    private(set) var time: String?          // 타이머 끝나는 시점
    private(set) var readable: Bool?        // 사용자 읽음 여부
    
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    private var nowDate: Date? {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC)
    }
    
    init(title: String, thumbnail: String, time: String, readable: Bool) {
        self.title = title
        self.thumbnail = thumbnail
        self.time = time
        self.readable = readable
    }
    
    // ------ get Functions
    func getThumbnailUrl() -> URL? {
        guard let thumbnail = thumbnail else { return nil}
        return URL(string: thumbnail)
    }
    func getTimeDate() -> Date? {
        guard let time = time else { return nil }
        return formatter.date(from: time)
    }
    func getTimeString() -> String? { // TODO: '남은 기간 표기' 공통정책 적용
        guard let timeDate = getTimeDate() else { return nil }
        
        if getIsTimerDone() {
            return "한 편 무료 열람 가능"
        } else {
            guard let nowDate = nowDate else { return nil }
            var result = ""
            let diff = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: nowDate, to: timeDate) // diff = nowDate ~ timeDate
            
            if diff.day ?? 0 > 0 { result += "\(diff.day!)일 " }
            if diff.hour ?? 0 > 0 { result += "\(diff.hour!)시간 " }
            if result.isEmpty {
                result += diff.minute ?? 0 > 0 ? "\(diff.minute!)분 " : "\(diff.second ?? 0)초 "
            }
            
            return result + "남음"
        }
    }
    func getIsTimerDone() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        
        guard let time = time, let timeDate = formatter.date(from: time) else { return false }
        return Date() >= timeDate
    }
    
    
    // ------ set Functions
    mutating func setRead() {
        readable = false
    }
}

