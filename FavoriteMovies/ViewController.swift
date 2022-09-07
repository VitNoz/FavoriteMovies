//
//  ViewController.swift
//  FavoriteMovies
//
//  Created by Vitalik Nozhenko on 02.09.2022.
//

import UIKit
import Collections

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var moviesOrderedSet = OrderedSet<Movie>()
    
    let titleLabel: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let yearLabel: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Year"
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(addButtonPress), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setConstraints()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesOrderedSet.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = moviesOrderedSet[indexPath.row].title + " " + "\(moviesOrderedSet[indexPath.row].year)"
        return cell
    }
    
    @objc func addButtonPress() {
        
        guard let inputTitle = titleLabel.text, !titleLabel.text!.isEmpty else { return }
        guard let inputYear = Int(yearLabel.text ?? ""), !yearLabel.text!.isEmpty else {
            yearLabel.text = ""
            return }
        let newMovie = Movie(title: inputTitle, year: inputYear)
        titleLabel.text = ""
        yearLabel.text = ""
        if moviesOrderedSet.insert(newMovie, at: moviesOrderedSet.endIndex).inserted {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: moviesOrderedSet.count-1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func setConstraints () {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        view.addSubview(yearLabel)
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            yearLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 5),
            addButton.widthAnchor.constraint(equalTo: yearLabel.widthAnchor, multiplier: 1/4),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

