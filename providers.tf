provider "tfe" {}

provider "github" {
  app_auth {} # Required when using `GITHUB_APP_XXX` environment variables
}