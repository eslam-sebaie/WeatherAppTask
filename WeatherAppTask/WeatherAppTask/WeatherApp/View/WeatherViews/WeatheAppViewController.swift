//
//  WeatheAppViewController.swift
//  WeatherAppTask
//
//  Created by Eslam Sebaie on 01/10/2024.
//

import UIKit
import Combine

class WeatherAppViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityDesc: UILabel!
    
    
    private let viewModel: WeatherViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "WeatheAppViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Weather Forecast"
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.placeholder = "Enter city name"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(UINib(nibName: WeatherCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: WeatherCell.reuseIdentifier)
    }
    
    private func updateDay() {
        self.cityName.text = viewModel.cityName
        self.cityTemp.text = viewModel.cityTemp
        self.cityDesc.text = viewModel.cityDesc
    }
    
    private func bindViewModel() {
        viewModel.$forecasts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.updateDay()
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    self?.showError(error)
                }
            }
            .store(in: &cancellables)
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension WeatherAppViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text, !city.isEmpty else { return }
        viewModel.fetchWeather(for: city)
        searchBar.resignFirstResponder()
    }
}

extension WeatherAppViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.reuseIdentifier, for: indexPath) as? WeatherCell else {
            fatalError("Unable to dequeue WeatherCell")
        }
        
        let cellViewModel = viewModel.cellViewModel(at: indexPath.row)
        cell.configure(with: cellViewModel)
        
        return cell
    }
}

