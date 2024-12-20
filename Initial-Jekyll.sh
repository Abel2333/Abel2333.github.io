#!/bin/bash

# Display the Ruby Version
echo -e "Ruby Version."
ruby -v

# Display the Jekyll Version
echo -e "\nJekyll Version."
jekyll -v

# Generate Gemfile
echo -e "\nInitial Bundle"
bundle init

# Create new Site
echo -e "\nCreate a new Jekyll site with the default theme."
jekyll new . --skip-bundle --force
# bundle exec jekyll new . --skip-bundle --force --blank

# Jekyll generates  a default `.gitignore` file, but not enough
# Thus, create a new one to replace it.
echo -e "Deleting default .gitignore file Jekyll generated."
GITIGNORE=.gitignore
if test -f "${GITIGNORE}"; then
    rm ${GITIGNORE}
fi

echo "Create a new .gitignore file."
echo "Populating the .gitignore file."
echo "_site" >> ${GITIGNORE}
echo ".sass-cache" >> ${GITIGNORE}
echo ".jekyll-cache" >> ${GITIGNORE}
echo ".jekyll-metadata" >> ${GITIGNORE}
echo "Gemfile.lock" >> ${GITIGNORE}
echo ".bundle" >> ${GITIGNORE}
echo "**/.DS_Store" >> ${GITIGNORE}

# Configure bundle to support GitHub Pages
echo -e "\nAdd GitHub Pages to the bundle"
bundle add "github-pages" --group "jekyll_plugins" --version 232

# webrick is a technology that has been removed by Ruby, but needed for Jekyll
echo "Add required webrick dependency to the bundle"
bundle add webrick

# Install and update the bundle
echo "bundle install"
bundle install
echo "bundle update"
bundle update

# Finish the initialization
echo -e "\033[1;32mDone configuring your Jekyll site! Here are the next steps:\033[00m"
echo -e "1. Modify the baseurl and url in \`_config.yml' file."
echo -e "2. Run \033[1mbundle exec jekyll serve --livereload --host 0.0.0.0\033[0m to test Jekyll."
echo -e "3. Commit and pull & push changes."

