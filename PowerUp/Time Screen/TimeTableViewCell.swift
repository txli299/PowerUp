//
//  TimeTableViewCell.swift
//  PowerUp
//
//  Created by Dingbang Chen on 11/22/23.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelMachine: UILabel!
    var labelAmount: UILabel!
    var labelTime: UILabel!
    var ButtonDeactivate: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupLabelMachine()
        setupLabelAmount()
        setupLabeTime()
        setupDeactivateButton()
        
        initConstraints()
    }
    
    //MARK: defining the UI elements...
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        wrapperCellView.backgroundColor = UIColor.white
        wrapperCellView.layer.cornerRadius = 10
        wrapperCellView.layer.shadowColor = UIColor.black.cgColor
        wrapperCellView.layer.shadowOpacity = 0.5
        wrapperCellView.layer.shadowOffset = CGSize(width: 2, height: 2)
        wrapperCellView.layer.shadowRadius = 4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(wrapperCellView)
    }
    func setupDeactivateButton(){
        ButtonDeactivate = UIButton(type: .system)
        ButtonDeactivate.setTitle("Deactivate", for: .normal)
        ButtonDeactivate.backgroundColor = .red
        ButtonDeactivate.setTitleColor(UIColor.white, for: .normal)
        ButtonDeactivate.layer.cornerRadius = 20
        ButtonDeactivate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(ButtonDeactivate)
    }
    
    func setupLabelMachine(){
        labelMachine = UILabel()
        labelMachine.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelMachine)
    }
    func setupLabelAmount(){
        labelAmount = UILabel()
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelAmount)
    }
    func setupLabeTime(){
        labelTime = UILabel()
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTime)
    }
    
    
    //MARK: initializing the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelMachine.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 2),
            labelMachine.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            labelMachine.heightAnchor.constraint(equalToConstant: 32),
            labelMachine.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelTime.topAnchor.constraint(equalTo: labelMachine.bottomAnchor, constant: 2),
            labelTime.leadingAnchor.constraint(equalTo: labelMachine.leadingAnchor),
            labelTime.heightAnchor.constraint(equalToConstant: 32),
            labelTime.widthAnchor.constraint(lessThanOrEqualTo: labelMachine.widthAnchor),
            
            labelAmount.topAnchor.constraint(equalTo: labelTime.bottomAnchor, constant: 2),
            labelAmount.leadingAnchor.constraint(equalTo: labelMachine.leadingAnchor),
            labelAmount.heightAnchor.constraint(equalToConstant: 32),
            labelAmount.widthAnchor.constraint(lessThanOrEqualTo: labelAmount.widthAnchor),
            
            ButtonDeactivate.topAnchor.constraint(equalTo: labelAmount.bottomAnchor, constant: 16),
            ButtonDeactivate.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            ButtonDeactivate.widthAnchor.constraint(equalToConstant: 160),
            ButtonDeactivate.heightAnchor.constraint(equalToConstant: 40),
            wrapperCellView.heightAnchor.constraint(equalToConstant: 175)
        ])
    }
    
    //MARK: unused methods...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
