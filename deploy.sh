#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting deployment process..."

# Switch to master branch
echo "Checking out master branch..."
git checkout master

# Rebuild the site with Hugo
echo "Rebuilding site with Hugo..."
hugo

# Backup public directory
echo "Backing up public directory..."
cp -r public ../_site-temp

# Switch to gh-pages branch
echo "Checking out gh-pages branch..."
git checkout gh-pages

# Clean out old content
echo "Cleaning old content..."
git rm -rf .

# Copy new content
echo "Copying new content..."
cp -r ../_site-temp/* .

# Commit and push changes
echo "Committing and pushing changes..."
git add .
git commit -m "Automated deployment $(date)"
git push origin gh-pages

# Cleanup temporary directory
echo "Cleaning up temporary directory..."
rm -rf ../_site-temp

# Switch back to master branch
echo "Switching back to master branch..."
git checkout master

# Pull latest changes from master branch
echo "Pulling latest changes from master branch..."
git pull origin master

echo "Deployment completed successfully!" 
