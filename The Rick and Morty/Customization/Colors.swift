
import UIKit

enum Color {
    
    case background
    case button
    case buttonTintColor
    case nbBarTintColor
    case nbTintColor
    
    var color: UIColor? {
        switch self {
            case .background:
                return UIColor(displayP3Red: 144/255, green: 200/255, blue: 172/255, alpha: 1)
                
            case .button:
                return UIColor(displayP3Red: 245/255, green: 240/255, blue: 187/255, alpha: 1)
                
            case .buttonTintColor:
                return UIColor(displayP3Red: 115/255, green: 169/255, blue: 173/255, alpha: 1)
                
            case .nbTintColor:
                return UIColor(displayP3Red: 37/255, green: 109/255, blue: 133/255, alpha: 1)
                
            case .nbBarTintColor:
                return UIColor(displayP3Red: 245/255, green: 240/255, blue: 187/255, alpha: 1)
        }
    }
}
