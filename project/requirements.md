 # Business Continuity Requirements
 ## HA Requirements
 The business has determined the following as the minimum number of nodes for an HA/DR scenario:
- Each VM has 3 instances (EC2)
- Each Kubernetes cluster has 2 nodes (EKS)
- The VPC has IPs in multiple availability zones (VPC)
- An application load balancer in each region (ALB)

## SQL Requirements
In regards to their SQL cluster, the following requirements should be met:
- Create 2 instance nodes for each cluster (primary and secondary clusters)
- Set the backup retention window to 5 days
- Each cluster must have multiple availability zones
- zone1 will replicate to a cluster in zone2