//
//  ViewController.swift
//  Avito-Employees
//
//  Created by Artem Martirosyan on 26.10.2022.
//

import UIKit

class EmployeesViewController: UIViewController {
    
    var employeesParsed: [Employee] = []
    
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
        fetchEmployees()
    }
    
}

// MARK: - Private Methods
extension EmployeesViewController {
    private func configureView() {
        title = "Employees"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchEmployees() {
        guard let url = URL(string:"https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            if let data = data, (response as? HTTPURLResponse)?.statusCode == 200 {
                self?.parseData(from: data)
            }
            if let error = error {
                print(error)
            }
        }
        dataTask.resume()
    }
    
    private func parseData(from data: Data) {
        do {
            let jsonObject = try JSONDecoder().decode(CompanyItem.self, from: data)
            for employee in jsonObject.company.employees {
                employeesParsed.append(Employee(name: employee.name, phoneNumber: employee.phoneNumber, skills: employee.skills))
            }
            employeesParsed.sort(by: {$0.name < $1.name})
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } catch {
            print("JSON parsing error: ", error)
        }
    }
}

//MARK: - UITableViewDelegate
extension EmployeesViewController: UITableViewDelegate {
}

//MARK: - UITableViewDataSource
extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeesParsed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? EmployeesTableViewCell else { return UITableViewCell() }
        cell.initCell(name: employeesParsed[indexPath.row].name, phoneNumber: employeesParsed[indexPath.row].phoneNumber, skills: employeesParsed[indexPath.row].skills)
        return cell
    }
}
