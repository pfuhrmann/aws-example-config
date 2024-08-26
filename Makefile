.PHONY: init-dev
init-dev:
	terraform -chdir="environments/development" init -reconfigure

.PHONY: plan-dev
plan-dev:
	terraform -chdir="environments/development" plan -input=true -out=dev.tfplan

.PHONY: apply-dev
apply-dev:
	terraform -chdir="environments/development" apply dev.tfplan

.PHONY: test-dev
test-dev:
	sh -c `curl $(terraform -chdir="environments/development" output -raw website_url)`

.PHONY: destroy-dev
destroy-dev:
	terraform -chdir="environments/development" plan -destroy -out=dev-destroy.tfplan
	terraform -chdir="environments/development" apply dev-destroy.tfplan

.PHONY: generate-docs
generate-docs:
	terraform-docs markdown table --output-file README.md --output-mode inject environments/development && \
	terraform-docs markdown table --output-file README.md --output-mode inject --recursive-include-main=false --recursive .

.PHONY: lint
lint:
	terraform fmt -recursive -check
	terraform validate -recursive
