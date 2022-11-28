{% macro setup(
        api_key = none,
        client_id = none,
        dev = none
    ) %}
    {{ return(adapter.dispatch('setup', 'dbt_delphi')(api_key, client_id, dev)) }}
{% endmacro %}

{% macro default__setup() %}
    {{ exceptions.raise_compiler_error("dbt_delphi is not yet implemented for this adapter. Currently it is only available for Snowflake. Please get in touch with Michael Irvine on the dbt Slack or at michael.j.irvine@gmail.com.") }}
{% endmacro %}

{% macro snowflake__setup(
        api_key,
        client_id,
        dev
    ) %}
    {% set create_api_integration %}
    CREATE
    OR REPLACE api integration delphi_external_api_aws api_provider = aws_api_gateway api_aws_role_arn = 'arn:aws:iam::474028228514:role/snowflake_delphi_api_gateway_role' api_allowed_prefixes =('https://7f7si8f6k6.execute-api.us-east-1.amazonaws.com') enabled = TRUE {% endset %}
    {% set create_external_function %}
    CREATE
    OR REPLACE EXTERNAL FUNCTION text_to_sql(
        question VARCHAR,
        metrics VARCHAR
    ) returns variant api_integration = delphi_external_api_aws headers = (
        'X-CLIENT-ID' = '{{ client_id }}',
        'X-API-KEY' = '{{ api_key }}'
    ) AS 'https://7f7si8f6k6.execute-api.us-east-1.amazonaws.com/{% if dev %}dev{% else %}query{% endif %}' {% endset %}
    {% do run_query(create_api_integration) %}
    {% do run_query(create_external_function) %}
{% endmacro %}
