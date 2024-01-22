# GitHub repository Terraform module

GitHub repository module which manages configuration and life-cycle 
of all your GitHub repository configuration.

## Permissions

To manage the GitHub resources, provide a token from an account or a GitHub App with 
appropriate permissions. It should have `repository creation` and `manage actions repository secrets`.

## Authentication

The GitHub provider requires a GitHub token or GitHub App installation in order to manage resources.

There are several ways to provide the required token:

- Set the `token` argument in the provider configuration. You can set the `token` argument in the provider configuration. Use an
input variable for the token.
- Set the `GITHUB_TOKEN` environment variable. The provider can read the `GITHUB_TOKEN` environment variable and the token stored there
to authenticate.

There are several ways to provide the required GitHub App installation:

- Set the `app_auth` argument in the provider configuration. You can set the app_auth argument with the id, installation_id and pem_file
in the provider configuration. The owner parameter is also required in this situation.
- Set the `GITHUB_APP_ID`, `GITHUB_APP_INSTALLATION_ID` and `GITHUB_APP_PEM_FILE` environment variables. The provider can read the GITHUB_APP_ID,
GITHUB_APP_INSTALLATION_ID and GITHUB_APP_PEM_FILE environment variables to authenticate.

> Because strings with new lines is not support:</br>
> use "\\\n" within the `pem_file` argument to replace new line</br>
> use "\n" within the `GITHUB_APP_PEM_FILE` environment variables to replace new line</br>

## Features

- Create and manage repositories within your GitHub organization or personal account.
- Configure branch protection for repositories in your organization or personal account.
- Create and manage GitHub Actions secrets within your GitHub repositories.
- Enable and manage GitHub Actions permissions for your GitHub repository.
- Create and manage branches within your repository.
- create and manage files within a GitHub repository.

## Usage example
```hcl
module "repository" {
  source = "./modules/github_repository"

  name               = "Repository Name"
  destination_type   = "This is a description for the GitHub repository."
  branch_protections = [
    {
      pattern                         = "main"
      enforce_admins                  = true
      require_conversation_resolution = true
      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        require_code_owner_reviews      = true
        required_approving_review_count = "1"
      }
    }
  ]
  actions_secrets = [
    {
      secret_name     = "Secret Name"
      plaintext_value = "Secret Value"
    }
  ]
  allowed_actions = "selected"
  allowed_actions_config = {
    github_owned_allowed = true
    patterns_allowed     = ["terraform-docs/gh-actions@*", "hashicorp/*"]
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_github"></a> [github](#requirement\_github) (5.44.0)

## Providers

The following providers are used by this module:

- <a name="provider_github"></a> [github](#provider\_github) (5.44.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [github_actions_repository_permissions.this](https://registry.terraform.io/providers/integrations/github/5.44.0/docs/resources/actions_repository_permissions) (resource)
- [github_actions_secret.this](https://registry.terraform.io/providers/integrations/github/5.44.0/docs/resources/actions_secret) (resource)
- [github_branch.this](https://registry.terraform.io/providers/integrations/github/5.44.0/docs/resources/branch) (resource)
- [github_branch_protection.this](https://registry.terraform.io/providers/integrations/github/5.44.0/docs/resources/branch_protection) (resource)
- [github_repository.this](https://registry.terraform.io/providers/integrations/github/5.44.0/docs/resources/repository) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: (Required) The name of the repository.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_actions_secrets"></a> [actions\_secrets](#input\_actions\_secrets)

Description:   (Optional) The actions\_secrets block supports the following:  
    secret\_name     : (Required) Name of the secret.  
    plaintext\_value : (Required) Plaintext value of the secret to be encrypted.

Type:

```hcl
list(object({
    secret_name     = string
    plaintext_value = string
  }))
```

Default: `[]`

### <a name="input_allow_auto_merge"></a> [allow\_auto\_merge](#input\_allow\_auto\_merge)

Description: (Optional) Set to true to allow auto-merging pull requests on the repository.

Type: `bool`

Default: `false`

### <a name="input_allow_merge_commit"></a> [allow\_merge\_commit](#input\_allow\_merge\_commit)

Description: (Optional) Set to false to disable merge commits on the repository.

Type: `bool`

Default: `true`

### <a name="input_allow_rebase_merge"></a> [allow\_rebase\_merge](#input\_allow\_rebase\_merge)

Description: (Optional) Set to false to disable rebase merges on the repository.

Type: `bool`

Default: `true`

### <a name="input_allow_squash_merge"></a> [allow\_squash\_merge](#input\_allow\_squash\_merge)

Description: (Optional) Set to false to disable squash merges on the repository.

Type: `bool`

Default: `true`

### <a name="input_allow_update_branch"></a> [allow\_update\_branch](#input\_allow\_update\_branch)

Description: (Optional) Set to true to always suggest updating pull request branches.

Type: `bool`

Default: `true`

### <a name="input_allowed_actions"></a> [allowed\_actions](#input\_allowed\_actions)

Description: (Optional) The permissions policy that controls the actions that are allowed to run. Can be one of: all, local\_only, or selected.

Type: `string`

Default: `"all"`

### <a name="input_allowed_actions_config"></a> [allowed\_actions\_config](#input\_allowed\_actions\_config)

Description:   (Optional) The allowed\_actions\_config block supports the following:  
    github\_owned\_allowed : (Required) Whether GitHub-owned actions are allowed in the repository.  
    patterns\_allowed     : (Optional) Specifies a list of string-matching patterns to allow specific action(s). Wildcards, tags, and SHAs are allowed. For example, monalisa/octocat@, monalisa/octocat@v2, monalisa/."  
    verified\_allowed     : (Optional) Whether actions in GitHub Marketplace from verified creators are allowed. Set to `true` to allow all GitHub Marketplace actions by verified creators.

Type:

```hcl
object({
    github_owned_allowed = bool
    patterns_allowed     = optional(list(string), null)
    verified_allowed     = optional(bool, false)
  })
```

Default: `null`

### <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy)

Description: (Optional) Set to true to archive the repository instead of deleting on destroy.

Type: `bool`

Default: `false`

### <a name="input_archived"></a> [archived](#input\_archived)

Description: (Optional) Specifies if the repository should be archived. Defaults to false. NOTE Currently, the API does not support unarchiving.

Type: `bool`

Default: `false`

### <a name="input_auto_init"></a> [auto\_init](#input\_auto\_init)

Description: (Optional) Set to true to produce an initial commit in the repository.

Type: `bool`

Default: `false`

### <a name="input_branch_protections"></a> [branch\_protections](#input\_branch\_protections)

Description:     pattern                           : (Required) Identifies the protection rule pattern.  
    enforce\_admins                    : (Optional) Boolean, setting this to `true` enforces status checks for repository administrators.  
    require\_signed\_commits            : (Optional) Boolean, setting this to `true` requires all commits to be signed with GPG.  
    required\_linear\_history           : (Optional) Boolean, setting this to true enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch.  
    require\_conversation\_resolution   : (Optional) Boolean, setting this to true requires all conversations on code must be resolved before a pull request can be merged.  
    required\_status\_checks            : (Optional) The required\_status\_checks block supports the following:  
      strict                          : (Optional) Require branches to be up to date before merging.  
      contexts                        : (Optional) The list of status checks to require in order to merge into this branch. No status checks are required by default.  
    required\_pull\_request\_reviews     : (Optional) The required\_pull\_request\_reviews block supports the following:  
      dismiss\_stale\_reviews           : (Optional) Dismiss approved reviews automatically when a new commit is pushed.  
      restrict\_dismissals             : (Optional) Restrict pull request review dismissals.  
      dismissal\_restrictions          : (Optional) The list of actor Names/IDs with dismissal access. If not empty, restrict\_dismissals is ignored. Actor names must either begin with a \"/\" for users or the organization name followed by a \"/\" for teams.  
      pull\_request\_bypassers          : (Optional) The list of actor Names/IDs that are allowed to bypass pull request requirements. Actor names must either begin with a \"/\" for users or the organization name followed by a \"/\" for teams.  
      require\_code\_owner\_reviews      : (Optional) Require an approved review in pull requests including files with a designated code owner.  
      required\_approving\_review\_count : (Optional) Require x number of approvals to satisfy branch protection requirements. If this is specified it must be a number between 0-6.  
      require\_last\_push\_approval      : (Optional) Require that The most recent push must be approved by someone other than the last pusher.  
    push\_restrictions                 : (Optional) The list of actor Names/IDs that may push to the branch. Actor names must either begin with a \"/\" for users or the organization name followed by a \"/\" for teams.  
    force\_push\_bypassers              : (Optional) The list of actor Names/IDs that are allowed to bypass force push restrictions. Actor names must either begin with a \"/\" for users or the organization name followed by a \"/\" for teams.  
    allows\_deletions                  : (Optional) Boolean, setting this to `true` to allow the branch to be deleted.  
    allows\_force\_pushes               : (Optional) Boolean, setting this to `true` to allow force pushes on the branch.  
    blocks\_creations                  : (Optional) Boolean, setting this to `true` to block creating the branch.  
    lock\_branch                       : (Optional) Boolean, Setting this to `true` will make the branch read-only and preventing any pushes to it.

Type:

```hcl
list(object({
    pattern                         = string
    enforce_admins                  = optional(bool, false)
    require_signed_commits          = optional(bool, false)
    required_linear_history         = optional(bool, false)
    require_conversation_resolution = optional(bool, false)
    required_status_checks = optional(object({
      strict   = optional(bool, false)
      contexts = optional(list(string), [])
    }), null)
    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool, false)
      restrict_dismissals             = optional(bool, false)
      dismissal_restrictions          = optional(list(string), [])
      pull_request_bypassers          = optional(list(string), [])
      require_code_owner_reviews      = optional(bool, false)
      required_approving_review_count = optional(string, null)
      require_last_push_approval      = optional(bool, false)
    }), null)
    push_restrictions    = optional(list(string), [])
    force_push_bypassers = optional(list(string), [])
    allows_deletions     = optional(bool, false)
    allows_force_pushes  = optional(bool, false)
    blocks_creations     = optional(bool, false)
    lock_branch          = optional(bool, false)
  }))
```

Default: `[]`

### <a name="input_branches"></a> [branches](#input\_branches)

Description:   (Optional) The branches block supports the following:  
    branch        : (Required) The repository branch to create.  
    source\_branch : (Optional) The branch name to start from.

Type:

```hcl
list(object({
    branch        = string
    source_branch = optional(string, "main")
  }))
```

Default: `[]`

### <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge)

Description: (Optional) Automatically delete head branch after a pull request is merged. Defaults to false.

Type: `bool`

Default: `false`

### <a name="input_description"></a> [description](#input\_description)

Description: (Optional) A description of the repository.

Type: `string`

Default: `null`

### <a name="input_enabled"></a> [enabled](#input\_enabled)

Description: (Optional) Should GitHub actions be enabled on this repository?

Type: `bool`

Default: `true`

### <a name="input_gitignore_template"></a> [gitignore\_template](#input\_gitignore\_template)

Description: (Optional) Use the name of the template without the extension. For example, "Haskell".

Type: `string`

Default: `null`

### <a name="input_has_discussions"></a> [has\_discussions](#input\_has\_discussions)

Description: (Optional) Set to true to enable GitHub Discussions on the repository. Defaults to false.

Type: `bool`

Default: `false`

### <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues)

Description: (Optional) Set to true to enable the GitHub Issues features on the repository.

Type: `bool`

Default: `true`

### <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects)

Description: (Optional) Set to true to enable the GitHub Projects features on the repository. Per the GitHub documentation when in an organization that has disabled repository projects it will default to false and will otherwise default to true. If you specify true when it has been disabled it will return an error.

Type: `bool`

Default: `true`

### <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki)

Description: (Optional) Set to true to enable the GitHub Wiki features on the repository.

Type: `bool`

Default: `true`

### <a name="input_homepage_url"></a> [homepage\_url](#input\_homepage\_url)

Description: (Optional) URL of a page describing the project.

Type: `string`

Default: `null`

### <a name="input_ignore_vulnerability_alerts_during_read"></a> [ignore\_vulnerability\_alerts\_during\_read](#input\_ignore\_vulnerability\_alerts\_during\_read)

Description: (Optional) Set to true to not call the vulnerability alerts endpoint so the resource can also be used without admin permissions during read.

Type: `bool`

Default: `false`

### <a name="input_is_template"></a> [is\_template](#input\_is\_template)

Description: (Optional) Set to true to tell GitHub that this is a template repository.

Type: `bool`

Default: `false`

### <a name="input_license_template"></a> [license\_template](#input\_license\_template)

Description: (Optional) Use the name of the template without the extension. For example, "mit" or "mpl-2.0".

Type: `string`

Default: `null`

### <a name="input_merge_commit_message"></a> [merge\_commit\_message](#input\_merge\_commit\_message)

Description: Can be PR\_BODY, PR\_TITLE, or BLANK for a default merge commit message. Applicable only if allow\_merge\_commit is true.

Type: `string`

Default: `"PR_TITLE"`

### <a name="input_merge_commit_title"></a> [merge\_commit\_title](#input\_merge\_commit\_title)

Description: Can be PR\_TITLE or MERGE\_MESSAGE for a default merge commit title. Applicable only if allow\_merge\_commit is true.

Type: `string`

Default: `"MERGE_MESSAGE"`

### <a name="input_pages"></a> [pages](#input\_pages)

Description:   (Optional) The pages block supports the following:  
    source     : (Optional) The source block supports the following:  
      branch   : (Required) The repository branch used to publish the site's source files. (i.e. main or gh-pages.  
      path     : (Optional) The repository directory from which the site publishes (Default: /).  
    build\_type : (Optional) The type of GitHub Pages site to build. Can be legacy or workflow. If you use legacy as build type you need to set the option source.  
    cname      : (Optional) The custom domain for the repository. This can only be set after the repository has been created.

Type:

```hcl
object({
    source = optional(object({
      branch = string
      path   = optional(string, "/")
    }))
    build_type = optional(string, null)
    cname      = optional(string, null)
  })
```

Default: `null`

### <a name="input_security_and_analysis"></a> [security\_and\_analysis](#input\_security\_and\_analysis)

Description:   (Optional) The security\_and\_analysis block supports the following:  
    advanced\_security               : (Optional) The advanced\_security block supports the following:  
      status                        : (Required) Set to enabled to enable advanced security features on the repository. Can be enabled or disabled.  
    secret\_scanning                 : (Optional) The secret\_scanning block supports the following:  
      status                        : (Required) Set to enabled to enable secret scanning on the repository. Can be enabled or disabled. If set to enabled, the repository's visibility must be public or security\_and\_analysis[0].advanced\_security[0].status must also be set to enabled.  
    secret\_scanning\_push\_protection : (Optional) The secret\_scanning block supports the following:  
      status                        : (Required) Set to enabled to enable secret scanning push protection on the repository. Can be enabled or disabled. If set to enabled, the repository's visibility must be public or security\_and\_analysis[0].advanced\_security[0].status must also be set to enabled.

Type:

```hcl
object({
    advanced_security = optional(object({
      status = string
    }), null)
    secret_scanning = optional(object({
      status = string
    }), null)
    secret_scanning_push_protection = optional(object({
      status = string
    }), null)
  })
```

Default: `null`

### <a name="input_squash_merge_commit_message"></a> [squash\_merge\_commit\_message](#input\_squash\_merge\_commit\_message)

Description: (Optional) Can be PR\_BODY, COMMIT\_MESSAGES, or BLANK for a default squash merge commit message. Applicable only if allow\_squash\_merge is true.

Type: `string`

Default: `"COMMIT_MESSAGES"`

### <a name="input_squash_merge_commit_title"></a> [squash\_merge\_commit\_title](#input\_squash\_merge\_commit\_title)

Description: (Optional) Can be PR\_TITLE or COMMIT\_OR\_PR\_TITLE for a default squash merge commit title. Applicable only if allow\_squash\_merge is true.

Type: `string`

Default: `"COMMIT_OR_PR_TITLE"`

### <a name="input_template"></a> [template](#input\_template)

Description:   (Optional) The template block supports the following:  
    owner                : (Required) The GitHub organization or user the template repository is owned by.  
    repository           : (Required) The name of the template repository.  
    include\_all\_branches : (Optional) Whether the new repository should include all the branches from the template repository (defaults to false, which includes only the default branch from the template).

Type:

```hcl
object({
    owner                = string
    repository           = string
    include_all_branches = optional(bool, false)
  })
```

Default: `null`

### <a name="input_topics"></a> [topics](#input\_topics)

Description: (Optional) The list of topics of the repository.

Type: `list(string)`

Default: `null`

### <a name="input_visibility"></a> [visibility](#input\_visibility)

Description: (Optional) Can be public or private. If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be internal. The visibility parameter overrides the private parameter.

Type: `string`

Default: `"public"`

### <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts)

Description: (Optional) Set to true to enable security alerts for vulnerable dependencies. Enabling requires alerts to be enabled on the owner level. (Note for importing: GitHub enables the alerts on public repos but disables them on private repos by default.) See GitHub Documentation for details. Note that vulnerability alerts have not been successfully tested on any GitHub Enterprise instance and may be unavailable in those settings.

Type: `bool`

Default: `false`

## Outputs

The following outputs are exported:

### <a name="output_actions_secret"></a> [actions\_secret](#output\_actions\_secret)

Description: GitHub Actions secrets within your GitHub repository.

### <a name="output_branch_protection"></a> [branch\_protection](#output\_branch\_protection)

Description: GitHub branch protection within your GitHub repository.

### <a name="output_created_at"></a> [created\_at](#output\_created\_at)

Description: Date of actions\_secret creation.

### <a name="output_etag"></a> [etag](#output\_etag)

Description: An etag representing the Branch object.

### <a name="output_full_name"></a> [full\_name](#output\_full\_name)

Description: A string of the form "orgname/reponame".

### <a name="output_git_clone_url"></a> [git\_clone\_url](#output\_git\_clone\_url)

Description: URL that can be provided to git clone to clone the repository anonymously via the git protocol.

### <a name="output_github_actions_repository_permissions"></a> [github\_actions\_repository\_permissions](#output\_github\_actions\_repository\_permissions)

Description: GitHub Actions permissions for your repository.

### <a name="output_github_branch"></a> [github\_branch](#output\_github\_branch)

Description: Branches within your repository.

### <a name="output_github_repository"></a> [github\_repository](#output\_github\_repository)

Description: Repositories within your GitHub organization.

### <a name="output_html_url"></a> [html\_url](#output\_html\_url)

Description: URL to the repository on the web.

### <a name="output_http_clone_url"></a> [http\_clone\_url](#output\_http\_clone\_url)

Description: URL that can be provided to git clone to clone the repository via HTTPS.

### <a name="output_node_id"></a> [node\_id](#output\_node\_id)

Description: GraphQL global node id for use with v4 API.

### <a name="output_pages"></a> [pages](#output\_pages)

Description:   The block consisting of the repository's GitHub Pages configuration with the following additional attributes:  
    custom\_404 : Whether the rendered GitHub Pages site has a custom 404 page.  
    html\_url   : The absolute URL (including scheme) of the rendered GitHub Pages site e.g. https://username.github.io.  
    status     : The GitHub Pages site's build status e.g. building or built.

### <a name="output_primary_language"></a> [primary\_language](#output\_primary\_language)

Description: The primary language used in the repository.

### <a name="output_ref"></a> [ref](#output\_ref)

Description: A string representing a branch reference, in the form of refs/heads/<branch>.

### <a name="output_repo_id"></a> [repo\_id](#output\_repo\_id)

Description: GitHub ID for the repository.

### <a name="output_sha"></a> [sha](#output\_sha)

Description: A string storing the reference's HEAD commit's SHA1.

### <a name="output_source_sha"></a> [source\_sha](#output\_source\_sha)

Description: A string storing the commit this branch was started from. Not populated when imported.

### <a name="output_ssh_clone_url"></a> [ssh\_clone\_url](#output\_ssh\_clone\_url)

Description: URL that can be provided to git clone to clone the repository via SSH.

### <a name="output_svn_url"></a> [svn\_url](#output\_svn\_url)

Description: URL that can be provided to svn checkout to check out the repository via GitHub's Subversion protocol emulation.

### <a name="output_updated_at"></a> [updated\_at](#output\_updated\_at)

Description: Date of actions\_secret update.
<!-- END_TF_DOCS -->