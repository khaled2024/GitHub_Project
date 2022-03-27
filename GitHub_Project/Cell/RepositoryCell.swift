//
//  RepositoryCell.swift
//  GitHub_Project
//
//  Created by KhaleD HuSsien on 24/03/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var RepositoryNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: - Private func
    func configureCell(with repository: Repository){
        RepositoryNameLbl.text = repository.repName
        guard let owner = repository.owner else{return}
        guard let imageUrl = owner.ownerImage else{return}
        self.ownerImage.load(urlString: imageUrl)
    }
    
}
