from os import path, makedirs
from minio import Minio
from minio.error import S3Error

access_key = 'VBv5eQxXC1keJ0bbT4v7'
secret_key = 'zR0beNxBavgB4N5TaYvll1JjT5SkTHHmu5MzAUf0'


class TestMinio:
    bucket_name: str = 'test-bucket'

    @classmethod
    def setup_class(cls):
        cls.client = Minio(
            endpoint="localhost:9000",
            access_key=access_key,
            secret_key=secret_key,
            secure=False
        )

        cls.instance_path = path.join(path.dirname(
            path.dirname(__file__)), 'instance')
        if not path.exists(cls.instance_path):
            makedirs(cls.instance_path)
        cls.object_name = 'test.txt'
        cls.origin_file = path.join(cls.instance_path, cls.object_name)
        if not path.exists(cls.origin_file):
            f = open(cls.origin_file, 'w')
            f.close()
        cls.download_path = path.join(cls.instance_path, 'download.txt')

    @classmethod
    def teardown_class(cls):
        try:
            cls.client.remove_bucket(cls.bucket_name)
            print(f"Delete Bucket {cls.bucket_name} Succeed")
        except S3Error as e:
            print(f"Delete Bucket {cls.bucket_name} Failed: {e}")

    def test_create_bucket(self):
        try:
            if not self.client.bucket_exists(self.bucket_name):
                self.client.make_bucket(self.bucket_name)
                print(f"Create Bucket {self.bucket_name} Succeed")
            else:
                print(f"Create Bucket {self.bucket_name} Already Exists")
        except S3Error as e:
            print(f"Create Bucket {self.bucket_name} Failed: {e}")

    def test_upload_file(self):
        try:
            self.client.fput_object(
                self.bucket_name, self.object_name, self.origin_file)
            print(f"Upload {self.object_name} To {self.bucket_name} Succeed")
        except S3Error as e:
            print(
                f"Upload {self.object_name} To {self.bucket_name} Failed: {e}")

    def test_download_file(self):
        try:
            self.client.fget_object(
                self.bucket_name, self.object_name, self.download_path)
            print(
                f"Download {self.object_name} To {self.download_path} Succeed")
        except S3Error as e:
            print(
                f"Download {self.object_name} To {self.download_path} Failed: {e}")

    def test_delete_file(self):
        try:
            self.client.remove_object(self.bucket_name, self.object_name)
            print(f"Delete {self.object_name} Succeed")
        except S3Error as e:
            print(
                f"Delete {self.object_name} Failed: {e}")
