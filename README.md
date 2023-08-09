## Cloud-Native Static Website Hosting on AWS with Terraform and implementing CI/CD 

- This project deploys a static website on Amazon S3 using cloud-native services. 
- DNS management is handled through Route53 and SSL certificate management via ACM. 
- The website's performance is optimized using CloudFront as a CDN. 
- CI/CD is achieved through GitHub Actions.
- Terraform is used to create and manage the entire Infrastructure.

## AWS Services Used 

| Service        | Purpose                 |
| -------------- | ----------------------- |
| Amazon S3      | Host the static website |
| Route53        | Manage DNS              |
| ACM            | Manage SSL certificates |
| CloudFront     | Used for CDN            |
| GitHub Actions | CI/CD                   |
| Terraform | IaC                          |

## Architecture Diagram
// todo
## Function of each file 

| File                               | Description                                                                                                            |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| .github/workflows/deploy-to-s3.yml | Workflow to sync `demo_static_site/*` to the S3 bucket.                                                                |
| demo_static_site                   | Our static website.                                                                                                    |
| provider.tf                        | Defines the provider block for Terraform.                                                                              |
| backend.tf                         | Configures a remote S3 backend to store and manage the Terraform state file.                                           |
| vars.tf                            | Stores different variables to be used across entire project.                                                           |
| s3_static_hosting.tf               | Creates a s3 bucket and enables static hosting.                                                                        |
| route_53.tf                        | Creates a public hosted zone and configures `A Record (Alias)` for CloudFront for our domain.                          |
| acm_cert.tf                        | Creates an SSL certificate and validates it for our domain and hosted zone.                                            |
| cloudfront.tf                      | Creates a CloudFront distribution with the above created S3 bucket and ACM, as origin and SSL Certificate respectively. |

## Alternate Architectures 
#### 1. Using `AWS Codepipeline` instead of Github action to implement CI/CD
- Codepipeline creates another new bucket to store archive of the artifact after each execution of the pipeline.
- At each pipeline execution, codepipeline fetches a zip of all files, stores it in a bucket and then extracts it and replaces the Site bucket with these files 
- Our Github action updates only those files that are changed but Codepipeline replaces all the files regardless of whether changed or not. 
- Github action is free while Codepipeline charges for each pipeline execution.
##### Pros
- More resilient and Highly available
- Failover is easy 

##### Cons 
- More costly 
- Operational overhead

Since Our project doesn't require us to build the site. Codepipeline is underused and could be considered when we need to build our application at each update. 

#### 2. Using Github webhook + API Gateway + AWS Lambda to implement CI/CD
- GitHub webhook will send a request to the API gateway which then will trigger the lambda function
- Lambda function will fetch a zip of all the files from the GitHub repository, unzip it and replaces all the current files of the s3 bucket with these new files 
- We can use s3 versioning for failover. 

##### Pros
- More resilient and Highly available
- Failover is easy 

##### Cons 
- More costly 
- Operational overhead 

Since Our project doesn't require us to build the site. The lambda function is underused, which in our case does copy and paste. It should be considered when we require more complex computation at build and deployment.
