# Deye Microinverter Firmware

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

| Filename | Brand          |
|----------|----------------|
| 0501     | Solis Ginglong |
| 5406     | Deye           |

## URL Structure

```bash
http://47.254.36.66/0_D0002_18/MW3_15U_5406_1.471.bin
http://47.254.36.66/0_D0002_18/MW3_15U_5406_1.49R.bin
http://47.254.36.66/0_D0002_18/MW3_16U_5406_1.53.bin
http://47.254.36.66/0_D0002_18/MW3_15_0501_1.21.bin
http://47.254.36.66/0_D0002_18/MW3_15_0501_1.23.bin
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


## Call for help

If you have more information or insights into the firmware update process, alternative URLs or other information let me know.
