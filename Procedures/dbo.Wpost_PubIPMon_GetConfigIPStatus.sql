SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Wpost_PubIPMon_GetConfigIPStatus]
@InXML VARCHAR(MAX),
@OutStatus INT OUTPUT
AS

/*
===================EXEC================
DECLARE @OutStatus INT  
EXEC [Wpost_PubIPMon_GetConfigIPStatus] 
'<wpfirewallipstatus>
  <regid id = "50033421">
    <ip>
      <ipaddrs><![CDATA[10.10.10.84]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 8 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033417">
    <ip>
      <ipaddrs><![CDATA[10.10.10.80]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 7 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033425">
    <ip>
      <ipaddrs><![CDATA[10.10.10.88]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033311">
    <ip>
      <ipaddrs><![CDATA[1.2.2.2]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 6 ms 125.22.49.113, 3 56 ms 125.23.162.49, 4 265 ms 59.144.36.122, 5 * Request timed out., 6 * Request timed out., 7 * Request timed out., 8 * Request timed out., 9 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033306">
    <ip>
      <ipaddrs><![CDATA[2.2.2.1]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 6 ms 125.22.49.113, 3 56 ms 125.23.162.49, 4 34 ms 182.79.255.50, 5 117 ms 195.22.199.85, 6 129 ms 195.22.214.88, 7 235 ms 89.221.34.73, 8 * Request timed out., 9 * Request timed out., 10 * Request timed out., 11 * Request timed out., 12 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033285">
    <ip>
      <ipaddrs><![CDATA[192.26.23.58]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 5 ms 10.2.30.1, 2 2 ms 125.22.49.113, 3 6 ms 125.23.162.49, 4 106 ms 182.79.245.10, 5 233 ms 213.242.116.161, 6 275 ms 4.69.143.241, 7 232 ms 4.69.143.238, 8 231 ms 4.69.161.114, 9 * Request timed out., 10 233 ms 4.69.137.62, 11 229 ms 4.69.202.58, 12 228 ms 4.69.158.33, 13 233 ms 4.68.62.30, 14 233 ms 12.122.134.186, 15 230 ms 12.123.10.250, 16 231 ms 12.122.134.137, 17 231 ms 12.124.235.190, 18 232 ms 192.12.195.12, 19 230 ms 192.12.195.5, 20 233 ms 192.12.195.12, 21 230 ms 192.12.195.5, 22 239 ms 192.12.195.12, 23 229 ms 192.12.195.5, 24 231 ms 192.12.195.12, 25 228 ms 192.12.195.5, 26 233 ms 192.12.195.12, 27 231 ms 192.12.195.5, 28 229 ms 192.12.195.12, 29 229 ms 192.12.195.5, 30 285 ms 192.12.195.12, ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033217">
    <ip>
      <ipaddrs><![CDATA[10.2.30.2]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 2869 ms 10.2.30.147, 2 2999 ms 10.2.30.147, 3 3000 ms 10.2.30.147, 4 2999 ms 10.2.30.147, 5 2999 ms 10.2.30.147, 6 2999 ms 10.2.30.147, 7 3000 ms 10.2.30.147, 8 2999 ms 10.2.30.147, 9 3000 ms 10.2.30.147, 10 2999 ms 10.2.30.147, 11 2999 ms 10.2.30.147, 12 3000 ms 10.2.30.147, 13 3000 ms 10.2.30.147, 14 2999 ms 10.2.30.147, 15 3000 ms 10.2.30.147, 16 2999 ms 10.2.30.147, 17 3000 ms 10.2.30.147, 18 2999 ms 10.2.30.147, 19 2999 ms 10.2.30.147, 20 3000 ms 10.2.30.147, 21 2999 ms 10.2.30.147, 22 3000 ms 10.2.30.147, 23 2999 ms 10.2.30.147, 24 2999 ms 10.2.30.147, 25 3002 ms 10.2.30.147, 26 2997 ms 10.2.30.147, 27 3000 ms 10.2.30.147, 28 2999 ms 10.2.30.147, 29 3000 ms 10.2.30.147, 30 2999 ms 10.2.30.147, ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033221">
    <ip>
      <ipaddrs><![CDATA[10.2.30.8]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 2869 ms 10.2.30.147, 2 2999 ms 10.2.30.147, 3 3000 ms 10.2.30.147, 4 2999 ms 10.2.30.147, 5 3000 ms 10.2.30.147, 6 2999 ms 10.2.30.147, 7 3000 ms 10.2.30.147, 8 2999 ms 10.2.30.147, 9 2999 ms 10.2.30.147, 10 3000 ms 10.2.30.147, 11 2999 ms 10.2.30.147, 12 2999 ms 10.2.30.147, 13 3000 ms 10.2.30.147, 14 2999 ms 10.2.30.147, 15 2999 ms 10.2.30.147, 16 3000 ms 10.2.30.147, 17 2999 ms 10.2.30.147, 18 3000 ms 10.2.30.147, 19 3000 ms 10.2.30.147, 20 2999 ms 10.2.30.147, 21 3000 ms 10.2.30.147, 22 2999 ms 10.2.30.147, 23 3000 ms 10.2.30.147, 24 2999 ms 10.2.30.147, 25 3000 ms 10.2.30.147, 26 3000 ms 10.2.30.147, 27 3000 ms 10.2.30.147, 28 2999 ms 10.2.30.147, 29 2999 ms 10.2.30.147, 30 3003 ms 10.2.30.147, ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033381">
    <ip>
      <ipaddrs><![CDATA[10.10.10.44]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033377">
    <ip>
      <ipaddrs><![CDATA[10.10.10.40]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033270">
    <ip>
      <ipaddrs><![CDATA[6.6.63.3]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 2 ms 10.2.30.1, 2 43 ms 125.22.49.113, 3 6 ms 125.23.162.49, 4 248 ms 182.79.255.33, 5 268 ms 63.146.26.237, 6 * Request timed out., 7 * Request timed out., 8 271 ms 143.56.245.2, 9 * Request timed out., 10 300 ms 140.6.0.75, 11 * Request timed out., 12 * Request timed out., 13 * Request timed out., 14 * Request timed out., 15 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033385">
    <ip>
      <ipaddrs><![CDATA[10.10.10.48]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033317">
    <ip>
      <ipaddrs><![CDATA[17.17.17.19]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 22 ms 10.2.30.1, 2 67 ms 125.22.49.113, 3 101 ms 125.23.162.49, 4 137 ms 182.79.245.10, 5 232 ms 213.242.116.161, 6 248 ms 4.69.143.241, 7 269 ms 4.69.143.238, 8 252 ms 4.69.161.122, 9 * Request timed out., 10 253 ms 4.69.137.50, 11 267 ms 4.69.201.90, 12 272 ms 4.69.135.254, 13 252 ms 4.69.201.37, 14 254 ms 4.69.135.185, 15 251 ms 4.69.153.2, 16 334 ms 4.69.153.17, 17 255 ms 4.69.132.157, 18 392 ms 4.69.132.149, 19 * Request timed out., 20 * Request timed out., 21 * Request timed out., 22 * Request timed out., 23 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033393">
    <ip>
      <ipaddrs><![CDATA[10.10.10.56]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 2 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033389">
    <ip>
      <ipaddrs><![CDATA[10.10.10.52]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 2 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033302">
    <ip>
      <ipaddrs><![CDATA[13.13.13.13]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 58 ms 10.2.30.1, 2 19 ms 125.22.49.113, 3 16 ms 125.23.162.49, 4 197 ms 182.79.245.113, 5 282 ms 213.242.116.165, 6 223 ms 4.69.143.241, 7 227 ms 4.69.143.238, 8 230 ms 4.69.161.110, 9 * Request timed out., 10 231 ms 4.69.137.50, 11 282 ms 4.69.134.158, 12 410 ms 4.69.149.210, 13 234 ms 4.53.116.46, 14 249 ms 74.40.2.177, 15 245 ms 74.40.5.17, 16 243 ms 74.40.1.206, 17 * Request timed out., 18 * Request timed out., 19 * Request timed out., 20 * Request timed out., 21 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033206">
    <ip>
      <ipaddrs><![CDATA[10.2.30.131]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 * Request timed out., 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033353">
    <ip>
      <ipaddrs><![CDATA[10.10.10.16]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 2 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033256">
    <ip>
      <ipaddrs><![CDATA[10.10.10.11]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033331">
    <ip>
      <ipaddrs><![CDATA[6.6.6.6]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 21 ms 125.22.49.113, 3 25 ms 125.23.162.49, 4 250 ms 182.79.255.33, 5 279 ms 63.146.26.237, 6 * Request timed out., 7 * Request timed out., 8 287 ms 143.56.245.2, 9 275 ms 140.6.245.1, 10 300 ms 140.6.0.75, 11 * Request timed out., 12 * Request timed out., 13 * Request timed out., 14 * Request timed out., 15 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033349">
    <ip>
      <ipaddrs><![CDATA[10.10.10.12]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033341">
    <ip>
      <ipaddrs><![CDATA[10.10.10.2]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033401">
    <ip>
      <ipaddrs><![CDATA[10.10.10.64]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033397">
    <ip>
      <ipaddrs><![CDATA[10.10.10.60]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033405">
    <ip>
      <ipaddrs><![CDATA[10.10.10.68]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033361">
    <ip>
      <ipaddrs><![CDATA[10.10.10.24]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033433">
    <ip>
      <ipaddrs><![CDATA[10.10.10.96]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 * Request timed out., 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033413">
    <ip>
      <ipaddrs><![CDATA[10.10.10.76]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 * Request timed out., 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033357">
    <ip>
      <ipaddrs><![CDATA[10.10.10.20]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 2 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033429">
    <ip>
      <ipaddrs><![CDATA[10.10.10.92]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033409">
    <ip>
      <ipaddrs><![CDATA[10.10.10.72]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 0 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033365">
    <ip>
      <ipaddrs><![CDATA[10.10.10.28]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033295">
    <ip>
      <ipaddrs><![CDATA[192.48.21.23]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 4 ms 125.22.49.113, 3 9 ms 125.23.162.49, 4 229 ms 182.79.245.81, 5 * Request timed out., 6 * Request timed out., 7 * Request timed out., 8 * Request timed out., 9 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033373">
    <ip>
      <ipaddrs><![CDATA[10.10.10.36]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 2 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033369">
    <ip>
      <ipaddrs><![CDATA[10.10.10.32]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 * Request timed out., 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033281">
    <ip>
      <ipaddrs><![CDATA[172.66.33.33]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 2 ms 10.2.30.1, 2 17 ms 125.22.49.113, 3 38 ms 125.23.162.49, 4 237 ms 59.144.36.122, 5 * Request timed out., 6 * Request timed out., 7 * Request timed out., 8 * Request timed out., 9 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033274">
    <ip>
      <ipaddrs><![CDATA[36.36.36.36]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 * Request timed out., 2 2 ms 125.22.49.113, 3 12 ms 125.23.162.49, 4 277 ms 182.79.245.10, 5 266 ms 213.248.94.113, 6 289 ms 62.115.138.128, 7 245 ms 80.91.251.247, 8 248 ms 213.155.133.239, 9 660 ms 213.248.73.190, 10 606 ms 219.158.102.197, 11 636 ms 219.158.97.33, 12 * Request timed out., 13 635 ms 219.158.9.170, 14 672 ms 112.92.0.82, 15 706 ms 120.80.165.34, 16 * Request timed out., 17 * Request timed out., 18 * Request timed out., 19 * Request timed out., 20 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033441">
    <ip>
      <ipaddrs><![CDATA[18.18.18.17]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out.,]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033437">
    <ip>
      <ipaddrs><![CDATA[10.10.10.100]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033345">
    <ip>
      <ipaddrs><![CDATA[10.10.10.8]]></ipaddrs>
      <ipstatus><![CDATA[DOWN]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[1 1 ms 10.2.30.1, 2 * Request timed out., 3 * Request timed out., 4 * Request timed out., 5 * Request timed out., 6 * Request timed out., ]]></trecerdesc>
    </ip>
  </regid>
  <regid id = "50033321">
    <ip>
      <ipaddrs><![CDATA[30.30.30.30]]></ipaddrs>
      <ipstatus><![CDATA[UP]]></ipstatus>
      <errcode><![CDATA[]]></errcode>
      <errdesc><![CDATA[]]></errdesc>
      <trecerdesc><![CDATA[]]></trecerdesc>
    </ip>
  </regid>
</wpfirewallipstatus>' ,@OutStatus OUTPUT 
SELECT @OutStatus 
 
=====================PURPOSE========================= 
To get the status of configured IP’s  in table  :PubIPMon_ConfigStatus,PubIPMon_ConfigStatus_History
=====================OUTPUT========================== 
Input : @InXML VARCHAR(MAX)
Output : @OutStatus INT OUTPUT
=====================PAGE NAME(CALLING)==============
Called by wpost
=====================CREATED BY/DATE ================
Anamika Pandey
8th July 2014
=====================CHANGED BY/DATE ================
Anamika Pandey
04th Aug 2014
Removed check for @Cnt while insert data.
*/ 
--------------------------------------------------------------------

SET NOCOUNT ON

	DECLARE @XmlStr XML 
	SET @XmlStr=CAST(@InXML AS XML)

	DECLARE @IPStatus TABLE
	(
		[PubIPRegID] BIGINT,
		[PubIPAddrs] VARCHAR(100),
		[IPStatus] VARCHAR(50),
		[ErrCode] BIGINT,
		[ErrDesc] VARCHAR(1000),
		[TracertDesc] VARCHAR(1000)
	)

	INSERT INTO @IPStatus(PubIPRegID,PubIPAddrs,IPStatus,ErrCode,ErrDesc,TracertDesc) 
	SELECT Fields.value('../@id','bigint') AS  [PubIPRegID],
		   Fields.value('ipaddrs[1]','varchar(100)') AS  [PubIPAddrs],	
		   Fields.value('ipstatus[1]','varchar(50)') AS  [IPStatus],
		   Fields.value('errcode[1]','bigint') AS  [ErrCode],
		   Fields.value('errdesc[1]','varchar(1000)') AS  [ErrDesc],
		   Fields.value('trecerdesc[1]','varchar(1000)') AS  [TracertDesc]
	FROM @XmlStr.nodes('/wpfirewallipstatus/regid/ip') AS A(Fields)

	BEGIN TRY
		UPDATE IPS
		SET IPS.IPStatus=S.IPStatus,
			IPS.ErrCode=S.ErrCode,
			IPS.ErrDesc=S.ErrDesc,
			IPS.TracertDesc=S.TracertDesc,
			IPS.UpDcdTime=GETDATE()
		OUTPUT DELETED.PubIPRegID,DELETED.PubIPAddrs,DELETED.IPStatus,DELETED.ErrCode,DELETED.ErrDesc,DELETED.TracertDesc,
			   DELETED.DcdTime,DELETED.UpDcdTime,GETDATE() 	  
		INTO PubIPMon_ConfigStatus_History(PubIPRegID,PubIPAddrs,IPStatus,ErrCode,ErrDesc,TracertDesc,DcdTime,UpDcdTime,InsertedOn) 	   
		FROM PubIPMon_ConfigStatus IPS
		INNER JOIN @IPStatus S ON S.PubIPRegID=IPS.PubIPRegID AND S.PubIPAddrs=IPS.PubIPAddrs  
		
		----------------------------------------------------------------------------------
		INSERT INTO PubIPMon_ConfigStatus(PubIPRegID,PubIPAddrs,IPStatus,ErrCode,ErrDesc,TracertDesc) 
		SELECT IP.PubIPRegID,IP.PubIPAddrs,IP.IPStatus,IP.ErrCode,IP.ErrDesc,IP.TracertDesc
		FROM @IPStatus IP  
		LEFT JOIN PubIPMon_ConfigStatus S WITH(NOLOCK) ON S.PubIPRegID=IP.PubIPRegID AND S.PubIPAddrs=IP.PubIPAddrs 
		WHERE S.PubIPRegID IS NULL

		SET @OutStatus=1
	END TRY
		
	BEGIN CATCH 
		SET @OutStatus=0
	END CATCH

SET NOCOUNT OFF	
GO
