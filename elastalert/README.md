# Elastaslert Resources

## Configs

Two sample configurations are provided for setting up Elastalert:

- config.yaml - main Elastalert configuration
- supervisord/supervisord.conf - Supervisord configuration for running Elastalert as a daemon

## Rules

| **Rule File** | **Rule Name** | **Description** |
| --- | --- | --- |
| beaconhit.yaml | Beacon Hit | Alerts when a new Cobalt Strike Beacon connection is established. |
| beacon_command_block.yaml | Beacon Command Block (OPSEC Profile) | Alerts when a command ran in a beacon is blocked via the OPSEC Aggressor script. |
| curlwget.yaml | Curl/Wget User Agent | Alerts when a Curl or Wget user agent detected, which can be indicative of manual analyst activity. |
| mysqlhit.yaml | Credential Harvest Hit | Alerts when information is inserted into a specified table. This can be used to detect hits on a phishing server. For example, you can see when a user enters their credentials into a cloned site. This requires query logging to be enabled -- see below for an example configuration to enable this. |
| mysqlhit_wrongdomain.yaml | Email Entered With Wrong Domain | Similar to the standard MySQL hit but also looks for the lack of the target's domain in the insert. |
| sanboxbeacon.yaml | Potential C2 Sandbox | Alerts when a new Cobalt Strike Beacon connection is established and the username is one commonly used by sandboxes (e.g. Alice, Apiary). |
| uri.yaml | URI Hit | Alerts when a specific URI is requested. This can be used in tandem with something like a Word document that has a remote image to detect when its opened. |
| vendorip.yaml | Security Vendor IP Redirect | Alerts when a certain redirect is triggerd by mod_rewrite (uses Apache error.log). This can be used with something like [this](https://gist.github.com/curi0usJack/971385e8334e189d93a6cb4671238b10) to detect when security vendor source IPs interact with your infrastructure. |

*be sure to adjust he index used by the rule before implementing them.

**my.cnf**
```
...
[mysqld]
general_log_file = /var/log/mysql/query.log
general_log      = 1
...
```







