pipeline_name=''
do_eww=0

[[ -z $1 ]] && echo "Pipeline name required"
pipeline_name=$1
[[ $2 -eq "--eww" ]] && do_eww=1

get_pipeline_state() {
  aws codepipeline get-pipeline-state --name $1 | jq '.stageStates as $ss 
  | $ss | map (.actionStates[] as $an 
  | {stage: .stageName, substages: [{name: $an.actionName, latestExecution: $an.latestExecution}]}) 
  | map(.stage as $sn 
  | .substages[] as $ss 
  | {name: ($sn+"-"+$ss.name), status: $ss.latestExecution.status, url: $ss.latestExecution.externalExecutionUrl})'
}

pipeline_state=$(get_pipeline_state $pipeline_name)
if [[ do_eww -eq "1" ]]; then
  echo hi
else
  echo $pipeline_state
fi
