from core.utils.JsonFileReader import JsonFileReader


class EnvironmentConfiguration(object):

    def __init__(self):
        self.config = JsonFileReader.read('config.json')
        self.variables = JsonFileReader.read('input_variables.json')

    def get_config_file(self):
        return self.config

    def get_variables_file(self):
        return self.variables
