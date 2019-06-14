//
//  ViewController.swift
//  Practice-002
//
//  Created by Soeng Saravit on 6/14/19.
//  Copyright © 2019 KSHRD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
    
    // Properties: - List of 10 countries in Asean
    var items:[[String:String]] = [
        ["country":"Cambodia", "desc":"Cambodia is a Southeast Asian nation whose landscape spans low-lying plains, the Mekong Delta, mountains and Gulf of Thailand coastline.", "image":"cambodia"],
        ["country":"Thailand", "desc":"Thailand is a Southeast Asian country. It's known for tropical beaches, opulent royal palaces, ancient ruins and ornate temples displaying figures of Buddha.", "image":"thailand"],
        ["country":"Vietnam", "desc":"Vietnam is a Southeast Asian country on the South China Sea known for its beaches, rivers, Buddhist pagodas and bustling cities.", "image":"vietnam"],
        ["country":"Laos", "desc":"Laos is a Southeast Asian country traversed by the Mekong River and known for mountainous terrain, French colonial architecture, hill tribe settlements and Buddhist monasteries", "image":"laos"],
        ["country":"Myanmar", "desc":"Myanmar (formerly Burma) is a Southeast Asian nation of more than 100 ethnic groups, bordering India, Bangladesh, China, Laos and Thailand.", "image":"myanmar"],
        ["country":"Malaysia", "desc":"Malaysia is a Southeast Asian country occupying parts of the Malay Peninsula and the island of Borneo", "image":"malaysia"],
        ["country":"Indonesia", "desc":"Indonesia, a Southeast Asian nation made up of thousands of volcanic islands, is home to hundreds of ethnic groups speaking many different languages.", "image":"indonesia"],
        ["country":"Singapore", "desc":"Singapore, an island city-state off southern Malaysia, is a global financial center with a tropical climate and multicultural population.", "image":"singapore"],
        ["country":"Philippine", "desc":"The Philippines, officially the Republic of the Philippines, is an archipelagic country in Southeast Asia.", "image":"philippine"],
        ["country":"Brunei", "desc":"Brunei is a tiny nation on the island of Borneo, in 2 distinct sections surrounded by Malaysia and the South China Sea.", "image":"brunei"]
    ]
    
    // Mark: - UI Element Declarations
    var titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let attributedText = NSMutableAttributedString(string: "10 Countries in ASEAN", attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ])
        attributedText.append(NSAttributedString(string: "\nOne Vision, One Identity, One Community", attributes: [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor:UIColor.lightGray
            ]))
        label.attributedText = attributedText
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    var prevButton:UIButton = {
        let button = UIButton()
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        
        return button
    }()
    
    var nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()
    
    // Mark: - Height for Scroll View and Items View
    var definedHeigth:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if UIDevice.current.userInterfaceIdiom == .pad {
            definedHeigth = 1.15
        }else {
            definedHeigth = 1.35
        }
        // Mark:- Add action for Button
        self.nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        self.prevButton.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        
         setupUI()
    }
    
    func setupUI() {
        // Mark: - Set up Title Label
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
                self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
                self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        // Mark: - Set up ScrollView
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: CGFloat(items.count)*self.view.frame.width, height: self.scrollView.frame.height)
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            self.scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: CGFloat(definedHeigth))
        ])
        
        for (index, item) in items.enumerated() {
            let itemView = UIView()
            itemView.translatesAutoresizingMaskIntoConstraints = false
            self.scrollView.addSubview(itemView)
            itemView.backgroundColor = .red
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: CGFloat(index) * self.view.frame.width),
                itemView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                itemView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: CGFloat(definedHeigth))
            ])

            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            if UIDevice.current.userInterfaceIdiom == .pad {
                imageView.contentMode = .scaleAspectFill
            }else{
                imageView.contentMode = .scaleToFill
            }
            
            imageView.image = UIImage(named: item["image"]!)
            itemView.addSubview(imageView)
            NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),
                    imageView.topAnchor.constraint(equalTo: itemView.topAnchor),
                    imageView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor)
            ])
            
            let bgView = UIView()
            bgView.translatesAutoresizingMaskIntoConstraints = false
            bgView.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
            
            var bgViewHeight = 0.0
            if UIDevice.current.userInterfaceIdiom == .pad {
                bgViewHeight = 80.0
            }else {
                bgViewHeight = 100.0
            }

            itemView.addSubview(bgView)
            NSLayoutConstraint.activate([
                    bgView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),
                    bgView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
                    bgView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor),
                    bgView.heightAnchor.constraint(equalToConstant: CGFloat(bgViewHeight))
            ])

            let descLabel = UILabel()
            descLabel.textAlignment = .center
            descLabel.text = item["desc"]
            descLabel.textColor = .white
            descLabel.numberOfLines = 0
            descLabel.translatesAutoresizingMaskIntoConstraints = false
            bgView.addSubview(descLabel)
            
            NSLayoutConstraint.activate([
                    descLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 8),
                    descLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -8),
                    descLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor)
            ])
        }
        
        // Mark: - Page Control, Previous, and next button into stack
        let stackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)

        pageControl.numberOfPages = self.items.count
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant:8),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    // Mark: - Configure on Page Control when scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / self.view.frame.width
        self.pageControl.currentPage = Int(page)
    }
    
    // Mark: - Next Button
    @objc func nextButtonAction() {
        if scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x < self.scrollView.contentSize.width - self.view.frame.width {
            scrollView.contentOffset.x += self.view.frame.width
        }
    }
    
    // Mark: - Previous Button
    @objc func previousButtonAction() {
        if scrollView.contentOffset.x > 0 && scrollView.contentOffset.x < self.scrollView.contentSize.width {
            scrollView.contentOffset.x -= self.view.frame.width
        }
    }
    
}


