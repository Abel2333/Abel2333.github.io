# This is my personal website for some notes

## Build step:
1. First, build an docker image from `Dockerfile` by:
```Bash
docker build -t jekyll-debian-stable .
```
2. Then, create a container base on the image (use the **Absolute Path** of project):
```Bash
docker run -dit --name jekyll-site -v /the/path/of/app/:/home -p 4000:4000 jekyll-debian-stable /bin/bash
```
3. Now, you can enter the container and run script to initial Jekyll:
```Bash
docker exec -it jekyll-site /bin/bash
# In container
cd /home
chmod +x Initial-Jekyll
./Initial-Jekyll.sh
```

