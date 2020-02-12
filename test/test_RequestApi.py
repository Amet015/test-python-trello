from core.api.request_api.RequestApi import RequestApi


def test_get_id_value_sendingValidRow_keyRow_valueAndDictionary_return1231231312aa2212133():
    row_key = "boardObject"
    row_value = "(boardObject.id)"
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    request_api = RequestApi()
    actual = request_api.get_id_value(row_key, row_value, id_dictionary)
    expected = "1231231312aa2212133"
    assert expected == actual


def test_get_id_value_sendingInvalidRow_keyAndValidRow_valueDictionary_returnNone():
    row_key = "boardObject"
    row_value = "(NoneBoardObject.id)"
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    request_api = RequestApi()
    actual = request_api.get_id_value(row_key, row_value, id_dictionary)
    expected = None
    assert expected == actual


def test_generate_data_sendsEmptyDataTable_returnKeyAndTokenAsDataDictionary():
    data_table = None
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    request_api = RequestApi()
    actual = request_api.generate_data(data_table, id_dictionary)
    expected = 2
    assert expected == len(actual)


def test_replace_variable_sendsValidDictionaryAndInputEndpoint_returnUrlConcatenatedWithId():
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    endpoint = "/boards/boardObject.id/labels"
    expected = "/boards/1231231312aa2212133/labels"
    request_api = RequestApi()
    actual = request_api.replace_variables(endpoint, id_dictionary)
    assert expected == actual


def test_replace_variable_sendsIValidDictionaryAndInputEndpoint_returnUrlWithoutChanges():
    id_dictionary = {"invalidBoardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    endpoint = "/boards/boardObject.id/labels"
    expected = "/boards/boardObject.id/labels"
    request_api = RequestApi()
    actual = request_api.replace_variables(endpoint, id_dictionary)
    assert expected == actual
