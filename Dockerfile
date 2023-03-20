FROM alpine:3.13

# Declare build-time variables
ARG CHECKOV_VERSION=2.3.102
ARG TERRAFORM_VERSION=1.4.2
ARG TERRAFORM_DOCS_VERSION=0.16.0

# Install dependencies
RUN apk add --update curl unzip

# Install Terraform
RUN curl -LOs https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  mv terraform /usr/local/bin/ && \
  rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Terraform Docs
RUN curl -LOs https://github.com/segmentio/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64 && \
  mv terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64 /usr/local/bin/terraform-docs && \
  chmod +x /usr/local/bin/terraform-docs

# Install Checkov
RUN curl -LOs https://github.com/bridgecrewio/checkov/releases/download/${CHECKOV_VERSION}/checkov-linux && \
  mv checkov-linux /usr/local/bin/checkov && \
  chmod +x /usr/local/bin/checkov

# Remove unnecessary packages and clean up
RUN apk del curl unzip && \
  rm -rf /var/cache/apk/*
