module "api" {
  source = "./modules/api"
  name = local.name
}

// TODO: Complete with Lambdas

module "operation_endpoint" {
  count = length(local.endpoints)

  source = "./modules/operation_endpoint"
  target_api = local.name
  operation = local.endpoints[count.index].operation

  depends_on = [
    module.api
  ]
}

// TODO: Implement

module "documentation_endpoint" {
  source = "./modules/documentation_endpoint"
  target_api = local.name
  depends_on = [
    module.api
  ]
}

module "deployment" {
  source = "./modules/deployment"
  target_api = local.name
  depends_on = [
    module.api, module.operation_endpoint, module.documentation_endpoint
  ]
}