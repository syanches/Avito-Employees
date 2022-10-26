//
//  ViewController.swift
//  Avito-Employees
//
//  Created by Artem Martirosyan on 26.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let employees = Employee.EmployeesMock()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EmployeesTableViewCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    private var cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// MARK: - Private Methods
extension ViewController {
    private func configureView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
                
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? EmployeesTableViewCell else { return UITableViewCell() }
        cell.initCell(name: employees[indexPath.row].name, phoneNumber: employees[indexPath.row].phoneNumber, skills: employees[indexPath.row].skills)
        return cell
    }
}
