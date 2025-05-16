from pymongo import MongoClient


class TestMongo:
    @classmethod
    def setup_class(cls):
        cls.client = MongoClient('mongodb://root:example@localhost:27017')
        cls.db = cls.client['test']
        cls.collection = cls.db['test_collection']

    @classmethod
    def teardown_class(cls):
        result = cls.collection.delete_many({})
        print(f"Deleted {result.deleted_count} document(s)")

    def setup_method(self):
        pass

    def test_create(self):
        document = {"name": "Alice", "age": 30}
        inserted_id = self.collection.insert_one(document).inserted_id
        print(f"Inserted document with _id: {inserted_id}")

        documents = [
            {"name": "Bob", "age": 25},
            {"name": "Charlie", "age": 35}
        ]
        result = self.collection.insert_many(documents)
        print(f"Inserted documents with _id: {result.inserted_ids}")

        docs = self.collection.find()
        assert (len(docs.to_list()) == 3)

    def test_update(self):
        result = self.collection.update_one(
            {"name": "Bob"}, {"$set": {"age": 28}})
        assert (result.modified_count == 1)
        print(f"Updated {result.modified_count} document(s)")

    def test_delete(self):
        result = self.collection.delete_one({"name": "Bob"})
        assert (result.deleted_count == 1)
        print(f"Delete {result.deleted_count} document(s)")
