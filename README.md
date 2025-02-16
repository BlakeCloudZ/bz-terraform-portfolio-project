# Portfolio Website Deployment - AWS w/ Terraform

## Overview

Jonathan Smith (Client) created a Next.js portfolio website to showcase his work. He needs a reliable hosting platform for it. The code in this repository handles deployment of Jonathan Smith's Next.js portfolio website to AWS. The infrastructure is fully automated using Terraform, which manages and provisions all the necessary AWS services.

### Project Requirements

- **Highly Available:** Globally accessible with minimal downtime
- **Scalable:** Handles increasing traffic smoothly
- **Cost-Effective:** Optimizes hosting expenses
- **Fast Loading:** Delivers quick response times worldwide

### Solution Architecture
![Image](https://github.com/user-attachments/assets/d0539069-6c8e-405f-bafe-a5f4a4d4ea70)

- **Frontend:**
    - Next.js portfolio website
- **Infrastructure:**
    - Terraform for IaC deployment
    - AWS S3 for static hosting
    - AWS CloudFront for content delivery
- **Tools:**
    - AWS CLI for cloud management
    - Git for version control
    - GitHub for repository hosting

---

## Quick Overview of Next.js

Next.js is a React-based framework for building web applications, developed by Vercel. It provides built-in features for performance and SEO optimization.

### Key Features:

- **Server-Side Rendering:** Generates pages on the server for faster initial load
- **Static Site Generation:** Creates pre-built pages for optimal performance
- **API Routes:** Handles backend functionality without a separate server
- **File-based Routing:** Creates URLs based on your file structure
- **Code Splitting:** Loads only necessary code for each page
- **CSS Support:** Includes built-in styling options

### Common Use Cases:

- **Static Websites:** Perfect for portfolios and landing pages
- **E-commerce:** Fast-loading product pages with SEO benefits
- **Corporate Sites:** Scalable websites for high traffic
- **Web Apps:** Dynamic applications with built-in backend support
- **Content Sites:** Blog and content platforms with easy maintenance

For more information, see: https://nextjs.org/docs

---

## Step-by-Step Instructions to Deploy the Portfolio

### 1. Prepare the Next.js Application

#### 1.1 Create a GitHub Repository
1. Go to GitHub and create a new repository similarly named terraform-portfolio-project
2. Clone the repository
    ```bash
    git clone https://github.com/<your-username>/terraform-portfolio-project.git
    cd terraform-portfolio-project
    ```
#### 1.2 Clone the Next.js Starter Kit:
1. Clone the Portfolio Start Kit:
    ```bash
    npx create-next-app@latest nextjs-blog --use-npm --example "https://github.com/vercel/next-learn/tree/main/basics/learn-starter"
    ```
2. Navigate to the Project Directory:
    ```bash
    cd blog
    npm run dev
    ```

#### 1.3 Update Next.js Configuration
1. Create a file named `next.config.js` in the root folder and add the following:
    ```javascript
    const nextConfig = {
      output: 'export',
    };

    module.exports = nextConfig;
    ```
2. Build the static site:
    ```bash
    npm run build
    ```
   This will generate an `out` folder.
![Image](https://github.com/user-attachments/assets/ba3aeb49-e929-4a62-898c-77b61336253f)

#### 1.4 Push Code to GitHub
1. Initialize Git and push the project:
    ```bash
    git init
    git add .
    git commit -m "Initial commit of Next.js portfolio starter kit"
    git remote add origin https://github.com/<your-username>/terraform-portfolio-project.git
    git push -u origin master
    ```
---

### 2. Set Up Terraform Configuration

#### 2.1 Create Terraform Directory
```bash
mkdir terraform-nextjs
cd terraform-nextjs
```
#### 2.2 Create Terraform Files

1. **State Management**: Configure S3 backend for state storage, DynamoDB for state locking
2. **Provider Block**: Configure AWS provider with region settings in `main.tf`
3. **S3 Bucket**: Set up website hosting bucket with index/error documents and tags
4. **Bucket Policy**: Configure public read access to S3 bucket contents
5. **CloudFront**: Create distribution with S3 origin, HTTPS redirection, and basic caching
 - origin should be poitn the S3 bucket
    - domain_name = s3 bucket
    - origin_id = s3-website
 - default_cache_behavior
    - allowed_methods = ["GET", "HEAD"] cached_methods = ["GET", "HEAD"] target_origin_id = "S3-Website"
 - viewer_protocol_policy = 'redirect-to-https`
 - geo
6. **Outputs**: Define bucket website endpoint and CloudFront domain name outputs

#### 2.3 Initialize Terraform
```hcl
terraform init
```

#### 2.4 Plan and Apply Terraform

1. Preview the changes:
```hcl
terraform plan
```

2. Apply the changes:
```hcl
terraform apply
```

---

## 3. Deploy the Next.js Static Site

1. Upload the `out` folder to the S3 bucket:
    ```bash
    aws s3 sync s3://path/to/blog/out s3://<s3-bucket-you-name>
    ```
2. Get the CloudFront URL with Terraform:
    ```hcl
    terraform output cloudfront_url
    ```
3. Access the website using the CloudFront URL generated from `terraform output`

---

## Project Outcome

1. **Website Deployment**: Successfully deployed Next.js portfolio site on AWS
2. **Infrastructure as Code**: Used Terraform to automate AWS resource creation
3. **Content Delivery**: Set up CloudFront for global content delivery with low latency
4. **Security & Performance**: Implemented best practices for a fast, secure website
5. **Source Control**: Created GitHub repository to host project files and code