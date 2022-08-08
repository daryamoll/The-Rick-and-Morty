
import UIKit

class LocationsViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.background.color
        tableView.register(LocationsTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var locations = [Location]()
    private var filteredLocations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Локации"
        setupDelegate()
        setupSearchController()
        setConstraints()
        
        LocationsNetworkService.shared.fetchLocations { result in
            self.locations = result
            self.tableView.reloadData()
        }
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchBar.delegate = self
    }
}


//MARK: - SearchController settings

extension LocationsViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredLocations = locations.filter { (location: Location) -> Bool in
            return location.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

//MARK: - TableView settings

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredLocations.count
        }
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationsTableViewCell
        let location: Location
        if isFiltering {
            location = filteredLocations[indexPath.row]
        } else {
            location = locations[indexPath.row]
        }
        cell.configureCell(location: location)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        115
    }
}

//MARK: -  Constraints settings

private extension LocationsViewController {
    
    private func setConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}




