import os
from os import path
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base

Base = declarative_base()


class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(50), nullable=False)
    age = Column(Integer)


class TestORM:

    @classmethod
    def setup_class(cls):
        # create instance folder
        instance_path = path.join(path.dirname(
            path.dirname(__file__)), 'instance')
        if not path.exists(instance_path):
            os.makedirs(instance_path)

        cls.engine = create_engine('sqlite:///instance/orm.db')
        Base.metadata.create_all(cls.engine)
        Session = sessionmaker(bind=cls.engine)
        cls.session = Session()

    @classmethod
    def teardown_class(cls):
        cls.session.close()
        Base.metadata.drop_all(cls.engine)
        cls.engine.dispose()

    def test_create(self):
        user = User(name='Alice', age=18)
        self.session.add(user)
        self.session.commit()
        assert user.id is not None

        users = [
            User(name='Bob', age=25),
            User(name='Charlie', age=30)
        ]
        self.session.add_all(users)
        self.session.commit()
        assert len(self.session.query(User).all()) == 3

    def test_update(self):
        user = self.session.query(User).filter_by(name='Alice').first()
        user.age = 20 # type: ignore
        self.session.commit()
        assert user.age == 20 # type: ignore

    def test_delete(self):
        user = self.session.query(User).filter_by(name='Bob').first()
        self.session.delete(user)
        self.session.commit()
        assert len(self.session.query(User).all()) == 2
