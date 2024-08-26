# AWS Terraform Exercise

This repository contains the Terraform code to create an load-balanced web server environment in AWS.
Best practices are followed in terms of security with public and private subnets, security groups, etc.

The environment consists of the following components:

- VPC
- Subnets (public and private)
- Security Groups
- Internet Gateway
- NAT Gateway
- Route Tables
- Route Table Associations
- Elastic Load Balancer
- Launch Configuration (EC2 instances)
- Auto Scaling Group

## Repository Structure

The repository is structured as follows:

- `environments/{environment}` - Terraform code for the environments.
  As a best practice, the code is organized into separate directories for each environment instead of Terraform
  workspaces.
  The code used to create the resources in AWS and uses the modules from the `modules` directory.
- `modules` - Terraform modules for the resources. The modules are used in the development environment.
  These modules are reusable and can be used in other environments as well.
  They could be published to the Terraform Registry or a private module registry.

## Usage

### Prerequisites

- `terraform` CLI v1.6+ installed
- `aws` CLI installed and configured with the necessary credentials
- `curl` installed (optional, for testing)

### Makefile Usage

We can use the `Makefile` to run the Terraform commands. The following commands are available:

1. Initialize terraform

    ```bash
    make init-dev
    ```

2. Plan changes

    ```bash
    make plan-dev
    ```

3. Apply changes

    ```bash
    make apply-dev
    ```

4. Test the application URL.
   > Note: This command requires `curl` to be installed
   and it might take some time for the load balancer to be ready.

    ```bash
    make test-dev
    ```

5. Destroy the resources

    ```bash
    make destroy-dev
    ```

### Manual Usage

Alternatively, we can run the Terraform commands manually:

1. Change directory to `./environments/development`
2. Run `terraform init` to initialize the working directory
3. Run `terraform plan -input=true -out=dev.tfplan` to create an execution plan
4. Run `terraform apply dev.tfplan` to apply the changes
5. Test the application URL by running `curl $(terraform output -raw website_url)`
5. Run `terraform destroy` to destroy the resources

## Terraform Docs

- See the README.md in the `./environments/development` directory for more information on the Terraform modules and
resources.

## Future Improvements

This exercise is a basic implementation of a load-balanced web server environment in AWS.
Time permitting, the following improvements could be made to enhance the codebase:

- Add more cofiguration options for the EC2 instances, load balancer, etc.
- Enhanced documentation to explain the modules and resources in detail
- Architecture diagram to visualize the environment
- Create custom AMIs for the EC2 instances with the necessary software and configurations and remove NAT Gateway
- Write sensible tests to verify the environment (with Terratest)
- Add CI/CD pipelines to automate the deployment process (with GitHub Actions)
- Define monitoring, alerting and logging for the environment (CloudWatch, CloudTrail, etc.)

## Author

- Patrik Fuhrmann ([@pfuhrmann](https://github.com/pfuhrmann))

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
