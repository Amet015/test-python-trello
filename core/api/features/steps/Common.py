from behave import step

from core.utils.BodyValidator import BodyValidator
from core.utils.SchemaValidator import SchemaValidator


@step('Sets a "{method}" request to "{endpoint}"')
def step_impl(context, method, endpoint):
    context.endpoint_value = endpoint
    context.data_table = context.table
    context.method = method


@step("Sends request")
def step_impl(context):
    context.json_response = context.request_api.do_request(context.method, context.endpoint_value,
                                                           context.data_table, context.id_dictionary)


@step('Should return status code {number:d}')
def step_impl(context, number):
    assert context.json_response.status_code == number


@step('Saves response as "{name_object}"')
def step_impl(context, name_object):
    context.id_dictionary[name_object] = context.json_response.json()['id']


@step('Validates schema with "{schema}"')
def step_impl(context, schema):
    result = SchemaValidator.validate(context.json_response.json(), schema)
    assert None is result


@step("Validates response body with")
def step_impl(context):
    INDEX_ONE = 0
    INDEX_TWO = 1
    result = BodyValidator.validate(context.json_response, context.table)
    assert True is result[INDEX_ONE], result[INDEX_TWO]


@step('Validates response message with message "{msg}"')
def step_impl(context, msg):
    assert context.json_response.text == msg


@step("Saves endpoint to delete")
def step_impl(context):
    value = context.endpoint_value + context.json_response.json()['id']
    context.cleaner_list.append(value)
