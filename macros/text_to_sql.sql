{% macro text_to_sql(question) %}
    {{ adapter.dispatch(
        'text_to_sql',
        'natural_language'
    )(question) }}
{% endmacro %}

{% macro default__text_to_sql() %}
    {{ exceptions.raise_compiler_error("natural_language.text_to_sql is not yet implemented for this adapter. Currently it is only available for Snowflake. Please get in touch with Michael Irvine on the dbt Slack or at michael.j.irvine@gmail.com.") }}
{% endmacro %}

{% macro snowflake__text_to_sql(question) %}
    -- depends_on: {{ ref('dbt_metrics_default_calendar') }}
    {% if execute %}
        {% set external_function_query %}
    SELECT
        text_to_sql(
            '{{ question }}',
            '{{ natural_language._get_metrics() }}'
        ) {% endset %}
        {% set results = run_query(external_function_query) %}
        {# There has to be a better way to do this than rendering twice... #}
        {% set rendered = render((results.columns [0].values() [0]) | replace('\\n', ' ') | replace('\\', "")) %}
        {{ render(
            "{{ " + rendered + "}} "
        ) }}
    {% else %}
    SELECT
        TRUE
    {% endif %}
{% endmacro %}
