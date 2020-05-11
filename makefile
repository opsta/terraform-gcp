# Use to generate basic usage of modules
docs: 
	for d in ./modules/**; do terraform-docs markdown $${d} > $${d}/module-docs.md; done
