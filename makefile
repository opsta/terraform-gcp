# Use to generate all modules document
all: 
	echo "# Firewall rule module\n\nModule for create firewall rule on Google Cloud\n" > ./modules/router/README.md;terraform-docs markdown ./modules/router >> ./modules/router/README.md
	echo "# GKE module\n\nModule for provision GKE on Google Cloud\n" > ./modules/router/README.md;terraform-docs markdown ./modules/router >> ./modules/router/README.md
	echo "# Cloud Memory Store module (Only Redis for now)\n\nModule for provision Cloud MemoryStore on Google Cloud\n" > ./modules/router/README.md;terraform-docs markdown ./modules/router >> ./modules/router/README.md
	echo "# Cloud NAT module\n\nModule for create Cloud Nat on Google Cloud\n" > ./modules/router/README.md;terraform-docs markdown ./modules/router >> ./modules/router/README.md
	echo "# Cloud Router module\n\nModule for create Cloud Router on Google Cloud\n" > ./modules/router/README.md;terraform-docs markdown ./modules/router >> ./modules/router/README.md
	echo "# Cloud SQL module\n\nModule for provision Cloud SQL on Google Cloud\n" > ./modules/sql/README.md;terraform-docs markdown ./modules/sql >> ./modules/sql/README.md
	echo "# Network VPC module\n\nModule for provision VPC and subnet on Google Cloud\n" > ./modules/vpc/README.md;terraform-docs markdown ./modules/vpc >> ./modules/vpc/README.md

# echo "# VPC module\n\nModule for provision VPC and subnet on Google Cloud\n" > ./modules/$$(TF_MODULE_NAME)/README.md;terraform-docs markdown ./modules/$$(TF_MODULE_NAME) >> ./modules/$$(TF_MODULE_NAME)/README.md
# for d in ./modules/**; do terraform-docs markdown $${d} > $${d}/module-docs.md; done
# for d in ./modules/**; do rm $${d}/module-docs.md; done
