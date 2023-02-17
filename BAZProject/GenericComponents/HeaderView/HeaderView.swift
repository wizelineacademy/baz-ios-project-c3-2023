//
//  HeaderView.swift
//  BAZProject
//
//  Created by 1014600 on 09/02/23.
//

import UIKit

public class HeaderView: UIView{
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!{
        didSet{
            self.dateLabel.textColor = .gray
            self.dateLabel.textAlignment = .left
        }
    }
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            self.titleLabel.textAlignment = .left
        }
    }
    @IBOutlet weak var movieIcon: UIImageView!{
        didSet{
            self.movieIcon.image = UIImage(named: "iconMovies")
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    public func commonInit() {
        let nib = UINib(nibName: "HeaderView", bundle: Bundle(for: Self.self))
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
    public func initConfig(title: String) {
        self.dateLabel.text = getDateString()
        self.titleLabel.text = title
    }
    
    private func getDateString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        //dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
}
