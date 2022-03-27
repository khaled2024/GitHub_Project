//
//  RepositoriesViewController.swift
//  GitHub_Project
//
//  Created by KhaleD HuSsien on 24/03/2022.
//

import UIKit

class RepositoriesViewController: UIViewController{
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    var repositories: [Repository] = []
    
    //pagination vars
    var repositoriesPerPages = 10
    var limit = 10
    var Paginationrepositories: [Repository] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        self.configCell()
        self.getrepositories()
       
    }
    //MARK: - private functions
    private func configCell(){
        repositoriesTableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
    }
    func getrepositories(){
        ApiService.sharedService.getRepositories { (repositories: [Repository]?, error) in
            guard let repositories = repositories else {return}
            
            self.repositories = repositories
            self.limit = self.repositories.count
            for i in 0 ..< 10{
                self.Paginationrepositories.append(repositories[i])
            }
            DispatchQueue.main.async {
                self.repositoriesTableView.reloadData()
            }
        }
    }
    
    // pagination functions
    func setPaginationRepositories(repositoriesPerPages: Int){
        if repositoriesPerPages >= limit{
            return
        }
        else if repositoriesPerPages >= limit-10{
            for i in repositoriesPerPages ..< limit{
                Paginationrepositories.append(repositories[i])
            }
            self.repositoriesPerPages += 10
        }else{
            for i in repositoriesPerPages ..< repositoriesPerPages + 10{
                Paginationrepositories.append(repositories[i])
            }
            self.repositoriesPerPages += 10
        }
        DispatchQueue.main.async {
            self.repositoriesTableView.reloadData()
        }
    }
}
//MARK: - extension
extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Paginationrepositories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryCell.self), for: indexPath)as? RepositoryCell else{return UITableViewCell()}
        cell.configureCell(with: Paginationrepositories[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == repositoriesTableView{
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
                setPaginationRepositories(repositoriesPerPages: repositoriesPerPages)
            }
        }
    }
   
}
