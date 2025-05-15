import os
from os import path
import sqlite3


class TestSqlite:
    @classmethod
    def setup_class(self):
        # check the db file
        instance_path = path.join(path.dirname(
            path.dirname(__file__)), 'instance')
        if not path.exists(instance_path):
            os.makedirs(instance_path)
        db_file = path.join(instance_path, 'test.db')
        if not path.exists(db_file):
            f = open(db_file, 'w')
            f.close()

        # connect
        self.conn = sqlite3.connect(db_file)

    def setup_method(self):
        cursor = self.conn.cursor()

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                age INTEGER
            )
        ''')

        self.conn.commit()

    @classmethod
    def teardown_class(self):
        cursor = self.conn.cursor()
        cursor.execute("DELETE FROM users")
        self.conn.commit()
        cursor.close()
        self.conn.close()

    def test_create(self):
        cursor = self.conn.cursor()

        # single
        cursor.execute(
            "INSERT INTO users (name, age) VALUES (?, ?)", ('Alice', 30))

        # multiple
        users = [('Bob', 25), ('Charlie', 35)]
        cursor.executemany(
            "INSERT INTO users (name, age) VALUES (?, ?)", users)

        self.conn.commit()

        cursor.execute("SELECT * FROM users")
        rows = cursor.fetchall()
        assert (len(rows) == 3)

        cursor.close()

    def test_update(self):
        # query
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM users WHERE name = ?", ("Bob",))
        rows = cursor.fetchall()
        assert (len(rows) == 1)
        id, _, _ = rows[0]  # (11, 'Bob', 25)

        # udpate
        cursor.execute("UPDATE users SET age = ? WHERE id = ?", (35, id))
        self.conn.commit()

        # check
        cursor.execute("SELECT * FROM users WHERE id = ?", (id,))
        rows = cursor.fetchall()
        assert (len(rows) == 1)
        _, _, age = rows[0]
        assert (age == 35)

        cursor.close()

    def test_delete(self):
        cursor = self.conn.cursor()

        # delete
        cursor.execute("DELETE FROM users WHERE name = ?", ("Bob",))
        self.conn.commit()

        # check
        cursor.execute("SELECT * FROM users")
        rows = cursor.fetchall()
        assert (len(rows) == 2)

        cursor.close()
