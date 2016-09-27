//
//  ViewController.swift
//  Landmark
//
//  Created by Vinod Vishwanath on 26/09/16.
//  Copyright © 2016 Vinod Vishwanath. All rights reserved.
//

import UIKit

private let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
private let margin      = CGFloat(10)
private let cellWidth   = (screenWidth - 2*margin)/2

//MARK:- Class Implementation

class ViewController: UIViewController {
    
    private var dataController = DataController()
    private var products        : [Product]? {
        
        didSet {
            
            productsCollectionView?.reloadData()
        }
    }
    
    @IBOutlet private weak var productsCollectionView   : UICollectionView!
    @IBOutlet private weak var pageControl              : UIPageControl!
    @IBOutlet private weak var refreshButtonItem        : UIBarButtonItem!
    @IBOutlet private weak var animator                 : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        findProducts()
    }
    
    private func findProducts () {
        
        products                    = nil
        pageControl.numberOfPages   = 0
        refreshButtonItem.enabled   = false
        
        animator.startAnimating()
        
        dataController.fetchData { error in
            
            self.animator.stopAnimating()
            self.reloadProducts ()
        }
    }
    
    private func reloadProducts () {
        
        refreshButtonItem.enabled  = true
        
        products   = dataController.parsedProducts
        
        pageControl.numberOfPages = (products?.count ?? 0) / 2
    }
    
    @IBAction private func refresh () {
        
        findProducts()
    }
}

//MARK:- UICollectionView delegate/datasource methods

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ProductCell.reuseId, forIndexPath: indexPath) as! ProductCell
        
        let product = products![indexPath.row]
        cell.showProduct(product)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let height = CGRectGetHeight(collectionView.bounds)
        
        return CGSize(width: cellWidth, height: height)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let pageWidth   = screenWidth
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        
        pageControl.currentPage = currentPage
    }
}

