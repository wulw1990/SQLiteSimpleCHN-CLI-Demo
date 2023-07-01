//
//  main.swift
//  SQLiteSimpleCHN-CLI-Demo
//
//  Created by MacBook Air on 2023/7/1.
//

import Foundation
import SQLiteSimpleCHN

/// Create an in-memory database
let db = try Connection(.inMemory)

/// enable statement logging
db.trace { print($0) }

print("Hello, World!")

