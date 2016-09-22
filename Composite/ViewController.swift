//
//  ViewController.swift
//  Composite
//
//  Created by Yury Korolev on 9/22/16.
//  Copyright © 2016 anjlab. All rights reserved.
//

import UIKit


class ButtonsView: UIView {
    let buttonA = UIButton()
    let buttonB = UIButton()
    
    private let _spacer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.blue
        
        buttonA.translatesAutoresizingMaskIntoConstraints = false
        buttonB.translatesAutoresizingMaskIntoConstraints = false
        _spacer.translatesAutoresizingMaskIntoConstraints = false
        
        buttonA.backgroundColor = UIColor.orange
        buttonB.backgroundColor = UIColor.yellow
        
        addSubview(buttonA)
        addSubview(buttonB)
        addSubview(_spacer)
        
        NSLayoutConstraint.activate([
        
          _spacer.centerXAnchor.constraint(equalTo: centerXAnchor),
          _spacer.centerYAnchor.constraint(equalTo: centerYAnchor),
          _spacer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25, constant: 0),
          _spacer.heightAnchor.constraint(equalToConstant: 60),
          _spacer.topAnchor.constraint(equalTo: topAnchor),
          _spacer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
          buttonA.centerYAnchor.constraint(equalTo: centerYAnchor),
          buttonA.widthAnchor.constraint(equalTo: _spacer.widthAnchor),
          buttonA.trailingAnchor.constraint(equalTo: _spacer.leadingAnchor),
          
          
          buttonB.centerYAnchor.constraint(equalTo: centerYAnchor),
          buttonB.widthAnchor.constraint(equalTo: _spacer.widthAnchor),
          buttonB.leadingAnchor.constraint(equalTo: _spacer.trailingAnchor),

        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TopView: UIView {
    
    let buttonsView = ButtonsView()
    
    let navView = UIView()
    let chartView = UIView()
    
    var chartViewHC: NSLayoutConstraint!
    
    let maxChartSize: CGFloat = 90
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        navView.backgroundColor = UIColor.purple
        
        navView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        chartView.backgroundColor = UIColor.cyan
        
        addSubview(navView)
        addSubview(chartView)
        addSubview(buttonsView)
        
        chartViewHC = chartView.heightAnchor.constraint(equalToConstant: maxChartSize)
        
        
        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: topAnchor),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 60),
            navView.bottomAnchor.constraint(equalTo: chartView.topAnchor),
            
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: buttonsView.topAnchor),
            
            buttonsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            chartViewHC
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SegmentsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.brown
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func noopScroll(scrollView: UIScrollView) {
    
}

class TableViewController: UITableViewController {
    
    var viewDidScrollBlock = noopScroll
    
    var numberOfRows: Int = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "__cell__")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "__cell__", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewDidScrollBlock(scrollView)
    }
}



class ViewController: UIViewController {
    
    private let _topView = TopView()
    private let _segmentsView = SegmentsView()
    private let _tableViewController = TableViewController(style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = UIColor.red
        
        view.addSubview(_topView)
        view.addSubview(_segmentsView)
        
        
        _tableViewController.willMove(toParentViewController: self)
        view.addSubview(_tableViewController.view)
        _tableViewController.didMove(toParentViewController: self)
        
        _topView.translatesAutoresizingMaskIntoConstraints = false
        _segmentsView.translatesAutoresizingMaskIntoConstraints = false
        _tableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            _topView.topAnchor.constraint(equalTo: view.topAnchor),
            _topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            _topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            _segmentsView.topAnchor.constraint(equalTo: _topView.bottomAnchor),
            _segmentsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            _segmentsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            _segmentsView.heightAnchor.constraint(equalToConstant: 54),
            
            _tableViewController.view.topAnchor.constraint(equalTo: _segmentsView.bottomAnchor),
            _tableViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            _tableViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            _tableViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
        _topView.buttonsView.buttonA.addTarget(self, action: #selector(ViewController._handleButtonA as (ViewController) -> () -> ()), for: .touchUpInside)
        _topView.buttonsView.buttonB.addTarget(self, action: #selector(ViewController._handleButtonB), for: .touchUpInside)
        
    
        _tableViewController.viewDidScrollBlock = { [unowned self] scrollView in
            
            if scrollView.contentSize.height > scrollView.bounds.size.height {
                var newValue = self._topView.chartViewHC.constant
                
                newValue -= scrollView.contentOffset.y
                
                newValue = min(max(0, newValue), self._topView.maxChartSize)
                
                if newValue != self._topView.chartViewHC.constant {
                    self._topView.chartViewHC.constant = newValue
                    let delegate = scrollView.delegate
                    scrollView.delegate = nil
                    scrollView.contentOffset = CGPoint.zero
                    scrollView.delegate = delegate
                }
            } else {
                self._topView.chartViewHC.constant = self._topView.maxChartSize
            }
        }
    }
    
    func _handleButtonA() {
        _tableViewController.numberOfRows = 1
    }
    
    func _handleButtonB() {
        _tableViewController.numberOfRows = 500
    }
}

