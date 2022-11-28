SELECT
    *
FROM
    {{ metrics.calculate(metric('orders'), grain = 'week', dimensions = ['customer_id'],) }}
