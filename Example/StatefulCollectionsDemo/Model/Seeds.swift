//
//  Seeds.swift
//  StatefulCollectionsDemo
//
//  Created by Guillem Espejo on 29/02/2020.
//  Copyright © 2020 GuillemEspejo. All rights reserved.
//

import Foundation

struct Book{
    var name : String
    var author : String
}

struct Seeds{
    
    private static var bookList : [Book] = []
    
    static func getBookList() -> [Book] {
        if bookList.count == 0 {
            fillBookList()
        }
        
        return bookList
    }
    
    private static func fillBookList(){
        for i in 0...15 {
            let name = "Book \(i)"
            let author = "Author of book \(i)"
            let book = Book(name: name, author: author)
            bookList.append(book)
        }
    }
    
}


