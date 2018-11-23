# TMBmodel5GhzWIFI
MATLAB function able to provide a vector of MCS probabilities in function of the AP-STA distance, the BW and the PTx. 
Together with comprehensive experimentation data sets.

Data set format (wireshark filters):
frame.time_epoch | wlan_radio.duration | wlan_radio.preamble | wlan.duration | wlan_radio.11ac.short_gi | wlan_radio.11ac.nss | wlan_radio.11ac.stbc | wlan_radio.11ac.nsts | wlan_radio.signal_dbm | wlan_radio.a_mpdu_aggregate_id | wlan_radio.11ac.mcs | wlan_radio.11ac.bandwidth | frame.len | udp.length | wlan_radio.data_rate

Function usage:

MCSCalculator(D) returns the RSSI achieved with a distance D between the
Access Point (AP) and the Station (STA) when the AP uses 20 MHz of channel
bandwidth and 23 dBm of transmission power.

[rssi, mcs, ss, mcs_prob] = MCSCalculator(D) returns the RSSI achieved in
rssi, the most likely MCS and number of spatial streams in mcs and ss, and
the MCS probabilities in mcs_prob as a 2 by 10 matrix where the first row
represents MCS 0-9 with one spatial stream, and the second row represents
two spatial streams.

[rssi, mcs, ss, mcs_prob] = MCSCalculator(D, BW, PW) uses the distance D,
the channel bandwidth BW and the transmission power PW used by the AP 
to get the RSSI and MCS probailities.
