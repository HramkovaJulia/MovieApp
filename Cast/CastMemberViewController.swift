//
//  CastMemberViewController.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 13.01.2023.
//

import UIKit

class CastMemberViewController: UIViewController {
    
    static var identifier = "СastMemberTableViewCell"
    
    private var castId: Int
    private var castDetails: CastDetailEntity?
    private let alamofireService: AlamofireNetworkService
    
    init(castId: Int, alamofireService: AlamofireNetworkService) {
        self.castId = castId
        self.alamofireService = alamofireService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        loadCast()
    }
    
    let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        
        tableView.register(CastMemberTableViewCell.self, forCellReuseIdentifier: identifier)
        
        return tableView
    }()
    
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
}

extension CastMemberViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.identifier, for: indexPath) as! CastMemberTableViewCell
        if let castDetails = castDetails {
            cell.config(actor: castDetails)
        }
        return cell
    }
}

extension CastMemberViewController {
    func loadCast() {
        AlamofireNetworkService.shared.loadCastDetails(
            with: castId,
            completion: {
                [weak self] castDetails in
                self?.castDetails = castDetails
                self?.tableView.reloadData()
            })
    }
}

