import redis


class TestRedis:
    @classmethod
    def setup_class(cls):
        cls.r = redis.Redis(
            host='localhost',
            port=6379,
            db=0,
            password='example'
        )

    @classmethod
    def teardown_class(cls):
        cls.r.flushall()

    def test_str(self):
        self.r.set('key', 'value')
        print(self.r.get('key'))
        assert (self.r.get('key') == b'value')

    def test_list(self):
        self.r.lpush('list_key', 'item1', 'item2')
        items = self.r.lrange('list_key', 0, -1)
        for item in items: # type: ignore
            print(item)
        # assert (len(items) == 2)

    def test_hash(self):
        self.r.hset('hash_key', 'field1', 'value1')
        field_value = self.r.hget('hash_key', 'field1')
        print(field_value)
        assert (field_value == b'value1')

    def test_publish_subscribe(self):
        p = self.r.pubsub()
        p.subscribe('channel')
        # 模式匹配订阅
        # p.psubscribe('news-*')

        self.r.publish('channel', 'hello')

        for msg in p.listen():
            if msg['type'] == 'message':
                print(msg)
                assert (msg['data'] == b'hello')
                break

        p.unsubscribe('channel')
        # 取消模式匹配订阅
        # p.punsubscribe('news-*')
        p.close()
