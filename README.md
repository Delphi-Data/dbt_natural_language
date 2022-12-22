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

### Quickstart (using Delphi API)

1. Add the package to your `packages.yml` file:

```yaml
packages:
  - git: "https://github.com/Delphi-Data/dbt_natural_language.git"
    revision: 0.0.1
```

2. Install it by running `dbt deps`
3. Reach out to Michael Irvine [by email](mailto:michael@sightglassdata.com) or on the dbt Slack to get an IAM role, client ID, and API key.
4. Then, run the following setup command:

```bash
dbt run-operation natural_language.setup --args '{client_id: "YOUR_CLIENT_ID", api_key: "YOUR_API_KEY", iam_role: "YOUR_IAM_ROLE"}'
```

5. You're all set! Create a model or analysis using the `text_to_sql` macro. It lets you ask questions about your dbt metrics. For example:

```bash
{{ natural_language.text_to_sql('how many returns did we have in 2018 by customer?') }}
```

## Data/Privacy

Note that usage of this package via the Delphi API will send your metrics metadata and questions to an external API run by Michael Irvine and hosted on AWS. It will then forward these to OpenAI's Codex API to generate the query.

- The API does **not have access to the results of the query itself, only to your metrics metadata and question**.
- Logs may be used for troubleshooting and to improve the API but will not be used for any other purpose. I make no representations about how OpenAI will use the data, but their policies are available [on their website](https://openai.com).
- This is 100% free at the moment but may require a subscription if/when OpenAI charges for Codex.

If you are uncomfortable with this, you can also use your own OpenAI key or any other large language model you choose, including open source ones. It is tricky because you have to host your own AWS API Gateway, but it is doable. To do so, follow the ["using your own language model API" quickstart](/documentation/SELF_HOSTED.md).

## Acknowledgements

This package is based on the Snowflake external functions architecture laid out by Jacopo Tagliabue and Avanika Narayan in [Foundation Models for Entity Matching in dbt and Snowflake](https://github.com/jacopotagliabue/foundation-models-for-dbt-entity-matching)
