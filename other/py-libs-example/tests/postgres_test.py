import psycopg2


class TestPostgres:
    @classmethod
    def setup_class(cls):
        cls.conn = psycopg2.connect(
            host='localhost',
            user='root',
            password='example',
            database='test',
            port=5432
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
                id SERIAL PRIMARY KEY,
                name VARCHAR(60) UNIQUE NOT NULL,
                age INT NOT NULL DEFAULT 0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
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
        id, _, _, _ = rows[0]  # (11, 'Bob', 25)

        # udpate
        cursor.execute("UPDATE users SET age = %s WHERE id = %s", (35, id))
        self.conn.commit()

        # check
        cursor.execute("SELECT * FROM users WHERE id = %s", (id,))
        rows = cursor.fetchall()
        assert (len(rows) == 1)
        _, _, age, _ = rows[0]
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
