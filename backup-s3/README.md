# Hassio Addon for Backing up to S3 Bucket

Add-on for uploading hass.io snapshots to AWS S3.

## Installation

Under the Add-on Store tab in the Hass.io Supervisor view in HA add this repo as an add-on repository: `https://github.com/ezlo-picori/hassio-addons`.

Install, then set the config variables that you obtained from setting up the S3 storage:

```yaml
awskey: `access key id`
awssecret: `secret access key`
awsendpoint: `URL to S3 endpoint`
bucketname: `AWS S3 bucket name`
```

## Usage

To sync your HASSIO backup folder with AWS just click START in this add-on. It will keep a synced cloud-copy, so any purged backup files will not be kept in your bucket either.

You could automate this using Automation:

```
# backups
- alias: Make snapshot
  trigger:
    platform: time
    at: '3:00:00'
  condition:
    condition: time
    weekday:
      - mon
  action:
    service: hassio.snapshot_full
    data_template:
      name: Automated Backup {{ now().strftime('%Y-%m-%d') }}

- alias: Upload to S3
  trigger:
    platform: time
    at: '3:30:00'
  condition:
    condition: time
    weekday:
      - mon
  action:
    service: hassio.addon_start
    data:
      addon: local_backup_s3
```

The automation above first makes a snapshot at 3am, and then at 3.30am uploads to S3.

## Help and Debug

Please post an issue on this repo with your full log.

## Credits

This addon was subject to many forks since its original development.
Original project was developed by [rrostt]/[hassio-backup-s3](https://github.com/rrostt/hassio-backup-s3). It has been forked by [jperquin] and then by [mikebell] whose fork served as a basis for the current addon version.

[jperquin]: https://github.com/jperquin
[mikebell]: https://github.com/mikebell
[rrostt]: https://github.com/rrostt
