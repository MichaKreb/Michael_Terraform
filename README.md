
The root configuration (`main.tf`, `terraform.tf`, `variables.tf`, `terraform.tfvars`) calls these modules and builds the complete infrastructure.

---

#  Module Explanations

## **1. Network Module**
Creates the entire networking layer:

- VPC  
- Public and private subnets  
- Route tables  
- Internet Gateway  
- Security groups for EC2 and RDS  
- Route table associations  

**Reasoning:**  
Separating the network layer improves clarity, security, and extensibility for future subnets or multi-AZ setups.

---

## **2. Compute Module (EC2 Instance)**

This module provisions:

- An EC2 instance for the application  
- User-data containing the DB connection configuration  
- An IAM role + IAM policy for S3 access  

**Reasoning:**  
EC2 is placed inside the **public subnet** to allow SSH access.  
The database remains isolated in a private subnet.

---

## **3. Database Module (RDS PostgreSQL)**

Creates:

- DB subnet group  
- PostgreSQL RDS instance  
- A DB security group that only allows traffic from the EC2 SG  
- `publicly_accessible = false` for security  

**Reasoning:**  
The database should never be reachable from the internet — only from the application server.

---

## **4. Storage Module (S3 Bucket)**

Creates:

- A secure S3 bucket  
- IAM permission setup for EC2 access  

**Reasoning:**  
The bucket is private and used to store application-related objects.

---

#  Key Design Decisions & Best Practices

### ** 1. Network isolation**
- Public subnet for EC2  
- Private subnet for RDS  
- Separate route tables for clarity  

### ** 2. Security First**
- Minimal security group exposure  
- Private database  
- IAM least-privilege configuration  

### ** 3. Modular structure**
Improves:

- Code quality  
- Reusability  
- Scalability  
- Team collaboration  

### ** 4. Variables and Outputs**
All important values are customizable, and modules return outputs for chaining resources.

### ** 5. State Security**
`.terraform/` and `*.tfstate` are excluded via `.gitignore` so that no sensitive data ends up in git.

---

#  Deployment Instructions

## Initialize
```sh
terraform init
terraform validate
terraform fmt


#Terraform Module Structure
.
├── README.md
├── main.tf
├── modules
│   ├── compute
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── database
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── network
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── terraform.tf
├── terraform.tfvars
└── variables.tf

5 directories, 14 files
```
#Diagram
![Terraform Project Architecture](terraform_project.png)
