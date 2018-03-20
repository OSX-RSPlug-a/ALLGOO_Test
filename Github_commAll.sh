# do it first
#  git config --global user.name "YOUR NAME"
# git config --global user.email "YOUR EMAIL ADDRESS"

# config && create a remote git repository from local directory

# Replace SSH_USERNAME, SSH_HOST, SSH_GIT_PATH with your details


USER=OSX-RSPlug-a

HOST=https://github.com/OSX-RSPlug-a/AllGoo_test.git

GIT_PATH=OSX-RSPlug-a/AllGoo_test

REPO=${PWD##*/}
GIT_REMOTE_URL=https://github.com/OSX-RSPlug-a/AllGoo_test.git

echo "-------------------------------------------"
echo "------ Building new Git repository --------"
echo "-------------------------------------------"

echo "--"
echo "-- Creating remote repo at:"
echo "-- $USER@$HOST/$GIT_PATH/$REPO"
echo "--"

ssh $USER@$HOST 'mkdir '$GIT_PATH'/'$REPO' && cd '$GIT_PATH'/'$REPO' && git --bare init && git --bare update-server-info && cp hooks/post-update.sample hooks/post-update && chmod a+x hooks/post-update && touch git-daemon-export-ok'

echo "-------------------------------------------"

echo "--"
echo "-- Initializing local repo and pushing to remote"
echo "--"

touch .gitignore
git init
git add .
git commit -m 'initial commit'
git push --all $GIT_REMOTE_URL
git remote add origin $GIT_REMOTE_URL
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
git fetch
git merge master
git branch -a

echo "--"
echo "-- Your new git repo '$REPO' is ready and initialized at:"
echo "-- $USER@$HOST/$GIT_PATH/$REPO"
echo "--"
