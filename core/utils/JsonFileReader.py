import json


class JsonFileReader(object):

    @staticmethod
    def read(file_path):
        READ = 'r'
        with open(file_path, READ) as file:
            data = file.read()
        return json.loads(data)
