for a in $(cat ~/.aws/credentials | grep "\[" | tr -d "[" | tr -d "]")
  do
    for i in $(aws s3api --profile $a list-buckets | grep Name | awk {'print $2'} | tr -d \" | tail -n +2)
      do
        echo "checking $i for AllUsers access..."
        aws s3api --profile $a get-bucket-acl --bucket $i | grep -A 3 "http://acs.amazonaws.com/groups/global/AllUsers" | grep --color=auto Permission
        echo
    done
done
