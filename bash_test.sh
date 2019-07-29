killpstree(){
	local children=`ps --ppid $1 --no-heading | awk '{print $1}'`
	for child in $children
	do
		killpstree $child
	done
	sudo kill $1
}

pids=()
sudo tcpdump -i eth1 -w data.pcap &
pids[0]=$!

ping $1 &
pids[1]=$!

sleep $2
killpstree ${pids[0]}
sudo kill ${pids[@]}
