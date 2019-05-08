from pymongo import MongoClient

MONGO_HOST = "35.187.40.211"
MONGO_PORT = 27017
MONGO_DB = "db"
MONGO_USER = "user"
MONGO_PASS = "password"

connection = MongoClient(MONGO_HOST, MONGO_PORT)
db = connection[MONGO_DB]
db.authenticate(MONGO_USER, MONGO_PASS)

print(db.collection_names())