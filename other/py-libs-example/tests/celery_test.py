# Run on Linux

import pytest
from typing import Any
from celery import Celery


@pytest.fixture(scope='session')
def celery_app():
    app: Celery = Celery(
        'testapp',
        broker="redis://:example@localhost:6379/0",
        backend="redis://:example@localhost:6379/0",
    )
    return app


@pytest.fixture(scope='function')
def celery_worker(celery_app):
    with celery_app.worker_main(argv=['worker']):
        yield


class TestCelery:

    @pytest.mark.skip(reason='Run on Linux')
    @pytest.mark.usefixtures('celery_worker')
    def test_async_add(celery_app: Any):
        @celery_app.task()
        def add(x, y):
            return x + y

        result = add.delay(4, 6)
        assert result.get() == 10
