//
//  EditProfileViewController.swift
//  E-Mistri
//
//  Created by gurzu on 02/02/2023.
//

import UIKit
import Alamofire

class EditProfileViewController: UIViewController {

    @IBOutlet weak var editProfileScreenTitle: UILabel!
    @IBOutlet weak var goBackButton: CustomBackButton!
    @IBOutlet weak var editProfileTableView: UITableView!
    
    static let identifier: String = "EditProfileViewController"
    var userData: UserData = Storage.shared.load(key: Text.userKey)
    private var userImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewComponents()
        editProfileTableView.dataSource = self
        editProfileTableView.delegate = self
        editProfileTableView.register(
            UINib(
                nibName: EditPhotoTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: EditPhotoTableViewCell.identifier
        )
        editProfileTableView.register(
            UINib(
                nibName: EditProfileTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: EditProfileTableViewCell.identifier
        )
        editProfileTableView.separatorStyle = .none
    }
    
    private func viewComponents() {
        editProfileScreenTitle.text = "Edit Profile"
        editProfileScreenTitle.textAlignment = .center
        
        goBackButton.setupButton(buttonImage: Images.chevronBackward)
        goBackButton.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    
    @objc private func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension EditProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            guard let changePhotoCell = editProfileTableView.dequeueReusableCell(
                withIdentifier: EditPhotoTableViewCell.identifier,
                for: indexPath
            ) as? EditPhotoTableViewCell else {
                return UITableViewCell()
            }
            changePhotoCell.delegate = self
            changePhotoCell.selectionStyle = .none
            return changePhotoCell
        } else {
            guard let changeProfileCell = editProfileTableView.dequeueReusableCell(
                withIdentifier: EditProfileTableViewCell.identifier,
                for: indexPath
            ) as? EditProfileTableViewCell else {
                return UITableViewCell()
            }
            changeProfileCell.delegate = self
            changeProfileCell.selectionStyle = .none
            return changeProfileCell
        }
    }
}

extension EditProfileViewController: UITableViewDelegate {
    
}

extension EditProfileViewController: EditPhotoTableViewCellDelegate {
    func didTapEditPhotoButton() {
        let alert = UIAlertController(
            title: "Choose an option",
            message: .none,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "Select from gallery",
            style: .default,
            handler: { [weak self] (_: UIAlertAction!) in
                self?.navToGallery()
            }
        )
        )
        alert.addAction(UIAlertAction(
            title: "Click a photo",
            style: .default,
            handler: { [weak self] (_: UIAlertAction!) in
                self?.navToCamera()
            }
        )
        )
       present(alert, animated: true, completion: { 
           alert.view.superview?.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    self.alertControllerBackgroundTapped
                )
            )
           )
       })
    }
    
    private func navToGallery() {
        let galleryViewController = UIImagePickerController()
        galleryViewController.sourceType = .photoLibrary
        galleryViewController.delegate = self
        galleryViewController.allowsEditing = true
        present(galleryViewController, animated: true)
    }
    
    private func navToCamera() {
        let cameraViewController = UIImagePickerController()
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Source not available")
            return
        }
        cameraViewController.sourceType = .camera 
        cameraViewController.delegate = self
        present(cameraViewController, animated: true)
    }
    
    @objc private func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [
            UIImagePickerController.InfoKey: Any
        ]
    ) {
        guard let image = info[
            UIImagePickerController.InfoKey(
                rawValue: "UIImagePickerControllerEditedImage"
            )
        ] as? UIImage else {return}
        guard let cell = editProfileTableView.cellForRow(
            at: NSIndexPath(
                row: 0,
                section: 0
            ) as IndexPath) as? EditPhotoTableViewCell else { return }
        cell.profilePicture.image = image
        userImage = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController: EditProfileTableViewCellDelegate {
    func tappedEditProfileButton(isOkay: Bool, name: String, phoneNum: String, address: String) {
        if isOkay {
            let getResponse = { postResponse in
                print("API response:::::::", postResponse)
            }
            createPost(completion: getResponse,
                       userName: name,
                       phoneNumber: phoneNum,
                       address: address)
        } else {
            editProfileTableView.reloadData()
        }
    }
    
    func createPost(completion: @escaping (EditProfileResponse) -> Void,
                    userName: String,
                    phoneNumber: String,
                    address: String) {
        let token = KeyChain.getKeyChain()
        print(token)
        let header: HTTPHeaders = [
            "Authorization": token
        ]
        let body = CustomerDetails(fullName: userName,
                                   phoneNumber: phoneNumber,
                                   address: address)
        guard let profileImage = userImage else {return}
        let imgData = profileImage.jpegData(compressionQuality: 0.7)!
        let profilePicture = ["display_picture": imgData]
        AF.request("\(ApiURL.editProfileURL)\(userData.userId)",
                   method: .patch,
                   parameters: body,
                   encoder: JSONParameterEncoder.default,
                   headers: header
        ).validate().responseDecodable(
            of: EditProfileResponse.self
        ) { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case .success(let postResponse):
                debugPrint("Success::::::", postResponse)

                AF.upload(
                    multipartFormData: { (multiFormData) in
                    for(key, value) in profilePicture {
                        multiFormData.append(value, withName: key)
                    }
                    }, to: ApiURL.editDisplayPictureURL, method: .post).validate().responseJSON { response in
                    switch response.result {
                    case .success(let JSON):
                        print("response is :\(response)")
                        
                    case .failure(let error):
                        print("fail:::", error)
                    }
                }
                guard let name = response.value?.fullName,
                      let number = response.value?.phoneNumber else {
                    print("Empty Field")
                    return
                }
                strongSelf.userData.userName = name
                strongSelf.userData.userPhoneNumber = number
                strongSelf.userData.userAddress = response.value?.address
                Storage.shared.save(value: strongSelf.userData, key: Text.userKey)

                strongSelf.navigationController?.popViewController(animated: true)
                
                completion(postResponse)
                
            case .failure(let error):
                print("Error:::::::", error)
            }
        }
    }
}
