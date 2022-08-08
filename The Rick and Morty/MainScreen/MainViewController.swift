
import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private enum Constants {
        static let buttonHeight = 50
        
        static let stackViewTopOffset = 20
        static let stackViewHorizontalOffset = 40
    }
    
    private enum Text {
        static let appName = "The Rick and Morty"
        static let charactersButton = "Персонажи"
        static let locationsButton = "Локации"
        static let episodesButton = "Эпизоды"
    }
    
    private var stackView = UIStackView()
    
    private let charactersButton = UIButton()
    private let locationsButton = UIButton()
    private let episodesButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 37/255, green: 109/255, blue: 133/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = Color.nbBarTintColor.color
        view.backgroundColor = Color.background.color
        title = Text.appName
        setupStackView()
        setConstraints()
        setButtons()
    }
}

//MARK: - Buttons settings
private extension MainViewController {
    
    func setButton(button: UIButton) {
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Color.button.color
        button.tintColor = Color.buttonTintColor.color
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
        }
        button.layer.borderColor = Color.button.color?.cgColor
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setButtons() {
        charactersButton.setTitle(Text.charactersButton, for: .normal)
        charactersButton.setImage(UIImage(systemName: "person.3"), for: .normal)
        
        locationsButton.setImage(UIImage(systemName: "network"), for: .normal)
        locationsButton.setTitle(Text.locationsButton, for: .normal)
        
        episodesButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        episodesButton.setTitle(Text.episodesButton, for: .normal)
        
        setButton(button: charactersButton)
        setButton(button: locationsButton)
        setButton(button: episodesButton)
    }
    
    @objc func buttonTapped(button: UIButton) {
        button.backgroundColor = Color.background.color
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (Timer) in
            self.updateUI(button: button)
        }
        
        switch button {
            case charactersButton:
                let charactersVC = CharactersViewController()
                self.navigationController?.pushViewController(charactersVC, animated: true)
            case locationsButton:
                let locationsVC = LocationsViewController()
                self.navigationController?.pushViewController(locationsVC, animated: true)
            case episodesButton:
                let episodesVC = EpisodesViewController()
                self.navigationController?.pushViewController(episodesVC, animated: true)
            default:
                break
        }
    }
    
    func updateUI(button: UIButton) {
        button.backgroundColor = Color.button.color
    }
}

//MARK: - View settings
private extension MainViewController {
    
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [charactersButton,
                                                   locationsButton,
                                                   episodesButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
    }
    
    func setConstraints() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.stackViewHorizontalOffset)
            make.trailing.equalToSuperview().offset(-Constants.stackViewHorizontalOffset)
        }
    }
}


