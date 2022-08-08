
import UIKit

class EpisodesViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.background.color
        tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var episodes = [Episode]()
    private var filteredEpisodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Эпизоды"
        setupDelegate()
        setupSearchController()
        setConstraints()
        EpisodesNetworkService.shared.fetchEpisodes { result in
            self.episodes = result
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

extension EpisodesViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
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
        filteredEpisodes = episodes.filter { (episode: Episode) -> Bool in
            return episode.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

//MARK: - TableView settings

extension EpisodesViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredEpisodes.count
        }
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EpisodesTableViewCell
        let episode: Episode
        if isFiltering {
            episode = filteredEpisodes[indexPath.row]
        } else {
            episode = episodes[indexPath.row]
        }
        cell.configureCell(episode: episode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
}

//MARK: - Constraints settings

private extension EpisodesViewController {
    func setConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}
