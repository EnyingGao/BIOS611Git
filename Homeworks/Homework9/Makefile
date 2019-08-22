construct_folder_structure:
	mkdir ~/Homework9/output
	mkdir ~/Homework9/py36

build_pull_docker_image:
	docker build -t py36 ./py36
	docker pull frolvlad/alpine-python-machinelearning

run_three_python_scripts: hw9_1.py hw9_2.py hw9_3.py
	docker run -d --rm -v $(shell pwd):$(shell pwd) -w $(shell pwd) py36 sh -c "python hw9_1.py 2 3 7 4 6 > ./output/hw9_1.txt"
	docker run -d --rm -v $(shell pwd):$(shell pwd) -w $(shell pwd) py36 sh -c "python hw9_2.py 5 2 17 > ./output/hw9_2.txt"
	docker run -d --rm -v $(shell pwd):$(shell pwd) -w $(shell pwd) py36 sh -c "python hw9_3.py > ./output/hw9_3.txt"

run_other_two_python_scripts:
	docker run -d --rm -v $(shell pwd):$(shell pwd) -w $(shell pwd) frolvlad/alpine-python-machinelearning sh -c "python hw9_4.py 0 1 2 > ./output/hw9_4.txt"
	docker run -d --rm -v $(shell pwd):$(shell pwd) -w $(shell pwd) frolvlad/alpine-python-machinelearning sh -c "python hw9_5.py 3 5 > ./output/hw9_5.txt"

print_list_of_output_files:
	ls ./output