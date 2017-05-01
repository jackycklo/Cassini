//
//  ImageViewController.swift
//  Cassini
//
//  Created by Chi kit Lo on 1/5/2017.
//  Copyright © 2017 Chi kit Lo. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    var imageURL: URL? {
        didSet {
            image = nil
            //fetchImage()
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            
            spinner?.startAnimating()
            
            //dispatch_async(DispatchQueue.global(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async() {
                let contentsOfURL = NSData(contentsOf: url )
                //if let imageData = NSData(contentsOf: url )
                DispatchQueue.main.async { [weak weakSelf = self] in
                    
                    if url == weakSelf?.imageURL
                    {
                        if let imageData = contentsOfURL {
                            weakSelf?.image = UIImage(data: imageData as Data)
                        } else {
                            weakSelf?.spinner?.stopAnimating()
                        }
                    } else {
                        print("ignored data returned from url \(url)")
                    }
                   
                }
            
            }
            
//            if let imageData = NSData(contentsOf: url ) {
//                image = UIImage(data: imageData as Data)
//            }
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet {
            scrollView.contentSize = imageView.frame.size
            // all three of the next lines of code
            // are necessary to make zooming work
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
         return imageView
    }
//    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        return imageView
//    }
    
    
    private var imageView = UIImageView()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        //imageURL = NSURL(string: DemoURL.Stanford)
        //imageURL = URL(string: DemoURL.Stanford)

    }
    deinit {
        
    }

}
