#!/bin/bash
#plot_dir: dizindeki klasörü karşı sunucu ile sync eder transfer tamamlanınca dosyayı siler.
# sadece bir makine güncel..!!
#storage_ip=""
#storage_dir="/root/progress/"

# [INPUT]
# Gcloud path 
gpath=gs://rrbot_a1
json_file=""  # url or path
plot_dir="/mnt/disk1"
# crontap run time (min)
cnum=10 #10dk

# connect progress host
pr_on=0
prog_host=""
pass=""
user="root" 
prog_path="/root/progress/"
$prog_path1=$prog_path

# [START]
# Log files
plot_file="/root/plot.log"
up_file="/root/upload.log"

# gsutil
gsutil=gsutil 

prcopy(){
  if [ $pr_on -gt 0]; then
    exit
  fi
	if ! [ -d "progress" ]; then
		mkdir progress
	fi
	cp $plot_file $prog_path$ip.plot" 
	cp $up_file $prog_path$ip.upload"
	ip=$(curl -4 ifconfig.co) &&
	ipdata=$(echo $(date) " - " $(du -h -s $temp_dir)) &&  
	echo $ipdata > $prog_path$ip.log"
	sudo sshpass -p $pass scp -o StrictHostKeyChecking=no $prog_path1* $user@$prog_host:$prog_path && $(date) 2> lastcopy 
	# $gsutil -m cp "/root/progress/*" "$gpath/progress/" 2> /root/lastcopy
	echo "ok" 
}
gcopy(){ 
	# rsync --remove-source-files -a --exclude "*.log" --progress $plot_dir -e $gpath
    nohup $gsutil -o GSUtil:parallel_composite_upload_threshold=150M -m cp $plot_dir/*.plot $gpath >>upload.log && rm $plot_dir/*.plot &    
}
g_install (){
	# install 
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && 
	sudo apt-get install apt-transport-https ca-certificates gnupg -y &&
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - &&
	sudo apt-get update && sudo apt-get install google-cloud-sdk -y &&
  if ! [ -f  $json_file ]; then
    wget  $json_file -O google-authencation.json
  fi
	gcloud auth activate-service-account --key-file google-authencation.json
	echo "Google ok."
} 
if [ $(crontab -l | grep -c copy.sh) -eq 0 ]; then
	sudo apt install sshpass &&  
	sudo apt install rsync &&   
	sudo apt-get install cron &&
	echo "Görev ekleniyor..\n" && 
	sudo crontab -l | { cat; echo "*/$cnum * * * * sh /root/gsauto.sh"; } | crontab - && 
	# echo "**Not: parolayı girdikten sonra bağlantınızı doğrulayın ve CTRL-C ile çıkış yapın."
	echo "Gcloud yükleniyor..\n" 
	g_install
	#echo "ssh $user@$storage_ip bir hata oluştuğunda çalıştırın.."
	#ssh -T $user@$storage_ip 
#elif ! [ -x "$(command -v rsync)" ]; then
#	sudo sudo apt-get install rsync -y 
else
	if [ $(find $plot_dir -name '*.tmp' | wc -l) -gt 0 ]; then
		echo "Plot bitmedi."
	else
		#find $plot_dir -name '*.plot' | while read fname; do
		if [ $(find $plot_dir -name '*.plot' | wc -l) -gt 0 ]; then
			echo "dosya bulundu...\n"
			#if ! [ -x "$(command -v sshpass)" ]; then
			#	sudo sudo apt-get install sshpass -y
			#fi
			#if ! [ $(find $plot_dir -name '*.log' | wc -l) -gt 0 ]; then
			if ! [ $(find $plot_dir -name 'lock.plot' | wc -l) -gt 0 ]; then
				echo "Dosyalar karşı sunucuya kopyalanıyor.\n" &&
				echo "kilit" > "$plot_dir/lock.plot" &&
				gcopy
				#silme işlemi
				#find $plot_dir -name '*.plot' | while read fname; do
				#	if [ $(grep -in $(basename $fname) "upload.log" | wc -l) -gt 0 ]; then
				#		names=$(echo "$fname" | cut -f 1 -d '.')
				#		#rm "$names.plot" &&
				#		echo "dosya silindi\n"
				#	fi
				#done;
			fi
		fi
		#done;
	fi
	prcopy
	#nohup $gsutil -m -r cp "/root/progress/*" "$gpath/progress/" &
fi
 
