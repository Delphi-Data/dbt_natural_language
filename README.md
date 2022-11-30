# dbt_natural_language - Natural Language Queries for dbt

This dbt package makes working with metrics as easy as asking a question

```bash
{{ natural_language.text_to_sql('how many returns did we have in 2018 by customer?') }}
```

## Usage

### Requirements

- Snowflake
- dbt
- dbt metrics

### Quickstart

1. Add the package to your `packages.yml` file:

```yaml
packages:
  - git: "https://github.com/Delphi-Data/dbt_natural_language.git"
    revision: 0.0.0
```

2. Install it by running `dbt deps`
3. Reach out to Michael Irvine by email or on the dbt Slack to get an IAM role, client ID, and API key.
4. Then, run the following setup command:

```bash
dbt run-operation natural_language.setup --args '{client_id: "YOUR_CLIENT_ID", api_key: "YOUR_API_KEY", iam_role: "YOUR_IAM_ROLE"}'
```

5. You're all set! Create a model or analysis using the `text_to_sql` macro. It lets you ask questions about your dbt metrics. For example:

_models/returns.sql_

```bash
{{ natural_language.text_to_sql('how many returns did we have in 2018 by customer?') }}
```

## Acknowledgements

This package is based on the Snowflake external functions architecture laid out by Jacopo Tagliabue and Avanika Narayan in [Foundation Models for Entity Matching in dbt and Snowflake](https://github.com/jacopotagliabue/foundation-models-for-dbt-entity-matching)
