# Create a deploy log
echo "Deployed from branch $BRANCH at $(date)" > deployed.log

# Optional: Restart service, move files, etc.
echo "Deployment complete."
