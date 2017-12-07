//
//  ImageBrowserCollectionViewCell.swift
//  Kingfisher
//
//  Created by shuigen on 04/12/2017.
//

import UIKit
import Kingfisher

public class ImageBrowserCollectionViewCell: UICollectionViewCell {
    var imageURL: String?{
        didSet {
//            imageView.kf.setImage(with: URL.init(string: imageURL!), placeholder: UIImage.init(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
            imageView.kf.setImage(with:  URL.init(string: imageURL!), placeholder: bundleImage(named: "ImageBundle-loading"), options: nil, progressBlock: nil) { (image, error, _, _) in
                if error != nil {
                    self.imageView.image = bundleImage(named: "ImageBundle-fail")
                    
                }
            }
        }
    }
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: contentView.bounds)
        contentView.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.backgroundColor = UIColor.black
        
        imageView = UIImageView()
        imageView.frame = scrollView.bounds
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        
        let singleTag = UITapGestureRecognizer()
        singleTag.numberOfTouchesRequired = 1
        singleTag.numberOfTapsRequired = 1
        singleTag.addTarget(self, action: #selector(oneTouch(gesture:)))
        self.addGestureRecognizer(singleTag)
        
        let doubleTouch = UITapGestureRecognizer()
        doubleTouch.numberOfTouchesRequired = 2
        doubleTouch.numberOfTapsRequired = 2
        doubleTouch.addTarget(self, action: #selector(DoubleTouch(gesture:)))
        singleTag.require(toFail: doubleTouch)
        self.addGestureRecognizer(doubleTouch)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageBrowserCollectionViewCell: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let image = scrollView.subviews[0]
        if image.height > UIScreen.height {
            UIView.animate(withDuration: 0.25, animations: {
                self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.scrollView.contentInset = UIEdgeInsetsMake((self.scrollView.height - image.height) / 2, 0, 0, 0)
            })
        }
    }
}
extension ImageBrowserCollectionViewCell {
    @objc func oneTouch(gesture: UITapGestureRecognizer) {
//        let temImageView = UIImageView()
//        let ImgV = gesture.view?.subviews[0] as? UIImageView
//        let Img = ImgV?.image
//        temImageView.image = Img
        UIView.animate(withDuration: 0.25, animations: {
            self.superview?.alpha = 0
            self.superview?.superview?.alpha = 0
        }) { (_) in
            self.superview?.superview?.removeFromSuperview()
        }
    }
    
    @objc func DoubleTouch(gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: gesture.view)
        let scroll = gesture.view as! UIScrollView
        let imageView = scroll.subviews[0]
        let scrollZoomScale = scroll.zoomScale
        UIView.animate(withDuration: 0.25) {
            scroll.zoomScale = scrollZoomScale == 1.0 ? 2.0 : 0.0
        }
        UIView.animate(withDuration: 0.25) {
            if scroll.zoomScale == 2.0 {
                let rectHeight = self.height / scroll.zoomScale
                let rectWidth = self.height / scroll.zoomScale
                let rectX = touchPoint.x - rectWidth / 2.0
                let rectY = touchPoint.y - rectHeight / 2.0
                let zoomRect = CGRect.init(x: rectX, y: rectY, width: rectWidth, height: rectHeight)
                scroll.zoom(to: zoomRect, animated: false)
            } else {
                
            }
            
            if imageView.height > UIScreen.height {
                self.scrollView.contentInset = UIEdgeInsetsMake(0,0, 0, 0)
            } else {
                self.scrollView.contentInset = UIEdgeInsetsMake((self.scrollView.height - imageView.height) / 2, 0, 0, 0)
            }

        }
    }
}
func bundleImage(named: String) -> UIImage? {
    let bundlePath = Bundle.init(for: ImageBrowserView.self).path(forResource: "\(named)@\(Int(UIScreen.main.scale))x", ofType: "png", inDirectory: "Image.bundle/images")
    guard let path = bundlePath else {
        return nil
    }
    return UIImage(contentsOfFile: path)
}
