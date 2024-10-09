#-T: Specifies the use of the text-based interface
#-M arp: Initiates a MITM ARP poisoning attack to intercept packets between hosts
#// //: Specifies the entire network as the targets
ettercap -T -i eth0 -M arp ///
