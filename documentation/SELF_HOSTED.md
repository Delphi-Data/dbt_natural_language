## Quickstart (using your own language model API)

1. Add the package to your `packages.yml` file:

```yaml
packages:
  - git: "https://github.com/Delphi-Data/dbt_natural_language.git"
    revision: 0.0.0
```

2. Install it by running `dbt deps`
3. Sign up for OpenAI at [their website](www.openai.com). Alternatively, choose another large language model provider or host an open source model of your choosing on e.g. Huggingface (how to do this is outside the scope of this README).
4. Follow the steps in [this guide](https://interworks.com/blog/2020/08/14/zero-to-snowflake-setting-up-snowflake-external-functions-with-aws-lambda/) to set up an AWS Lambda API that takes queries from Snowflake, sends them to the LLM from step #3, and returns a metrics query. It should take in a request that looks like:

```json
{
  "data": [
    [
      0,
      "how many widgets did we sell last month?",
      "YOUR METRICS SCHEMA AS A STRING"
    ]
  ]
}
// note: the 0 above is a line number; you can ignore it
```

5. It should return a response that looks like:

```json
{ "data": [[0, "select * from {{ metrics.calculate(..."]] }
// note: the 0 above is a line number; you can ignore it
```

6. In dbt, run the following setup command:

```bash
dbt run-operation natural_language.setup --args '{api_path: "YOUR_API_PATH_HERE", client_id: "YOUR_CLIENT_ID", api_key: "YOUR_API_KEY (optional)", iam_role: "YOUR_IAM_ROLE"}'
```

7. You're all set!
