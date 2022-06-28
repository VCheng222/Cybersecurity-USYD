## Week 16 Homework Submission File: Penetration Testing 1

#### Step 1: Google Dorking


- Using Google, can you identify who the Chief Executive Officer of Altoro Mutual is:

Using the Google Dorking technique I was able to identify who the Chief Executive Officer of Altoro Mutual in reference to the web site `demo.testfire.net`. By inputting the following command, _site:demo.testfire.net intext:chief_ into the Google search bar. This showed that Karl Fitsgerald is the Chairman & Chief Executive Officer of Altoro Mutual.

![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Google%20Dorking.png)

This was further confirmed by clicking on the first link from search results <http://demo.testfire.net/index.jsp?content=inside_executives.htm>. This site was able to not only display who the Chief Executive Officer is but also others who play an important role within the organization.


- How can this information be helpful to an attacker:

The information is helpful to an attacker as it is step 1 of offensive security, planning and reconnaissance. Information can allow attackers to focus on a target and in this incidence with one of the highest security authorities within the organization for exploitation purposes. Attackers can then begin to send phishing emails to executive members of Altoro Mutual.

#### Step 2: DNS and Domain Discovery

Enter the IP address for `demo.testfire.net` into Domain Dossier and answer the following questions based on the results:

  1. Where is the company located: 

The company is located at *Sunnyvale, CA, 94085, US*.

![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Company%20Location.png)

  2. What is the NetRange IP address:

The NetRange is 65.61.137.64 - 65.61.137.127

![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/NetRange.png)

  3. What is the company they use to store their infrastructure:

The company that stores their infrastructure is Rackspace Backbone Engineering.

![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Rackspace%20Backbone%20Engineering.png)

  4. What is the IP address of the DNS server:

65.61.137.117

![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/DNS.png)

#### Step 3: Shodan

- What open ports and running services did Shodan find:

By scanning the IP address 65.61.137.117 against Shodan it was evident that Ports 80 and 443 are open.

![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Shodan.png)

#### Step 4: Recon-ng

- Install the Recon module `xssed`. 

To install the module `xssed` into my Recon-ng the following command was used:
```
marketplace install xssed
```
![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/xssed.png)

- Set the source to `demo.testfire.net`. 

After the installation of `xssed` was complete it was then loaded using the following command:
```
modules load recon/domains-vulnerabilities/xssed
```
After doing so, am I able to set the source to `demo.testfire.net`. This is done so using the following command:
```
options set SOURCE demo.testfire.net
```
![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Recon-ng_module_load.png)

- Run the module. 

To run the module a simple command is needed:
```
run
```

![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Recon-ng_run.png)

Is Altoro Mutual vulnerable to XSS: 

To double check that the website `demo.testfire.net` is vulnerable to XSS the following command was entered into the search bar.

```
<script>("Vulnerable")</script>
```
![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/XSS.png)

The image shows that website is indeed vulnerable as I was able to successfully able to run a script in the search bar.

### Step 5: Zenmap

Your client has asked that you help identify any vulnerabilities with their file-sharing server. Using the Metasploitable machine to act as your client's server, complete the following:

- Command for Zenmap to run a service scan against the Metasploitable machine: 
 
```
nmap -T4 -F 192.168.0.10
```
![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Zenmap_1.png)

- Bonus command to output results into a new text file named `zenmapscan.txt`:
```
nmap -T4 -F -oN zenmapscan.txt 192.168.0.10
```
![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Zenmap_2.png)
![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/zenmapscan.txt.png)
- Zenmap vulnerability script command: 

From the previous command it is shown that `Ports 139` and `445` were open. The following command was used in Zenmap to determine the vulnerability associated with `Ports 139` and `445`.

```
nmap -T4 -F --script ftp-vsftpd-backdoor,smb-enum-services 192.168.0.10
```
![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Zenmap_3.png)
![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Zenmap_4.png)
![](https://github.com/VCheng222/Cybersecurity-USYD/blob/main/Week%2016%20-%20Penetration%20Testing%201/Images/Zenmap_5.png)
- Once you have identified this vulnerability, answer the following questions for your client:
  1. What is the vulnerability:

`Ports 139` and `445` are used for Server Message Block (SMB) over "NetBIOS", it is the communication network used in Windows operating system. `Port 139` is used by Windows 2000 hosts, whereas `Port 445` is used by newer versions of Windows OS after 2000. With the utilization of Zenmap it is determined that smb-enum-services was vulnerable.

  2. Why is it dangerous:

SMB Shares Enumeration is dangerous as attackers can access files and folders remotely. Depending on what files are communicated between systems it can be fatal to organizations who fall for this attack.

  3. What mitigation strategies can you recommendations for the client to protect their server:

Recommendations for client to protect their server include:
- Restrict access to thoes shares by password
- Filter the NetBIOS port from outside access
- Use vulnerability management tools such as AVDS to discover vulnerabilities in the server on a frequent basis

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

