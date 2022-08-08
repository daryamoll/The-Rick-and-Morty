
import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    private enum Constants {
        
        static let nameLabelFontSize = 20.0
        static let standardLabelFontSize = 15.0
        
        static let imageLeadingOffset = 20
        static let imageSize = 130
        
        static let nameLabelTopOffset = 20
        static let nameLabelHorizontalOffset = 10
        
        static let stackViewTopOffset = 5
        static let stackViewHorizontalOffset = 10
    }
    
    private enum Title {
        static let gender = "Gender: "
        static let species = "Species: "
        static let location = "Location: "
    }
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 2
        name.font = UIFont.systemFont(ofSize: Constants.nameLabelFontSize)
        return name
    }()
    
    private let genderLabel: UILabel = {
        let gender = UILabel()
        gender.font = UIFont.systemFont(ofSize: Constants.standardLabelFontSize)
        return gender
    }()
    
    private let speciesLabel: UILabel = {
        let species = UILabel()
        species.numberOfLines = 2
        species.font = UIFont.systemFont(ofSize: Constants.standardLabelFontSize)
        return species
    }()
    
    private let locationLabel: UILabel = {
        let location = UILabel()
        location.numberOfLines = 3
        location.font = UIFont.systemFont(ofSize: Constants.standardLabelFontSize)
        return location
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
    func configureCell(character: Character) {
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: character.image) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.image.image = UIImage(data: imageData)
            }
        }
        
        nameLabel.text = character.name
        genderLabel.text = Title.gender + character.gender
        speciesLabel.text = Title.species + character.species
        locationLabel.text = Title.location + character.location.name
    }
    
    //MARK: - StackView setup
    private func setupStackView() {
        self.backgroundColor = .clear
        
        stackView = UIStackView(arrangedSubviews: [genderLabel, speciesLabel, locationLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.distribution = .fillProportionally
    }
    
    //MARK: - Constraints settings
    private func setConstraints() {
        self.addSubview(image)
        image.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(Constants.imageLeadingOffset)
            make.height.equalTo(Constants.imageSize)
            make.width.equalTo(Constants.imageSize)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(Constants.nameLabelTopOffset)
            make.leading.equalTo(image.snp.trailing).offset(Constants.nameLabelHorizontalOffset)
            make.trailing.equalTo(self.snp.trailing).offset(-Constants.nameLabelHorizontalOffset)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.stackViewTopOffset)
            make.leading.equalTo(image.snp.trailing).offset(Constants.stackViewHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.stackViewHorizontalOffset)
        }
    }
}
