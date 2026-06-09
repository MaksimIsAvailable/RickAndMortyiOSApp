//
//  RMCharacterViewController.swift
//  RickAndMorty1
//
//  Created by Maksim on 12/17/25.
//

import UIKit

final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {
   
    private let characterListView = RMCharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
    }
    
    private func setUpView() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])  
    }
    
    //MARK: - RMCharacterListViewDelegate
    
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCaharcter character: RMCharacter) {
        // open detail controller
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}










//let request = RMRequest(
//    endPoint: .character,
//    queryParameters: [
//        URLQueryItem(name: "name", value: "rick"),
//        URLQueryItem(name: "status", value: "alive")
//    ]
//)
//print(request.url)
//
//RMService.shared.execute(request, expecting: RMCharacter.self) { result in
//    switch result {
//    case .success:
//        break
//    case .failure(let error):
//        print(String(describing: error))
//    }
//}
