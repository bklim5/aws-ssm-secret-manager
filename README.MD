# AWS SSM Parameter Store SecretManager class

This class provides some functions for retrieving secrets / parameters stored in AWS Parameter Store

### Getting started
```
pip install ssm_secret_manager
```

### Create a SecretManager instance
```
from ssm_secret_manager import SecretManager

CONFIG = {
    'region_name': 'us-east-1',
    'SECRETS': {
        'secret_name_1': 'secret_key_1_in_parameter_store',
        'secret_name_2': 'secret_key_2_in_parameter_store'
    }
}

secret_manager = SecretManager(
    region_name=CONFIG['region_name'],
    secrets_mapping=CONFIG['SECRETS']
)
```

SecretManager will fetch the value from parameter store based on the key defined in the secrets_mapping dictionary, and set the value of the parameter to the secret name.

```
# subsequently, you access the secret via the following line
secret_value_1 = secret_manager.get_secret('secret_name_1')
secret_value_2 = secret_manager.get_secret('secret_name_2')
```

## Common Question
1. Encountered ParameterNotFound
    - Make sure the secret is being defined in the correct region in AWS, and your AWS profile has the permission to view the secret (i.e. correct IAM role permission)

2. What is the differences between `secret_name` and `secret_key_in_parameter_store` shown in the code example?
    - `secret_key_in_parameter_store` is the name of the parameter in AWS Parameter Store

        ![AWS Parameter Store](/images/AWS_Parameter_Store.jpg)
    - `secret_name` allows you to have a common variable / key name to access to the value of secret given different environment
    - For example, you have a `secret_name` - `DB_PASSWORD`. In dev environment your `secret_key_in_parameter_store` might be set to `DEV_DB_PASSWORD` while your prod environment it's set to `PROD_DB_PASSWORD`. Using SecretManager, you can retrieve the value for different environment using the common key name `DB_PASSWORD`, i.e. 
    ```
        secret_manager.get_secret('DB_PASSWORD')
    ```
