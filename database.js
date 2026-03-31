const mongoose = require('mongoose');
require('dotenv').config({ path: '.env.local' });

const MONGODB_URI = process.env.MONGODB_URI;

if (!MONGODB_URI) {
  console.error('Error: MONGODB_URI is not defined in .env.local');
  process.exit(1);
}

/**
 * Connect to MongoDB Atlas
 */
async function connectToDatabase() {
  try {
    if (mongoose.connection.readyState >= 1) {
      return;
    }

    await mongoose.connect(MONGODB_URI);
    console.log('✅ Connected to MongoDB Atlas successfully.');
  } catch (error) {
    console.error('❌ Error connecting to MongoDB:', error.message);
    process.exit(1);
  }
}

// Export the connection and mongoose for use in other scripts
module.exports = {
  connectToDatabase,
  mongoose
};

/**
 * NOTE ON SQL (SQLite):
 * If you want to use a local SQL database (SQLite) for offline storage,
 * you would need to install the 'sqlite3' package:
 * 
 * npm install sqlite3
 * 
 * Then you can add SQLite connection logic here.
 */
