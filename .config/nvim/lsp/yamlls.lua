-- yaml-language-server: YAML with schema support
-- Install via Mason: :MasonInstall yaml-language-server
return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose" },
    root_markers = { ".git" },
    settings = {
        yaml = {
            validate = true,
            -- schemaStore pulls schemas from SchemaStore.org automatically
            schemaStore = { enable = true, url = "" },
        },
    },
}
