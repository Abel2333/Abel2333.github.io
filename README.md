# This is my personal website for some notes

Use Jekyll Theme minimal mistake

## Build Step

**Do this only when you want a empty site!!!**

1. First, build an docker image from `Dockerfile` by:

    ```Bash
    docker build -t jekyll-debian-stable .
    ```

2. Then, create a container base on the image (use the **Absolute Path** of project):

    ```Bash
    # `4000:4000' means mapping port 4000 in the host with 4000 in the container
    docker run -dit --name jekyll-site \
    -v /the/path/of/app/:/home -p 4000:4000 jekyll-debian-stable /bin/bash
    ```

3. Now, you can enter the container and run script to initial Jekyll:

    ```Bash
    docker exec -it jekyll-site /bin/bash
    # In container
    cd /home
    chmod +x Initial-Jekyll
    ./Initial-Jekyll.sh
    ```

**Done!** You get an empty Jekyll Site in GitHub Pages.

## Restore Step

If you want to restore the site in local, follow with these steps:

1. First, build an docker image from `Dockerfile` by:

    ```Bash
    docker build -t jekyll-debian-stable .

2. Then, create a container base on the image (use the **Absolute Path** of project):

    ```Bash
    docker run -dit --name jekyll-site \
    -v /the/path/of/app/:/home -p 4000:4000 jekyll-debian-stable /bin/bash
    ```

    (These steps are same with the previous)
3. Enter the container to ***install & update the bundle***:

    ```Bash
    # Enter the container
    docker exec -it jekyll-site /bin/bash
    # Install & Update
    bundle install
    bundle update
    ```

**Done!** You can continue your previous work.
