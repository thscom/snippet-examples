import pytest
from elasticsearch import Elasticsearch

@pytest.mark.skip(reason='Docker pull the image of elasticsearch failed')
class TestElasticSearch:
    
    @classmethod
    def setup_class(cls):
        cls.es = Elasticsearch("http://localhost:9200")
        cls.index_name = 'test'
        mapping = {
            "mappings": {
                "properties": {
                    "title": {
                        "type": "text"
                    },
                    "content": {
                        "type": "text",
                        "analyzer": "ik_smart"
                    }
                }
            }
        }

        if not cls.es.indices.exists(index=cls.index_name):
            cls.es.indices.create(index=cls.index_name, body=mapping)

        doc = {
            "title": "测试文档",
            "content": "测试文档的内容"
        }
        cls.es.index(index=cls.index_name, id="1", body=doc)
    
    def test_search(self):
        query = {
            "query": {
                "match": {
                    "content": "测试文档"
                }
            }
        }
        res = self.es.search(index=self.index_name, body=query)
        print(res)
        assert res['hits']['total']['value'] == 1
