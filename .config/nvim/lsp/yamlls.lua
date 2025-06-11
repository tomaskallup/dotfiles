return {
  single_file_support = true,
  settings = {
    yaml = {
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        ['https://json.schemastore.org/workflows.json'] = '/gc-workflows/*.json',
      },
    },
    redhat = { telemetry = { enabled = false } },
  },
}
