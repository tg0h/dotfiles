function ggb() {
  # get gitlab branches for repo
  # https://docs.gitlab.com/ee/api/
  #
  # TODO: use headers to paginate request

  https $GITLAB_URL/projects/$GITLAB_PROJECT_ID/repository/branches \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN \
    all==true \
    pagination==keyset \
  }

function ggbp() {
  # get gitlab branches for repo
  # https://docs.gitlab.com/ee/api/
  #
  # TODO: use headers to paginate request

  https $GITLAB_URL/projects/$GITLAB_PROJECT_ID/protected_branches \
    PRIVATE-TOKEN:$GITLAB_PRIVATE_TOKEN \
    all==true \
    pagination==keyset \
  }



