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

# Deye Hybrid Inverters HMI Firmware (MCU1)
http://47.254.36.66/0_5407_1/MCU1-SG-Ver0000-C362-CK.bin
http://47.254.36.66/0_5407_1/MCU1-SG-Ver0000-C36E-CK.bin
http://47.254.36.66/0_5407_1/MCU1-SG-Ver0000-C372-CK.bin

# Deye Hybrid Inverters Main Firmware (MCU2)
http://47.254.36.66/0_5407_1/SG_5K_MCU2_V3387-NR.bin (SUN-5K-SG04LP1-AU)
http://47.254.36.66/0_5407_1/SG_6K_MCU2_V4386-NR.bin (SUN-6K-SG03LP1-EU)
http://47.254.36.66/0_5407_1/MCU2_5227US_NC_NR8K59V.bin (SUN-8K-SG01LP1-??)
http://47.254.36.66/0_5407_1/MCU2_6027US_NC_NR8K59V.bin (SUN-8K-SG01LP1-??)

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

## Other notable Projects

- [Deye Microinverter - Cloud-free](https://github.com/Hypfer/deye-microinverter-cloud-free)
- [Deye solar inverter MQTT bridge](https://github.com/kbialek/deye-inverter-mqtt)
- [deye-logger-at-cmd](https://github.com/s10l/deye-logger-at-cmd)
  This one has a lot of useful insights into resetting passwords `AT+WEBU` or Modbus access.
- [Solarman integration - Homeassistant](https://github.com/StephanJoubert/home_assistant_solarman)
- And more Repositories tagged with [deye](https://github.com/topics/deye)

## Call for help

If you have more information or insights into the firmware update process, alternative URLs or other information let me know.


# Deye Hybrid Inverter Firmware

Deye also stores the firmware for their hybrid inverters on the same server. So far the http://47.254.36.66/0_5407_1/ directory has been identified, but there may be others.
The firmware located here has been confirmed to work on the SUN-3K-SG04LP1-AU-24V and SUN-5K-SG04LP1-AU, however based on naming conventions, it seems like this same firmware is used across a lot of the hybrid inverter models and regions.

There are two types of firmware files in there, one for the HMI (display) and the other for the main firmware.
Examples: 
Main: SG_5K_MCU2_V3384-NR.bin
HMI: MCU1-SG-Ver0000-C366-CK.bin

Based on information in this forum thread: https://powerforum.co.za/topic/12655-deye-inverter-latest-firmware/
It is recomended to update the HMI first, followed by the Main firmware. Generally the HMI firmware update doesn't result in the inverter shutting down the outputs, but the Main firmware normally does.

Update Procedure :

1) Go to the IP address of the WiFi module of the inverter (stick logger), login : admin\admin
2) On the left, click the Upgrade inverter item (the inverter itself, not the Stick Logger firmware)
3) Select HMI file, i.e. MCU1-SG-Ver0000-C36E-CK.bin (MCU1 = HMI) as the first file, click upgrade. (time +/- 15 minutes)
4) After rebooting, repeat the procedure, but now select the MAIN firmware file, i.e. SG_6K_MCU2_V4386-NR.bin (MCU2 = MAIN). (time +/- 15 minutes)

FYI : the WiFi Stick Logger can also be updated by the Deye service (yet another firmware).

If you have difficulty, you may need to powercycle the inverter before beginning the process.

## Summary of HMI firmware changes (see photos here hybrid-inverter-info/HMI-photos)

C362 - C369
- Added Language 'Polish'
- 'Low Power Mode<Low Batt' moved from 'Batt Mode' screen to  'Func Set4' screen
- 'Low Noise Mode' moved from 'Batt Set2' screen to 'Func Set4' screen
- 'Grid Side INV Meter2' renamed to 'Grid Tie Meter2' on 'Paral Set3' Screen
- New setting on 'Func Set4' screen: 'Export Power Limiter' (appears to match the 'Max Sell Power' seting on 'Work Mode1' screen)
- New setting on 'Func Set4' screen: 'Import Power Limiter' (the manual says this limits power from the grid, but has a lower priority than 'Grid Peak Shaving' setting.
- New setting on 'Func Set4' screen: 'MPPT Multi-Point Scanning'
- New setting on 'Port Set1' screen: 'off grid immediately off'
- New setting on 'Port Set1' screen: 'AC couple Frz High'
      
