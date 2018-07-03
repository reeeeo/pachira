import UIKit

class ThinkViewController: PachiraViewController {
  
  private var pImages: [PImage] = []
  private var pic1:PImage!
  private var pic2:PImage!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "th!nk"
    self.pImages = PImageManager.fetchPImages()
    self.addToolbarButton()
    self.addRefreshButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.shuffleImages()
  }
  
  private func addToolbarButton() {
    let myRegisterUIBarButton = UIBarButtonItem(
      barButtonSystemItem: .compose,
      target: self,
      action: #selector(self.registerIdea(_:)))
    self.myToolbar.items = [self.createFlexibleSpace(), myRegisterUIBarButton]
  }
  
  private func addRefreshButton() {
    let myRefreshUIBarButton = UIBarButtonItem(
      barButtonSystemItem: .refresh,
      target: self,
      action: #selector(self.reloadImages(_:)))
    self.navigationItem.rightBarButtonItem = myRefreshUIBarButton
  }
  
  @objc private func reloadImages(_ sender: UIBarButtonItem) {
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
    myPic1.image = self.pic1!.getUIImage()
    myPic2.image = self.pic2!.getUIImage()
  }
  
  @objc private func registerIdea(_ sender: UIBarButtonItem) {
    var newIdea: [String:Any] = [:]
    newIdea["name"] = myIdeaName.text
    newIdea["memo"] = myIdeaMemo.text
    newIdea["pic1"] = Int16(self.pic1!.id)
    newIdea["pic2"] = Int16(self.pic2!.id)
    if self.validateIdea(newIdea) {
      self.showNGAlert()
    } else {
      CDIdea.coreData.add(newIdea)
      self.showOKAlert()
    }
  }
  
  private func showOKAlert() {
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
