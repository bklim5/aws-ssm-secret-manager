from secret_manager.main import SecretManager


def test_secret_manager(mocker):
    mock_client = mocker.Mock()
    secrets_config = {
        'secret_name': 'some-key',
        'secret_name_2': 'some-key-2'
    }
    mock_client.return_value.get_parameter.side_effect = [{
        'Parameter': {
            'Value': 'some-secret-1'
        }
    }, {
        'Parameter': {
            'Value': 'some-secret-2'
        }
    }]

    mocker.patch('boto3.client', mock_client)
    secret_manager = SecretManager(secrets_mapping=secrets_config)
    assert secret_manager.get_secret('secret_name') == 'some-secret-1'
    assert secret_manager.get_secret('secret_name_2') == 'some-secret-2'
    assert secret_manager.get_secret('not-loaded') is None
