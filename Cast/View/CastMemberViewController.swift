//
//  CastMemberViewController.swift
//  MoviewCollectionApp
//
//  Created by Artyom Prima on 13.01.2023.
//

import UIKit

protocol CastViewInput: AnyObject {
    func handleObtainedActor(_ actor: [CastDetailEntity])
}

protocol CastViewOutput: AnyObject {
    func didLoadView()
}

class CastMemberViewController: UIViewController {
    
    private var castDetails: [CastDetailEntity] = []
    
    var output: CastViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoadView()
        setupConstraints()
        view.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0.06831727177, green: 0.09892369062, blue: 0.1742413342, alpha: 1)
        
        tableView.register(CastMemberTableViewCell.self, forCellReuseIdentifier: CastMemberTableViewCell.identifier)
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CastMemberTableViewCell.identifier, for: indexPath) as! CastMemberTableViewCell
        cell.config(actors: castDetails)
        return cell
    }
}

extension CastMemberViewController: CastViewInput {
    func handleObtainedActor(_ actor: [CastDetailEntity]) {
        self.castDetails = actor
        self.tableView.reloadData()
    }
}

