from core.api.request_api.RequestApi import RequestApi
from core.api.features.steps.Common import *
from logs.Logger import logger


def before_feature(context, feature):
    logger.info("START: %s", feature)


def before_scenario(context, scenario):
    context.id_dictionary = {}
    context.cleaner_list = []
    context.request_api = RequestApi()
    logger.info("START: %s", scenario)


def after_scenario(context, scenario):
    logger.info("END: %s", scenario)
    status_code_list = context.request_api.delete_object(context.cleaner_list)
    for status_code in status_code_list:
        assert status_code == 200


def after_feature(context, feature):
    logger.info("END: %s", feature)
