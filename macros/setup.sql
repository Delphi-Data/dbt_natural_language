{% macro setup(
        api_path = 'https://7f7si8f6k6.execute-api.us-east-1.amazonaws.com/query'
        api_key = none,
        client_id = none,
        iam_role = none,
        dev = none
    ) %}
    {% if api_key is none or client_id is none or iam_role is none %}
        {{ exceptions.raise_compiler_error("API key, Client ID, and IAM role must be provided. Please reach out to Michael Irvine on the dbt Slack or at michael.j.irvine@gmail.com to get your keys.") }}
    {% endif %}

    {{ return(adapter.dispatch('setup', 'natural_language')(api_key, client_id, iam_role, dev)) }}
{% endmacro %}

{% macro default__setup() %}
    {{ exceptions.raise_compiler_error("natural_language is not yet implemented for this adapter. Currently it is only available for Snowflake. Please get in touch with Michael Irvine on the dbt Slack or at michael.j.irvine@gmail.com.") }}
{% endmacro %}

{% macro snowflake__setup(
        api_path,
        api_key,
        client_id,
        iam_role,
        dev
    ) %}
    {% set create_api_integration %}
    CREATE
    OR REPLACE api integration delphi_external_api_aws api_provider = aws_api_gateway api_aws_role_arn = '{{ iam_role }}' api_allowed_prefixes =('{{ api_path }}') enabled = TRUE {% endset %}
    {% set create_external_function %}
    CREATE
    OR REPLACE EXTERNAL FUNCTION text_to_sql(
        question VARCHAR,
        metrics VARCHAR
    ) returns variant api_integration = delphi_external_api_aws headers = (
        'X-CLIENT-ID' = '{{ client_id }}',
        'X-API-KEY' = '{{ api_key }}'
    ) AS '{{ api_path }}' {% endset %}
    {% do run_query(create_api_integration) %}
    {% do run_query(create_external_function) %}
{% endmacro %}
