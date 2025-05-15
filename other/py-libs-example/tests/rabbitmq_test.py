import pika
from pika.adapters.blocking_connection import BlockingChannel


class TestRabbitmq:

    @classmethod
    def setup_class(self):
        credentials = pika.PlainCredentials('root', 'example')
        self.conn = pika.BlockingConnection(pika.ConnectionParameters(
            host='localhost',
            port=5672,
            credentials=credentials
        ))
        self.channel: BlockingChannel = self.conn.channel()

    @classmethod
    def teardown_class(self):
        self.channel.queue_delete(queue='hello')
        self.conn.close()

    def test_pub_sub(self):
        # 声明队列
        self.channel.queue_declare(queue='hello')

        # 定义回调
        def callback(ch: BlockingChannel, method, props, body):
            print(f"[X] Received {body}")
            ch.stop_consuming()

        self.channel.basic_consume(
            queue='hello', on_message_callback=callback, auto_ack=True)

        # 发送消息
        self.channel.basic_publish(
            exchange='', routing_key='hello', body='hello world!')
        print("[X] Sent 'hello world!'")

        self.channel.start_consuming()
