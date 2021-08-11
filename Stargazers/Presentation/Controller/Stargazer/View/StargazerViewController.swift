//
//  StargazerViewController.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import UIKit
import Lottie

class StargazerViewController: BaseViewController {
    
    @IBOutlet weak var ownerTextfield: UITextField!
    @IBOutlet weak var repositoryTextfield: UITextField!
    @IBOutlet weak var searchButton: CustomButton!
    @IBOutlet weak var stargazerTable: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var errorViewContainer: UIView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var errorIcon: UIImageView!
    
    var viewModel: StargazerViewModel?
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareUI()
        registerTableViewAndCell()
        ownerTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repositoryTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        bindViewModel()
    }

    /// Made some basic UI initial configurations
    private func prepareUI() {
        updateSearchButtonUI(active: false)
        updateErrorView(isHidden: true, errorMessage: nil)
        
        let animation = Animation.named("happy-star")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        animationView.alpha = 0
    }
    
    /// Register table view cells
    private func registerTableViewAndCell() {
        stargazerTable.dataSource = self
        stargazerTable.delegate = self
        
        stargazerTable.register(
            UINib(nibName: StargazerTableViewCell.XIB_NAME, bundle: nil),
            forCellReuseIdentifier: StargazerTableViewCell.IDENTIFIER
        )
    }
    
    /// Update search button UI
    /// - Parameter active: TRUE if button is active, FALSE otherwise
    private func updateSearchButtonUI(active: Bool) {
        searchButton.isEnabled = active
        searchButton.backgroundColor = active ? .systemBlue : .gray
        searchButton.tintColor = active ? .black : .white
    }
    
    /// Show or hide error view
    /// - Parameters:
    ///   - isHidden: TRUE if is hidden, FALSE otherwise
    ///   - errorMessage: Message to show
    ///   - isError: TRUE if is an error FALSE if is a message
    private func updateErrorView(isHidden: Bool, errorMessage: String?, isError: Bool = true) {
        var errorIconName = "warning_icon"
        
        if( !isError ) {
            errorIconName = "sad_face"
        }
        errorIcon.image = UIImage(named: errorIconName)
        errorViewContainer.alpha = isHidden ? 0 : 1
        stargazerTable.alpha = isHidden ? 1 : 0
        self.errorMessage.text = errorMessage ?? ""
        
    }
    
    /// Bind viewmodel with view controller
    private func bindViewModel() {
        
        if let viewModel = viewModel {
            viewModel.status.bind(to: activity) { [weak self] activity, _ in
                switch viewModel.status.value {
                case .none:
                    self?.activity.stopAnimating()
                    self?.updateErrorView(isHidden: true, errorMessage: nil)
                    break
                case .searching:
                    print("Searching...")
                    self?.activity.startAnimating()
                case .easterEggs:
                    self?.activity.startAnimating()
                    self?.runAnimation()
                case .success:
                    print("Search success")
                    self?.activity.stopAnimating()
                    self?.updateErrorView(isHidden: true, errorMessage: nil)
                    self?.stargazerTable.reloadData()
                case .zeroStars:
                    print("Repo with no stars found!")
                    self?.activity.stopAnimating()
                    self?.updateErrorView(isHidden: false, errorMessage: viewModel.errorMessage, isError: false)
                case .failure:
                    print("Search fails!")
                    self?.activity.stopAnimating()
                    self?.updateErrorView(isHidden: false, errorMessage: viewModel.errorMessage)
                }
            }
        } else {
            print("View model is ni")
        }
        
    }
    
    /// Run lottie animation
    private func runAnimation() {
        animationView.alpha = 1.0
        animationView.play(fromProgress: 0, toProgress: 0.5, loopMode: .playOnce, completion: { (finished) in
            if finished {
                print("Animation Complete")
                self.animationView.removeFromSuperview()
                self.animationView.alpha = 0.0
            } else {
                print("Animation cancelled")
            }
        })
    }
    
    /// Method called on textfield editing change. Check if search textfields are empty and update UI state
    /// - Parameter textField: Textifled changed
    @objc func textFieldDidChange(_ textField: UITextField) {
        var isActive = false
        
        if let owner = ownerTextfield.text, let repository = repositoryTextfield.text {
            if( owner.isEmpty || owner.count < 2 || repository.isEmpty || repository.count < 2 ) {
                isActive = false
            } else {
                isActive = true
            }
        } else {
            isActive = false
        }
        
        updateSearchButtonUI(active: isActive)
    }
    
    @IBAction func searchButtonDidPressed(_ sender: CustomButton) {
        if let owner = ownerTextfield.text, let repo = repositoryTextfield.text {
            viewModel?.search(for: owner, repository: repo)
        }
    }
    
}

extension StargazerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return StargazerTableViewCell.DEFAULT_HEIGHT
    }
    
}

extension StargazerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.stargazer?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: StargazerTableViewCell.IDENTIFIER, for: indexPath) as? StargazerTableViewCell {
            guard let model = viewModel, let stargazer = model.stargazer?[indexPath.row] else {
                return UITableViewCell()
            }
            cell.bind(stargazer: stargazer)
            return cell
        }
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            if( !(ownerTextfield.text?.isEmpty ?? true) && !(repositoryTextfield.text?.isEmpty ?? true) ) {
                viewModel?.loadMoreElements()
            }
        }
        
    }
    
}
