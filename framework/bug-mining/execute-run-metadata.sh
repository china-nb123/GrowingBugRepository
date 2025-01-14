#!/bin/bash
WORK_DIR="metadata"
echo "WORK_DIR: $WORK_DIR"
cat metadata.txt | while read line
do
    # read project information
    read -ra strarr <<<"$line"
    project_id=${strarr[0]} 
    project_name=${strarr[1]}
    repository_url=${strarr[2]}
    issue_tracker_name=${strarr[3]}
    issue_tracker_project_id=${strarr[4]}
    bug_fix_regex=${strarr[5]}
    sub_project=${strarr[6]:-"."}
    echo "Getting the project information ..."
    echo "PROJECT_ID: $project_id"
    echo "PROJECT_NAME: $project_name"
    echo "REPOSITORY_URL: $repository_url"
    echo "ISSUE_TRACKER_NAME: $issue_tracker_name"
    echo "ISSUE_TRACKER_PROJECT_ID: $issue_tracker_project_id"
    echo "BUG_FIX_REGEX: $bug_fix_regex"
    echo "SUB_PROJECT: $sub_project"
    # make bug-mining directory
    cd `dirname $0`
    path=$PWD
    work_dir="$WORK_DIR/$project_id"
    echo "WORK_DIR: $work_dir"
    
   nums=$(wc -l < $work_dir/framework/projects/$project_id/active-bugs.csv)
   nums=`expr $nums - 1`
   arr=(7 28);
   #arr=(1019);
   for i in ${arr[@]}
   #for((i=24;i<=$nums;i++));  
do    
   #perl ./initialize-revisions.pl -p $project_id -w $work_dir -s $sub_project -b $i -n $project_name
    # Determine triggering tests of the project
   # perl ./analyze-project.pl -p $project_id -w $work_dir \
   #                          -g $issue_tracker_name \
   #                          -t $issue_tracker_project_id \
   #            -s $sub_project -b $i
   # Determine triggering tests of the project
   #perl ./get-trigger.pl -p $project_id -w $work_dir -s $sub_project -b $i
   # perl ./get-metadata.pl -p $project_id -w $work_dir -b $i -s $sub_project
   perl ./promote-to-db.pl -p $project_id -w $work_dir -r $WORK_DIR/project_repos/$project_name.git -b $i
   
done   
   # trigger_dir="$work_dir/framework/projects/$project_id/trigger_tests";
   # if  [ "`ls -A $trigger_dir`" = "" ]
   # then
   #    rm -rf $work_dir
   # fi
done
# ./promote-to-db.pl -p $project_id -w $work_dir -r $WORK_DIR/project_repos/$project_name.git -b $i
