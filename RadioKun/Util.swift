
import UIKit

class Util{
    
    public static func setFavoriteBtnImage(favoriteBtn: UIButton, state: Bool){
        // When it's favorite change to filled star, unfavorite change to empty star
        state ? favoriteBtn.setImage(UIImage(named: "filled_star"), for: .normal) : favoriteBtn.setImage(UIImage(named: "add_favorite"), for: .normal);
    }
}
