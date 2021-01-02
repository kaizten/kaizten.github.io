#!/bin/bash
# Purpose: 
# Author: Kaizten Analytics S.L. (info@kaizten.com)
# License: GPL version 2.0 or above
# -------------------------------------------------------------------------------------------------

main () {
  read -p "# Enter your message in the commit: " message
  git add .
  set +e
  git status | grep modified
  if [ $? -eq 0 ]
  then
    set -e
    git commit -m "${message}"
    echo "# Pushing data to remote GitHub repository:"
    git push
  echo "# Done!"
  else
    set -e
    echo "# Nothing to update"
  fi
}

main "$@"; exit
