#!/bin/zsh

[[ -z $1 ]] && echo "Sleep time required" && exit 1

pipe=/tmp/awspipe_server
pipe_send=/tmp/awspipe_client
pipeline_state_file=/tmp/aws_pipeline_state
pipeline_status=''
pipelines=''
current_pipeline=1
sleep_time=$1
stage=''
output=''
prev_output=''
pipeline_state=''

trap "rm -f $pipe $pipeline_state_file" SIGINT EXIT

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
fi

if [[ ! -p $pipe_send ]]; then
    mkfifo $pipe_send
fi

list_pipelines() {
  aws codepipeline list-pipelines | jq '.pipelines[].name' | tr -d '"'
}

pipeline_execution() {
  aws codepipeline list-pipeline-executions --pipeline-name $pipelines[$current_pipeline] \
  | jq '.pipelineExecutionSummaries[0].status' \
  | tr -d '"'
}

get_pipeline_state() {
  aws codepipeline get-pipeline-state --name AetherClientPipeline | jq '.stageStates as $ss | $ss | map (.actionStates[] as $an  | {stage: .stageName, substages: [{name: $an.actionName, latestExecution: $an.latestExecution}]}) | map(.stage as $sn | .substages[] as $ss | {name: ($sn+"-"+$ss.name), status: $ss.latestExecution.status, url: $ss.latestExecution.externalExecutionUrl})'
}

get_status() {
  pipeline_status=$(pipeline_execution)
  # This is so fucking ugly
  get_pipeline_state >$pipeline_state_file
}

incr() {
  current_pipeline=$current_pipeline+1
  if [[ $current_pipeline -gt ${#pipelines} ]] && current_pipeline=1
}

gen_eww_list() {
  cat $pipeline_state_file | jq -c >/tmp/aws_eww
}

print_status() {
  echo "${pipelines[$current_pipeline]} - ${pipeline_status}"
}

pipelines=($(list_pipelines))

sleep_pid=''
(
  while true
  do
    get_status
    print_status
    sleep $sleep_time &
    sleep_pid=$!
    wait $sleep_pid
  done
)&
bg_pid=$!
trap "kill $bg_pid; exit" SIGINT EXIT

while true
do
  read cmd <$pipe
  [[ ! -z "$sleep_pid" ]] && kill $sleep_pid
  if [[ ! -z $cmd ]]; then
    case $cmd in
      next)
        incr        
        get_status
        print_status
        ;;
      refresh)
        pipelines=($(list_pipelines))
        get_status
        print_status
        ;;
      toggle)
        ;;
      eww)
        gen_eww_list
        ;;
    esac
  fi
done

