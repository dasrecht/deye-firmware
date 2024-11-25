# Deye Microinverter Firmware

This repository has been started because the Firmware prior to MW3_16U_5406_1.53 had some significant security issues - See also Thread on [Photovoltaikforum (German)](https://www.photovoltaikforum.com/thread/187077-achtung-wifi-sicherheit-der-deye-und-bosswerk-mi600-300-sowie-baugleiche-microwe/?postID=2859297) or [Article on Heise (German)](https://www.heise.de/news/Sicherheitsluecke-bei-Mikrowechselrichtern-von-Deye-Haendler-nicht-zustaendig-7483376.html)

Additionally to that there is a pretty steady pace on firmware releases but sadly no public changelog is available. As the Server was also down for a few days earlier in 2023 I've decided to start this repository to keep the firmware versions somehow online even if the server would face issues.

> I don't take any responsibility for any damage caused by this firmware. Use at your own risk.
> It worked on my inverter, but I can't guarantee it will work on yours.

If you brick your device that's your problem. ;)

Installed on a Deye SUN600G3-EU-230 and it worked fine (5406 in the filename).

My feeling is that the firmware files and IP info can be released out into the wild as it's not hidden and the fact
that there is specifically no HTTPS connection used would suggest that the manufacturer does not care about securing those files.

## Firmware Update Server

The IP of the firmware update server is `47.254.36.66`.
It looks like behind this IP is the firmware update Server of Deye. At least I got greeted with an Nginx default page via HTTP.

## Firmware Update Process

Based on a few forum entries and the answer from Deyes support the Inverters should auto-update to the latest version
when being up and running for 30 minutes.

## Filenames

| Subdirectory | Filename |         Brand         |
| ------------ | -------- | --------------------- |
| 0_D0002_18   | 0501     | Solis Ginglong        |
| 0_D0002_18   | 5406     | Deye                  |
| 0_5407_1     |          | Deye Hybrid Inverters |

## URL Structure

```bash
# Deye
http://47.254.36.66/0_D0002_18/MW3_15U_5406_1.471.bin
http://47.254.36.66/0_D0002_18/MW3_15U_5406_1.49R.bin
http://47.254.36.66/0_D0002_18/MW3_16U_5406_1.53.bin
http://47.254.36.66/0_D0002_18/MW3_16U_5406_1.56.bin
http://47.254.36.66/0_D0002_18/MW3_16U_5406_1.57.bin
http://47.254.36.66/0_D0002_18/MW3_16U_5406_2.04.bin
http://47.254.36.66/0_D0002_18/MW3_16U_5406_2.06.bin
http://47.254.36.66/0_D0002_18/MW3_16U_5406_2.30.bin
http://47.254.36.66/0_D0002_18/MW3_16U_5406_2.31.bin

# Solis Ginglong
http://47.254.36.66/0_D0002_18/MW3_15_0501_1.21.bin
http://47.254.36.66/0_D0002_18/MW3_15_0501_1.23.bin

# Deye Hybrid Inverters
http://47.254.36.66/0_5407_18/MCU1-SG-Ver0000-C362-CK.bin

```

You can use the DIGEST files to verify that those files here are the same as the ones on the server.

```bash
shasum -c MW3_15U_5406_1.471.bin.DIGEST
shasum -c MW3_16U_5406_1.53.bin.DIGEST
```

or verify all DIGEST files

```bash
for filename in *.bin.DIGEST; do
    shasum -a 256 -c $filename
done
```

Create your own DIGEST files

```bash
for filename in *.bin; do
    # create a file called $filename.DIGEST
    shasum -a 256 $filename > $filename.DIGEST
done
```

## extract firmware

```bash
#remove header
dd if=MW3_SSL_5408_1.0B_upgrade_0000000B.bin of=firmware_MW3_SSL_5408_1.0B_upgrade_0000000B.lzma skip=256 bs=1
#unpack
unlzma firmware_MW3_SSL_5408_1.0B_upgrade_0000000B.lzma
```
now the firmware can be displayed with a hexeditor

## Other notable Projects

- [Deye Microinverter - Cloud-free](https://github.com/Hypfer/deye-microinverter-cloud-free)
- [Deye solar inverter MQTT bridge](https://github.com/kbialek/deye-inverter-mqtt)
- [deye-logger-at-cmd](https://github.com/s10l/deye-logger-at-cmd)
  This one has a lot of useful insights into resetting passwords `AT+WEBU` or Modbus access.
- [Solarman integration - Homeassistant](https://github.com/StephanJoubert/home_assistant_solarman)
- And more Repositories tagged with [deye](https://github.com/topics/deye)

## Call for help

If you have more information or insights into the firmware update process, alternative URLs or other information let me know.
