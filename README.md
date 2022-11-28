# Delphi - Natural Language Queries for dbt

The Delphi dbt package makes working with metrics as easy as asking a question

```bash
{{ dbt_delphi.text_to_sql('how many returns did we have in 2018 by customer?') }}
```

## Usage

### Requirements

- Snowflake
- dbt core

### Quickstart

1. Add the package to your `packages.yml` file:

```yaml
packages:
  - git: "https://github.com/Delphi-Data/dbt_delphi.git"
    revision: 0.0.0
```

2. Install it by running `dbt deps`
3. Reach out to Michael Irvine by email or on the dbt Slack to get an IAM role, client ID, and API key.
4. Then, run the following setup command:

```bash
dbt run-operation dbt_delphi.setup --args '{client_id: "YOUR_CLIENT_ID", api_key: "YOUR_API_KEY", iam_role: "YOUR_IAM_ROLE"}'
```

5. You're all set! Create a model or analysis using the `text_to_sql` macro or use it in interactive Semantic Layer queries. For example:

```bash
{{ dbt_delphi.text_to_sql('how many returns did we have in 2018 by customer?') }}
```

## Todo

1. Add readme
2. Demo video on Lightdash
3. Secure endpoint with IAM or make Snowflake not require it
4. Rotate IAM
