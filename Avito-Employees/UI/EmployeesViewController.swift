//
//  ViewController.swift
//  Avito-Employees
//
//  Created by Artem Martirosyan on 26.10.2022.
//

import UIKit

class EmployeesViewController: UIViewController {
    
    private var employeesParsed: [Employee] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
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
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 10
        config.requestCachePolicy = .useProtocolCachePolicy
        
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        guard let url = URL(string:"https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else { return }
        
        let dataTask = session.dataTask(with: url)
        dataTask.resume()
        
        session.finishTasksAndInvalidate()
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

//MARK: - URLSessionDataDelegate
extension EmployeesViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        
        if dataTask.currentRequest?.cachePolicy == .useProtocolCachePolicy {
            let newResponse = proposedResponse.response(withExpirationDuration: CacheConstants.expirationDuration)
            completionHandler(newResponse)
        } else {
            completionHandler(proposedResponse)
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.parseData(from: data)
    }
        
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Connection failure", message: "Please check your internet and restart the app", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default))
                self.present(alert, animated: true)
            }
            print(error)
        }
    }
}

//MARK: - CacheConstants
extension EmployeesViewController {
    struct CacheConstants {
        static let expirationDuration = 3600
    }
}
