include "pad";
include "colour";


def __actionExecutionStatus:
{
  "Succeeded": _g("S"), # green_bg
  "Failed": _bgr("F"),
  "InProgress": _y("P"),
};
def _actionExecutionStatus:
  __actionExecutionStatus[.] // .;

def _sortStages:
[ 
  "Source",
  "Build",
  "UpdatePipeline",
  "Assets",
  "staging",
  "production"
];

# hardcode the run order to display in list pipeline actions
# TODO: get the run order from aws codepipeline get-pipeline instead
def _runOrderDict:
# the run order for [<staging>, <production>] is stored in an array
{ 
  ## Tests
  "Tests": [5, 99],
  ## Deploy
  "DeployToProduction": [99, 1],

  ## AUTH
  "cognito.Prepare": [1, 2],
  "cognito.Deploy": [2, 3],
  "cognito-wonka.Prepare": [1, 2],
  "cognito-wonka.Deploy": [2, 3],

  ## FRONTEND
  "frontend.Prepare": [1, 2],
  "frontend.Deploy": [2, 3],
  "frontend-wonka.Prepare": [1, 2],
  "frontend-wonka.Deploy": [2, 3],
  "storybook.Prepare": [1, 2],
  "storybook.Deploy": [2, 3],

  ## BACKEND
  "api.Prepare": [3, 4],
  "api.Deploy": [4, 5],
  "api-nerfed.Prepare": [3, 4],
  "api-nerfed.Deploy": [4, 5],
  "apiInternal.Prepare": [1, 2],
  "apiInternal.Deploy": [2, 3],

  ## DB
  "dynamoDBStack.Prepare": [1, 2],
  "dynamoDBStack.Deploy": [2, 3],

  ## AWS
  "s3Stack.Prepare": [1, 2],
  "s3Stack.Deploy": [2, 3],
  "sendDkimEmail.Prepare": [1, 2],
  "sendDkimEmail.Deploy": [2, 3],
  "sqsQueueStack.Prepare": [1, 2],
  "sqsQueueStack.Deploy": [2, 3],

  ## DAEMONS?
  "createDailyRate.Prepare": [1, 2],
  "createDailyRate.Deploy": [2, 3],
  "updateReferral.Prepare": [1, 2],
  "updateReferral.Deploy": [2, 3],
  "createDaemonDailyScheduler.Prepare": [3, 4],
  "createDaemonDailyScheduler.Deploy": [4, 5],
  "createDaemonFifteenMinsScheduler.Prepare": [3, 4],
  "createDaemonFifteenMinsScheduler.Deploy": [4, 5],
  "createDaemonTenDayScheduler.Prepare": [3, 4],
  "createDaemonTenDayScheduler.Deploy": [4, 5],
  "updateStat.Prepare": [3, 4],
  "updateStat.Deploy": [4, 5]
};
