#!/bin/bash
# Purpose: It updates the current GitHub repository with the last changes. 
# Author: Kaizten Analytics S.L. (info@kaizten.com)
# License: GPL version 2.0 or above
# -------------------------------------------------------------------------------------------------

main () {
  git add .
  set +e
  if [ -n "$(git status --porcelain)" ]; then
    read -p "# Enter your message in the commit: " message
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
