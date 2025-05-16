import pymysql


class TestMysql:
    @classmethod
    def setup_class(cls):
        cls.conn = pymysql.connect(
            host='localhost',
            user='root',
            passwd='example',
            database='test',
            port=3306,
            charset='utf8mb4'
        )

    @classmethod
    def teardown_class(cls):
        cursor = cls.conn.cursor()
        cursor.execute("DELETE FROM users")
        cls.conn.commit()
        cursor.close()
        cls.conn.close()

    def setup_method(self):
        cursor = self.conn.cursor()

        cursor.execute('''
            CREATE TABLE IF NOT EXISTS users (
                id INT PRIMARY KEY AUTO_INCREMENT,
                name VARCHAR(60) NOT NULL,
                age INT NOT NULL DEFAULT 0
            ) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
        ''')

        self.conn.commit()

    def test_create(self):
        cursor = self.conn.cursor()

        # single
        cursor.execute(
            "INSERT INTO users (name, age) VALUES (%s, %s)", ('Alice', 30))

        # multiple
        users = [('Bob', 25), ('Charlie', 35)]
        cursor.executemany(
            "INSERT INTO users (name, age) VALUES (%s, %s)", users)

        self.conn.commit()

        cursor.execute("SELECT * FROM users")
        rows = cursor.fetchall()
        assert (len(rows) == 3)

        cursor.close()

    def test_update(self):
        # query
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM users WHERE name = %s", ("Bob",))
        rows = cursor.fetchall()
        assert (len(rows) == 1)
        id, _, _ = rows[0]  # (11, 'Bob', 25)

        # udpate
        cursor.execute("UPDATE users SET age = %s WHERE id = %s", (35, id))
        self.conn.commit()

        # check
        cursor.execute("SELECT * FROM users WHERE id = %s", (id,))
        rows = cursor.fetchall()
        assert (len(rows) == 1)
        _, _, age = rows[0]
        assert (age == 35)

        cursor.close()

    def test_delete(self):
        cursor = self.conn.cursor()

        # delete
        cursor.execute("DELETE FROM users WHERE name = %s", ("Bob",))
        self.conn.commit()

        # check
        cursor.execute("SELECT * FROM users")
        rows = cursor.fetchall()
        assert (len(rows) == 2)

        cursor.close()
