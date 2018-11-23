# TMBmodel5GhzWIFI
MATLAB function able to provide a vector of MCS probabilities in function of the AP-STA distance, the BW and the PTx. 
Together with comprehensive experimentation data sets.

Data set format (wireshark filters):
frame.time_epoch | wlan_radio.duration | wlan_radio.preamble | wlan.duration | wlan_radio.11ac.short_gi | wlan_radio.11ac.nss | wlan_radio.11ac.stbc | wlan_radio.11ac.nsts | wlan_radio.signal_dbm | wlan_radio.a_mpdu_aggregate_id | wlan_radio.11ac.mcs | wlan_radio.11ac.bandwidth | frame.len | udp.length | wlan_radio.data_rate
