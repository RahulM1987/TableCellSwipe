//
//  SwipeTableViewCell.swift
//  TableCellSwipe
//
//  Created by Rahul Morade on 11/12/18.
//  Copyright © 2018 Rahul Morade. All rights reserved.
//

import UIKit

class SwipeTableViewCell: UITableViewCell {

    var topView = UIView()
    var settext = UILabel()
    var first = UIButton()
    var second = UIButton()
    var isOpenIndexpath = IndexPath()
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Do your cell set up
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.frame.height)
        self.selectionStyle = .none
        self.topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.frame.height)
        self.topView.backgroundColor = UIColor.white
        self.settext.frame = CGRect(x: 10, y: 10, width: self.frame.width - 10, height: self.frame.height - 20)
        self.first.frame = CGRect(x: self.frame.width - 100, y: 0, width: 50, height: self.frame.height)
        self.first.addTarget(self, action: #selector(firstTapped), for: .touchUpInside)
        self.first.backgroundColor = UIColor.red
        self.first.setTitle("First", for: .normal)
        self.first.setTitleColor(UIColor.white, for: .normal)
        self.first.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.second.frame = CGRect(x: self.frame.width - 50, y: 0, width: 50, height: self.frame.height)
        self.second.addTarget(self, action: #selector(secondTapped), for: .touchUpInside)
        self.second.backgroundColor = UIColor.blue
        self.second.setTitle("Second", for: .normal)
        self.second.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.second.setTitleColor(UIColor.white, for: .normal)
        self.topView.addSubview(self.settext)
        self.contentView.addSubview(self.first)
        self.contentView.addSubview(self.second)
        self.contentView.addSubview(self.topView)
        self.setupGestures()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //self.backgroundColor = UIColor.yellow
    }
    
    func animateToLeft(indexPath: IndexPath) {
        print("Indexpath: \(indexPath)")
        if indexPath != isOpenIndexpath {
//            UIView.animate(withDuration: 0.2) {
//                self.topView.transform = CGAffineTransform(translationX: -100, y: 0)
//                self.isOpenIndexpath = indexPath
//            }
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 4.0, options: UIView.AnimationOptions.curveEaseInOut, animations: ({
                // do stuff
                self.topView.transform = CGAffineTransform(translationX: -100, y: 0)
                self.isOpenIndexpath = indexPath
            }), completion: nil)
        } else {
            UIView.animate(withDuration: 0.2) {
                self.topView.transform = CGAffineTransform.identity
                self.isOpenIndexpath = IndexPath()
            }
        }
    }
    
    func closeCell() {
        UIView.animate(withDuration: 0.2) {
            self.topView.transform = CGAffineTransform.identity
            self.isOpenIndexpath = IndexPath()
        }
    }
    
    @objc func secondTapped()
    {
        print("Blue at: \(self.isOpenIndexpath)")
    }
    
    @objc func firstTapped()
    {
        print("Red at: \(self.isOpenIndexpath) ")
    }
    
    func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.addGestureRecognizer(swipeLeft)
        self.isUserInteractionEnabled = true
    }
    
    @objc func handleLeftSwipe(_ recognizer: UISwipeGestureRecognizer) {
        let index = self.getIndexPath()
        print("Swipe at: \(String(describing: index!)) ")
        self.animateToLeft(indexPath: index!)
    }
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        
       let indexPath = superView.indexPath(for: self)
        return indexPath
    }
}
