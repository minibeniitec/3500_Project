all:

pull:
	git pull

push: pull
	git add .
	git commit -m "Auto"
	git push origin master
