
import UIKit

class LocationsTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let nameLabelFontSize = 20.0
        static let standardLabelFontSize = 15.0
        
        static let nameLabelTopOffset = 5
        static let nameLabelHorizontalOffset = 10
        
        static let stackViewTopOffset = 5
        static let stackViewHorizontalOffset = 10
    }
    
    private enum Title {
        static let type = "Type: "
        static let dimension = "Dimension: "
    }
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 2
        name.font = UIFont.systemFont(ofSize: Constants.nameLabelFontSize)
        return name
    }()
    
    private let typeLabel: UILabel = {
        let type = UILabel()
        type.font = UIFont.systemFont(ofSize: Constants.standardLabelFontSize)
        return type
    }()
    
    private let dimensionLabel: UILabel = {
        let dimension = UILabel()
        dimension.numberOfLines = 2
        dimension.font = UIFont.systemFont(ofSize: Constants.standardLabelFontSize)
        return dimension
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
    
    func configureCell(location: Location) {
        nameLabel.text = location.name
        typeLabel.text = Title.type + location.type
        dimensionLabel.text = Title.dimension + location.dimension
    }
    
    //MARK: - StackView setup
    
    private func setupStackView() {
        self.backgroundColor = .clear
        
        stackView = UIStackView(arrangedSubviews: [typeLabel, dimensionLabel])
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
