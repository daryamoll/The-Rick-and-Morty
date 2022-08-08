
import UIKit

class EpisodesTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let nameLabelFontSize = 20.0
        static let standardLabelFontSize = 15.0
        
        static let nameLabelTopOffset = 5
        static let nameLabelHorizontalOffset = 10
        
        static let stackViewTopOffset = 5
        static let stackViewHorizontalOffset = 10
    }
    
    private enum Title {
        static let date = "Type: "
        static let numberOfEpisodeLabel = "Episode: "
    }
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: Constants.nameLabelFontSize)
        name.numberOfLines = 2
        return name
    }()
    
    private let dateLabel: UILabel = {
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: Constants.standardLabelFontSize)
        return date
    }()
    
    private let numberOfEpisodeLabel: UILabel = {
        let numberOfEpisode = UILabel()
        numberOfEpisode.font = UIFont.systemFont(ofSize: Constants.standardLabelFontSize)
        return numberOfEpisode
    }()
    
    private var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Cell configuration
    func configureCell(episode: Episode) {
        nameLabel.text = episode.name
        dateLabel.text = Title.date + episode.air_date
        numberOfEpisodeLabel.text = "\(Title.numberOfEpisodeLabel) \(episode.id)"
    }
    
    //MARK: - StackView setup
    
    private func setupStackView() {
        self.backgroundColor = .clear
        
        stackView = UIStackView(arrangedSubviews: [dateLabel, numberOfEpisodeLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalCentering
    }
    
    //MARK: - Constraints settings
    
    private func setConstraints() {
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.nameLabelTopOffset)
            make.leading.equalToSuperview().offset(Constants.nameLabelHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.nameLabelHorizontalOffset)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.stackViewTopOffset)
            make.leading.equalToSuperview().offset(Constants.stackViewHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.stackViewHorizontalOffset)
        }
    }
}
