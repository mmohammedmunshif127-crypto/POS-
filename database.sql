-- SQL Schema for POS System (SQLite/MySQL Compatible)
-- This file defines the relational structure of your database

-- 1. Users table
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  role TEXT DEFAULT 'USER',
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Categories table
CREATE TABLE IF NOT EXISTS categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 3. Products table
CREATE TABLE IF NOT EXISTS products (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  barcode TEXT UNIQUE,
  price REAL NOT NULL,
  costPrice REAL,
  stockQuantity INTEGER DEFAULT 0,
  category TEXT,
  image TEXT,
  isActive BOOLEAN DEFAULT 1,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category) REFERENCES categories(id)
);

-- 4. Customers table
CREATE TABLE IF NOT EXISTS customers (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  address TEXT,
  points INTEGER DEFAULT 0,
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 5. Sales table
CREATE TABLE IF NOT EXISTS sales (
  id TEXT PRIMARY KEY,
  invoiceNumber TEXT UNIQUE NOT NULL,
  customerId TEXT,
  cashierId TEXT NOT NULL,
  totalAmount REAL NOT NULL,
  discount REAL DEFAULT 0,
  tax REAL DEFAULT 0,
  grandTotal REAL NOT NULL,
  paymentMethod TEXT DEFAULT 'CASH',
  amountPaid REAL NOT NULL,
  changeBack REAL DEFAULT 0,
  status TEXT DEFAULT 'COMPLETED',
  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customerId) REFERENCES customers(id),
  FOREIGN KEY (cashierId) REFERENCES users(id)
);

-- 6. Sale Items table (Lines for each sale)
CREATE TABLE IF NOT EXISTS sale_items (
  id TEXT PRIMARY KEY,
  saleId TEXT NOT NULL,
  productId TEXT NOT NULL,
  quantity INTEGER NOT NULL,
  price REAL NOT NULL,
  subtotal REAL NOT NULL,
  FOREIGN KEY (saleId) REFERENCES sales(id),
  FOREIGN KEY (productId) REFERENCES products(id)
);
