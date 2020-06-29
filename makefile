# Use to generate basic usage of modules
gen-module-docs: 
	for d in ./modules/**; do terraform-docs markdown $${d} > $${d}/module-docs.md; done

# Use to remove generated file
rm-module-docs: 
	for d in ./modules/**; do rm $${d}/module-docs.md; done
