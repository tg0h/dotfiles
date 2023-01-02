#!/usr/local/bin/zsh
#this uses the homebrew version of zsh stored in /usr/local/bin
#for even more portability, use /usr/bin/env zsh

#hack place statment before condition in while loop. lol!
# set -o pipefail - this is an alternative to pipestatus
while
  aws cognito-idp admin-list-user-auth-events --user-pool-id $_CERTIFY_POOL_ID --username $1 2>/dev/null | jq --raw-output ".AuthEvents[0] | [\"$1\",.EventResponse,.EventType,.CreationDate,.EventRisk.RiskDecision,.EventRisk.CompromisedCredentialsDetected,.ChallengeResponses[0].ChallengeName,.ChallengeResponses[0].ChallengeResponse] | @csv"
  # aws cognito-idp admin-list-user-auth-events --user-pool-id $_CERTIFY_POOL_ID --username $1 | jq --raw-output ".AuthEvents[0] | [\"$1\",.EventResponse,.EventType,.CreationDate,.EventRisk.RiskDecision,.EventRisk.CompromisedCredentialsDetected,.ChallengeResponses[0].ChallengeName,.ChallengeResponses[0].ChallengeResponse] | @csv"
  [[ ${pipestatus[1]} -ne 0 ]] #if the 1st stage of the pipe fails, try again
do
  continue
done
