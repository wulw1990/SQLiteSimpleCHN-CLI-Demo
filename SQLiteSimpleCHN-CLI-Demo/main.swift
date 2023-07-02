//
//  main.swift
//  SQLiteSimpleCHN-CLI-Demo
//
//  Created by MacBook Air on 2023/7/1.
//

import Foundation
import SQLiteSimpleCHN

print("Hello, World!")

/// Create an in-memory database
let db = try Connection(.inMemory)

/// enable statement logging
db.trace { print($0) }


/// define a "users" table with some fields
let users = Table("users")

let id = Expression<Int64>("id")
let email = Expression<String>("email") // non-null
let name = Expression<String?>("name")  // nullable

/// prepare the query
let statement = users.create { t in
    t.column(id, primaryKey: true)
    t.column(email, unique: true, check: email.like("%@%"))
    t.column(name)
}

/// …and run it
try db.run(statement)

/// insert "alice"
let rowid = try db.run(users.insert(email <- "alice@mac.com"))

/// insert multiple rows using `insertMany`
let lastRowid = try db.run(users.insertMany([
  [email <- "bob@mac.com"],
  [email <- "mallory@evil.com"]
]))


let query = try db.prepare(users)
for user in query {
    print("id: \(user[id]), email: \(user[email])")
}
