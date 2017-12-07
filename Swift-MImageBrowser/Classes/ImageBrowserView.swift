//
//  ImageBrowserView.swift
//  Kingfisher
//
//  Created by shuigen on 04/12/2017.
//

import UIKit
import Swift_M
public class ImageBrowserView: UIView {
    var collectionView: UICollectionView!
    var pageIndexLable: UILabel!
    var handleToolBar: UIView!
    var backButton: UIButton!
    public var dataSource: [String] = []
    public var currentIndex: NSInteger = 1

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initSubView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.width, height: UIScreen.height)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageBrowserCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(ImageBrowserCollectionViewCell.self))
        self.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.black
        collectionView.isPagingEnabled = true
        collectionView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
        
        //
        handleToolBar = UIView(frame: CGRect.init(x: 0, y: UIScreen.height - 49, width: UIScreen.width, height: 49))
        handleToolBar.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        self.addSubview(handleToolBar)
        
        pageIndexLable = UILabel()
        pageIndexLable.textColor = UIColor.white
        pageIndexLable.font = UIFont.systemFont(ofSize: 15)
        pageIndexLable.textAlignment = .center
        pageIndexLable.center = handleToolBar.center
        pageIndexLable.frame = CGRect.init(x: 0, y: UIScreen.height - handleToolBar.height , width: UIScreen.width, height: handleToolBar.height)
        self.addSubview(pageIndexLable)
        
        backButton = UIButton()
        backButton.frame = CGRect.init(x: 10, y: 0, width: 30, height: handleToolBar.height)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        //        handleToolBar.addSubview(backButton)

    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        pageIndexLable.text = "\(currentIndex) / \(dataSource.count)"

    }
}

extension ImageBrowserView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ImageBrowserCollectionViewCell.self), for: indexPath) as? ImageBrowserCollectionViewCell
        cell?.imageURL = dataSource[indexPath.row]
        return cell!
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let path = collectionView.indexPathForItem(at: collectionView.contentOffset)
        guard let index = path?.row else {
            return
        }
        pageIndexLable.text = "\(index + 1) / \(dataSource.count)"
        UIView.animate(withDuration: 3) {
            self.pageIndexLable.alpha = 0
        }
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.25) {
            self.pageIndexLable.alpha = 1
        }
    }
}
extension ImageBrowserView {
    @objc fileprivate func backAction() {
        
    }
    
    public func show() {
        let window = UIApplication.shared.keyWindow
        self.frame = (window?.frame)!
        window?.addSubview(self)
        
    }
}

