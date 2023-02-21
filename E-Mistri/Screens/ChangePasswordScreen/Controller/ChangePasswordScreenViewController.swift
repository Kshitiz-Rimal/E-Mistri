//
//  ChangePasswordScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 01/02/2023.
//

import UIKit

class ChangePasswordScreenViewController: UIViewController {

    @IBOutlet weak var goBackButton: CustomBackButton!
    @IBOutlet weak var changePasswordScreenTitle: UILabel!
    @IBOutlet weak var changePasswordTableView: UITableView!
    
    static let identifier: String = "ChangePasswordScreenViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        viewComponents()
        changePasswordTableView.dataSource = self
        changePasswordTableView.delegate = self
        changePasswordTableView.register(
            UINib(
                nibName: ChangePasswordFormTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: ChangePasswordFormTableViewCell.identifier
        )
        changePasswordTableView.separatorStyle = .none
    }
    
    private func viewComponents() {
        changePasswordScreenTitle.text = "Change Password"
        changePasswordScreenTitle.textAlignment = .center
        
        goBackButton.setupButton(buttonImage: Images.chevronBackward)
        goBackButton.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    
    @objc private func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ChangePasswordScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let changePasswordCell = changePasswordTableView.dequeueReusableCell(
            withIdentifier: ChangePasswordFormTableViewCell.identifier,
            for: indexPath
        ) as? ChangePasswordFormTableViewCell else {
            return UITableViewCell()
        }
        return changePasswordCell
    }
}

extension ChangePasswordScreenViewController: UITableViewDelegate {
    
}
