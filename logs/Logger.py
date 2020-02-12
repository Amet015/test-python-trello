import logging

from core.utils.EnvironmentConfiguration import EnvironmentConfiguration

config = EnvironmentConfiguration()

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
file_handler = logging.FileHandler(config.get_config_file()['log_path'])
formatter = logging.Formatter("%(asctime)s - [PID %(process)d] - %(name)s - [%(levelname)s] - %(message)s")
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)


def verify_logger(input_response):
    if input_response.status_code < 400:
        logger.setLevel(level=10)
        logger.debug("RESPONSE: %s", input_response.status_code)
        logger.info("RESPONSE: %s", input_response.reason)
    elif 400 >= input_response.status_code < 500:
        logger.setLevel(level=30)
        logger.warning("RESPONSE: %s", input_response.text)
    elif input_response.status_code >= 500:
        logger.setLevel(level=40)
        logger.error("Something was wrong: ", exc_info=True)
