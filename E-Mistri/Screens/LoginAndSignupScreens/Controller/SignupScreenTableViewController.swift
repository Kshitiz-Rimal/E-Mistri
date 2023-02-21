//
//  SignupScreenTableViewController.swift
//  E-Mistri
//
//  Created by gurzu on 04/01/2023.
//

import UIKit
import Alamofire

class SignupScreenTableViewController: UITableViewController {
    
    static let identifier: String = "SignupScreenTableViewController"
    var userData: UserData = UserData(userId: 0,
                                      userName: "",
                                      userEmail: "",
                                      userPhoneNumber: "",
                                      userAddress: "",
                                      userIsActive: false,
                                      userProfilePicturePath: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tableView.register(
            UINib(
                nibName: HeaderTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: HeaderTableViewCell.identifier
        )
        tableView.register(
            UINib(
                nibName: SignupFormTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: SignupFormTableViewCell.identifier
        )
        tableView.separatorStyle = .none
    }
}

// MARK: - Table View DataSource

extension SignupScreenTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        if section == 0 {
            if let headerCell = tableView.dequeueReusableCell(
                withIdentifier: HeaderTableViewCell.identifier,
                for: indexPath
            ) as? HeaderTableViewCell {
                headerCell.primaryText?.text = Text.newAccountText
                headerCell.secondaryText?.text = Text.signupScreenSecondaryText
                headerCell.separatorInset = UIEdgeInsets.zero
                headerCell.layoutMargins = UIEdgeInsets.zero
                return headerCell
            }
        } else {
            if let bodyCell = tableView.dequeueReusableCell(
                withIdentifier: SignupFormTableViewCell.identifier
            ) as? SignupFormTableViewCell {
                bodyCell.delegate = self
                return bodyCell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - SignupFormTableViewCelldelegate

extension SignupScreenTableViewController: SignupFormTableViewCellDelegate {
    func pressedSignupButton(
        isValid: Bool,
        btnIsChecked: Bool,
        signupFullName: String,
        signupEmail: String,
        signupPassword: String
    ) {
        if isValid && btnIsChecked {
            
            let getResponse = { postResponse in
                print("API response:::::::", postResponse)
            }
            createPost(completion: getResponse,
                       userFullName: signupFullName,
                       userEmail: signupEmail,
                       userPassword: signupPassword)
        } else if !btnIsChecked {
            let alert = UIAlertController(
                title: ErrorMessages.alertText,
                message: .none,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "Okay",
                style: .default
            )
            )
           present(alert, animated: true)
            tableView.reloadData()
        } else {
            tableView.reloadData()
        }
    }
    
    func createPost(completion: @escaping (LoginAndSignUpResponse) -> Void,
                    userFullName: String,
                    userEmail: String,
                    userPassword: String) {
        let body = CustomerSignUp(
            customer: SignupDetails(
                fullName: userFullName,
                email: userEmail,
                password: userPassword
            )
        )
        AF.request(
            ApiURL.signUpURL,
                   method: .post,
                   parameters: body,
                   encoder: JSONParameterEncoder.default
        ).responseDecodable(
            of: LoginAndSignUpResponse.self
        ) { response in
            print("Response:::::::", response)
            switch response.result {
            case .success(let postResponse):
                debugPrint("Success::::::", postResponse)
                
                guard let userId = response.value?.status?.data?.id,
                      let fullName = response.value?.status?.data?.fullName,
                      let email = response.value?.status?.data?.email,
                      let phoneNumber = response.value?.status?.data?.phoneNumber else {
                    print("Field empty")
                    return
                }
                
                self.userData.userId = userId
                self.userData.userName = fullName
                self.userData.userEmail = email
                self.userData.userPhoneNumber = phoneNumber
                self.userData.userAddress = response.value?.status?.data?.address
                self.userData.userIsActive = true
                self.userData.userProfilePicturePath = ""
                
                Storage.shared.save(value: self.userData, key: Text.userKey)
                
                let dashboardScreenStoryboard = UIStoryboard(name: Storyboards.DashboardScreen, bundle: nil)
                guard let viewController = dashboardScreenStoryboard.instantiateViewController(
                    withIdentifier: TabBarController.identifier) as? TabBarController else {
                    return
                }
                self.navigationController?.pushViewController(viewController, animated: true)
                guard let token = response.response?.headers.value(for: Text.tokenHeader) else {
                    return
                }
                KeyChain.setKeyChain(userToken: token)
                completion(postResponse)
                
            case .failure(let error):
                print("Error:::::::", error)
            }
        }
    }
    
    func pressedSigninButton() {
        navigationController?.popViewController(animated: true)
    }
}
