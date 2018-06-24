import UIKit

class ThinkViewController: UIViewController {
  @IBOutlet weak var myPic1: UIImageView!
  @IBOutlet weak var myPic2: UIImageView!
  @IBOutlet weak var myIdeaName: UITextField!
  @IBOutlet weak var myIdeaMemo: UITextView!
  
  private var pImages: [PImage] = []
  private var pic1:PImage!
  private var pic2:PImage!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.pImages = PImageManager.fetchPImages()
    self.shuffleImages()
  }
  
  @IBAction func reloadImages(_ sender: UIBarButtonItem) {
    self.shuffleImages()
  }
  
  private func shuffleImages() {
    self.myIdeaName.text = ""
    self.myIdeaMemo.text = ""
    let count = UInt32.init(self.pImages.count)
    var ran:Int = 0
    ran = Int(arc4random_uniform(count))
    self.pic1 = self.pImages[ran]
    ran = Int(arc4random_uniform(count))
    self.pic2 = self.pImages[ran]
    myPic1.image = UIImage.init(named: self.pic1!.path)
    myPic2.image = UIImage.init(named: self.pic2!.path)
  }
  
  @IBAction func registerIdea(_ sender: UIButton) {
    var newIdea: [String:Any] = [:]
    newIdea["name"] = myIdeaName.text
    newIdea["memo"] = myIdeaMemo.text
    newIdea["pic1"] = Int16(self.pic1!.id)
    newIdea["pic2"] = Int16(self.pic2!.id)
    CDIdea.coreData.add(newIdea)
    self.showAlert()
  }
  
  private func showAlert() {
    let alertController = UIAlertController(
      title: "登録しました",
      message: "",
      preferredStyle: .alert
    )
    alertController.view.layer.cornerRadius = 25
    alertController.addAction(
      UIAlertAction(
        title: "OK",
        style: .default,
        handler: {_ in
          self.shuffleImages()
      }))
    present(alertController, animated: true, completion: nil)
  }
}
