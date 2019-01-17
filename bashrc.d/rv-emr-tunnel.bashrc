# vim: set filetype=sh

function tunnel_emr_cluster {
  profile=${1:-nonprod}
  emr_name=${2:-processing-emr-spark-dgoke}
  region=${3:-ap-southeast-2}
  port=${tunnel_ports[$profile]}

  aws_emr="aws emr --profile $profile --region $region"
  #cluster_id=$($aws_emr list-clusters --active | jq -r '.Clusters[].Id')
  cluster_id=$($aws_emr list-clusters --active | jq -r '.Clusters[] | select(.Name | endswith("'${emr_name}'")) | .Id')
  master_url=$($aws_emr describe-cluster --cluster-id $cluster_id | jq -r '.Cluster.MasterPublicDnsName')
  master_ip=$(echo $master_url | sed 's/^ip-//' | sed 's/.'${region}'.*//' | sed 's/-/./g')
  ssh_tunnel="ssh -i ~/.ssh/rvdata-${profile}-key.pem -N -D ${port} hadoop@${master_ip}"

  echo "$cluster_id: $emr_name"
  echo $ssh_tunnel

  echo "YARN-RM  http://${master_url}:8088"
  echo "ZEPPELIN http://${master_url}:8890"
  echo "HISTORY http://${master_url}:18080"
  echo "GANGLIA http://${master_url}/ganglia/"

  $ssh_tunnel
}
