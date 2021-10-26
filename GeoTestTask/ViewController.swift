//
//  ViewController.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 25.10.2021.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class ViewController: UIViewController {
    let viewModel = UsersListViewModel()
    let tableView = UITableView()
    private let cellIdentidier = "UserCellId"

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getUsers()
    }

    private func showDetailScreen(user: User) {
//        let detailVC = DetailedUserInfoViewController(user: user)
//        present(detailVC, animated: true)
        let detailVC = DetailedUserInfoViewController(viewModel: UserDetailsViewModel(with: user))
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tableView.rx.setDelegate(self).disposed(by: disposeBag)

        tableView.register(UserCellView.self, forCellReuseIdentifier: cellIdentidier)
        tableView.tableFooterView = UIView()

        viewModel.users.bind(
            to: tableView.rx.items(
                cellIdentifier: cellIdentidier,
                cellType: UserCellView.self
            )
        ) { row, item, cell in
            cell.update(name: item.fullName, imageURL: item.avatar)
        }
        .disposed(by: disposeBag)

        tableView.rx.modelSelected(User.self).subscribe(onNext: { [weak self] item in
            self?.showDetailScreen(user: item)
        })
        .disposed(by: disposeBag)

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposeBag)

    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
