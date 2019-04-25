AUDIT LOGS
==========

Depending on the type of license in use, a Lightstreamer server instance may
produce some audit logs, which are stored in this folder.

Please refer to your contract and to the Lightstreamer Software License
Agreement to know whether audit logs are required or not.

There are two types of audit log:
- the session audit log reports statistics on the number of concurrent
  Lightstreamer sessions (users)
- the MPN (Mobile Push Notification) audit log reports statistics on the number
  of concurrent MPN devices

Each row in the audit logs refers to a 10-minute slot of server operation.

For the session audit log, the average number of concurrent sessions in those
10 minutes is calculated and reported. Sessions in "prestarted" state are not
counted (that is, sessions for which no related requests have been received
yet, such as control requests, connection bindings, etc.).

For the MPN audit log, the average number of concurrent devices subscribed
to push notifications is calculated and reported. The MPN audit log is produced
only if the MPN module is active.

**NOTE** Please remember to keep the clocks of all your Lightstreamer Server
instances in sync, to make the audit logs reliable (some tolerance, up to 60
seconds, is permitted).
  
----------------
AUDIT LOG FORMAT
----------------

Each line in an audit log file is in pipe-separated format and contains:

- contract_id of the license
- MAC address to which the license is bound (if any)
- measurement type (S: sessions; M: MPN devices)
- unique identifier of the server instance (changes at every server restart)
- timestamp of the beginning of the 10-minute slot under analysis
  (in "yyyy-MM-dd HH:mm:ss UTC" format)
- average number of concurrent sessions or concurrent MPN devices in the
  10-minute slot
- slot counter
- digital signature of the line

--------------------------
AUTOMATIC AUDIT LOG UPLOAD
--------------------------

For file-based licenses, the audit logs can be automatically uploaded to our
servers every 7 days. Only the new portion is uploaded, which is then moved to
a history file.

For online licenses, the audit logs are transmitted automatically upon online
license validation.

The files stored in this folder are the following:
- audit_log.txt: contains the part not yet uploaded of the session audit log
- audit_log.history.txt: contains the part already uploaded of the session audit log
- mpn_audit_log.txt: contains the part not yet uploaded of the MPN audit log
- mpn_audit_log.history.txt: contains the part already uploaded of the MPN audit log

The upload mechanism is very robust and is tolerant to partial files, mixed
files, redundant files, etc., as each row is digitally signed individually and
our server-side logic is able to clean up the data, keeping valid lines only.

You can configure the automatic upload mechanism, in the
lightstreamer_edition_conf.xml file (conf folder).
See the <audit_logs> and <proxy> elements.

To upload an audit log, the Lightstreamer server connects via HTTP to the
service.lightstreamer.com host on TCP port 80. Plain HTTP is used because the
log is encrypted before being sent, thus making the transmission secure.

If an HTTP proxy is needed to access the Internet, it can be easily configured.
Several types of proxy servers, with and without authentication, are supported.

-----------------------
MANUAL AUDIT LOG UPLOAD
-----------------------

If you can't activate automatic audit log upload, you can manually upload the
audit log files to our servers at any time.

A Web page is provided, which allows you to securely upload one or more files.
Each file can be an audit log file or a zip file containing audit log files at
any level (the zip is scanned and any text line in any file without a valid
digital signature is automatically discarded).

You can be notified via email with the results of the parsing process.

To know the URL of your Audit Log Loader page, please contact
support@lightstreamer.com.

--------------------------------
HOW TO VERIFY WHAT IS BEING SENT
--------------------------------

You are given all the tools needed to check exactly what is being transmitted
to us even in case of automatic upload. This is useful if your security policy
prescribes you a deeper assessment before authorizing external traffic generated
from your servers. In particular:

1) You can manually check the audit log files and verify that the signature is
real and correct (we provide the public key and the instructions; see below).

2) A logger is available (LightstreamerLogger.external;
see lightstreamer_log_conf.xml in the conf folder), which, at DEBUG level,
writes to the application log each line that is being uploaded to our servers.

3) You can inspect the network traffic and decrypt the transmitted data.
For each weekly upload session, a Triple DES key is generated and used to
encrypt the data before sending to our servers. Such key is written to the
application log (the same as above at DEBUG level).

Below is the information needed to verify the digital signature of a line:

- The "SHA1withRSA" digital signature algorithm is used (the signature
  algorithm with SHA-1 and the RSA encryption algorithm as defined in the OSI
  Interoperability Workshop, using the padding conventions described in PKCS #1)

- The signed text is comprised of all the characters in the line up to the
  final pipe ('|'), which is excluded. Such characters should be converted
  to their ASCII representation.
  
- The signature is 128 bytes long; its representation in base64 format is
  comprised of all the characters in the line after the final pipe ('|').

- The public key, encoded according to the X.509 standard, is contained in
  Base64 format in the rsa_public_key.txt file in this folder.
