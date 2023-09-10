# ChatAndFileService - Infrastructure

This is the infrastructure component of the ChatAndFileService project. It contains AWS CDK scripts written in TypeScript implementing the Infrastructure as Code (IaC).

## Why AWS CDK?

AWS CDK was selected for infrastructure-as-code due to its flexibility, support for multiple programming languages, and tight integration with AWS services.

Here are some of the great features of CDK:
- High level abstractions encapsulating AWS resources (including language support)
- Excellent documentation and community support
- Local testing is easy and the local CloudFormation templates can be diffed, evaluated, and validated easily

## Setup Commands

The project directory was intialized using the AWS CDK CLI.

```bash
cdk init app --language=typescript
```

## Build and Install

1. Navigate to the `infrastructure/` folder.
2. Run `npm install` to install dependencies.
3. Run `cdk deploy` to deploy the stack.

For more detailed instructions, refer to [official AWS CDK documentation](https://docs.aws.amazon.com/cdk/latest/guide/home.html).

The `cdk.json` file tells the CDK Toolkit how to execute your app.

## Useful commands

* `npm run build`   compile typescript to js
* `npm run watch`   watch for changes and compile
* `npm run test`    perform the jest unit tests
* `cdk deploy`      deploy this stack to your default AWS account/region
* `cdk diff`        compare deployed stack with current state
* `cdk synth`       emits the synthesized CloudFormation template

## AWS Services

### User Service

- **Technology**: AWS Cognito
- **Purpose**: Manages user profiles and handles authentication.
  
### Chat Service

- **Technology**: AWS DynamoDB, SNS/SQS
- **Purpose**: DynamoDB for storing chat messages, and SNS/SQS for real-time updates.

### File Service

- **Technology**: AWS S3, CloudFront
- **Purpose**: S3 for file storage and CloudFront for faster downloads.

### Channel Service

- **Technology**: AWS DynamoDB
- **Purpose**: DynamoDB for storing channel information, such as channel metadata and participants.

### Unified Search

- **Technology**: AWS OpenSearch
- **Purpose**: Provides a unified search interface across all services, indexing relevant fields from User, Chat, File, and Channel services for quick and effective searching.

## OpenSearch

Here is a quick look at how OpenSearch will be used in this project.

- **Chat Service**: Messages will be indexed to enable real-time search functionality.

- **User Service**: User profiles will be indexed to allow for complex search queries.

- **File Service**: File metadata will be indexed to facilitate quick file retrieval.

- **Channel Service**: Channel metadata and content will be indexed to enable real-time, complex search queries for users to find channels that meet specific criteria.

- **Unified Search Service**: Data from other services will be cross-indexed to provide a unified search experience for users.