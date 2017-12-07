//
//  ViewController.swift
//  Swift-MImageBrowser
//
//  Created by huangshuigen on 12/04/2017.
//  Copyright (c) 2017 huangshuigen. All rights reserved.
//

import UIKit
import Swift_MImageBrowser
class ViewController: UIViewController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var dataArray = ["http://p2.qhimg.com/t011fc13354f12d1a46.jpg",
                         "http://img.bimg.126.net/photo/Q_YgZ2eYuC1qtuBXeAFMXQ==/1457758904385917359.jpg",
                         "http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg",
                         "http://image.tianjimedia.com/uploadImages/2012/233/37/HF17SP1LG9QQ.jpg",
                         "http://pic23.nipic.com/20120908/3073979_090316421000_2.jpg",
                         "http://image.tianjimedia.com/uploadImages/2015/129/56/J63MI042Z4P8.jpg",
                         "http://image.tianjimedia.com/uploadImages/2012/233/26/QNK85ZK47V2R.jpg",
                         "http://n.7k7kimg.cn/2015/0723/1437613406241.jpg",
                         "http://image.tianjimedia.com/uploadImages/2011/361/KD85LY2UE08Q.jpg",
                         "http://img.taopic.com/uploads/allimg/120425/95478-12042511120249.jpg",
                         "http://v1.qzone.cc/pic/201306/29/17/10/51cea48cb4d54713.jpg%21600x600.jpg"]
        let showView = ImageBrowserView()
        showView.dataSource = dataArray
        showView.currentIndex = 1
        showView.show()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

