{% macro _get_field(
        metrics,
        field
    ) %}
    {{ return (metrics | map(attribute = field) | list) }}
{% endmacro %}

{% macro _parse_graph_metrics(metrics) %}
    {% set ns = namespace(
        fields ={},
        parsedMetrics = []
    ) %}
    {% for field in ['name', 'dimensions', 'description', 'time_grains', 'label'] %}
        {% do ns.fields.update(
            { field: dbt_delphi._get_field(
                metrics,
                field
            ) }
        ) %}
    {% endfor %}

    {% for field in ns.fields ['name'] %}
        {% do ns.parsedMetrics.append(
            { "name": ns.fields ['name'] [loop.index - 1],
            "dimensions": ns.fields ['dimensions'] [loop.index - 1],
            "description": ns.fields ['description'] [loop.index - 1],
            "time_grains": ns.fields ['time_grains'] [loop.index - 1],
            "label": ns.fields ['label'] [loop.index - 1] }
        ) %}
    {% endfor %}

    {{ log(
        ns.parsedMetrics,
        info = True
    ) }}
    {{ return (tojson(ns.parsedMetrics)) }}
{% endmacro %}

{% macro _get_metrics() %}
    {{ return(
        dbt_delphi._parse_graph_metrics(graph.metrics.values())) }}
{% endmacro %}
