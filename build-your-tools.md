# Build your own tools folder

This page builds the `tools` folder without the lab USB. You need a Windows 10 or Windows 11 computer and internet access. You do not need administrator rights. Every file comes from its publisher's own page. At the end, the setup check accepts your folder line by line.

## Before you start

Make the kit folder first, as the [getting started](getting-started.html) page shows. The module download holds a folder called `tools`, beside the `setup` folder, with one text file in it. Everything on this page goes into that folder.

Keep the full path of the kit folder short: 77 characters or fewer. A good choice is `C:\Users\you\Documents\DWBI`. With a longer path, some files inside WinPython cannot be extracted.

Windows marks every file you download from the internet. Before you extract a zip file, remove the mark. Right-click the zip, choose **Properties**, tick **Unblock**, then choose **OK**. This needs no administrator rights. Windows then does not stop each program to ask about it.

Windows may also show a blue window, "Windows protected your PC", when you start a downloaded program. For the files on this page only, choose **More info**, then **Run anyway**. On a lab computer that button may be missing. Then ask your lecturer.

To check a download, open its folder in File Explorer. Click the address bar, type `cmd` and press Enter. A Command Prompt opens in that folder, ready for the `certutil` lines below.

## 1. PostgreSQL 16.16

1. **Download the zip.** Open [the PostgreSQL binaries page](https://productsdl.enterprisedb.com/download-postgresql-binaries). In the row for version 16.16, click **Windows x86-64**. *Expected:* your browser saves a zip file in Downloads. *If it fails:* if the row for 16.16 is missing, ask your lecturer. Do not choose another version.
2. **Unblock and extract it.** Unblock the zip as shown above. Right-click it, choose **Extract All**, and extract it in Downloads. *Expected:* a folder that holds `bin\psql.exe`. *If it fails:* if Windows says a path is too long, extract the zip into a shorter folder, such as `C:\Users\you\pg`.
3. **Copy it into tools.** Copy the folder that holds `bin` into your `tools` folder, and name it `pgsql`. *Expected:* the file `tools\pgsql\bin\psql.exe` exists. *If it fails:* you copied the wrong level. Open the folders until you see `bin`, then copy the folder around it.

The publisher prints no checksum for this zip, so there is nothing to compare.

## 2. The PostgreSQL driver for DBeaver

1. **Download the jar.** Open [the driver file](https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.14/postgresql-42.7.14.jar), from the [driver's download page](https://jdbc.postgresql.org/download/). *Expected:* `postgresql-42.7.14.jar` in Downloads. *If it fails:* save the link with a right-click, then choose **Save link as**.
2. **Check it.** In a Command Prompt in Downloads, run `certutil -hashfile postgresql-42.7.14.jar SHA1`. *Expected:* `0e7c94ce80cb1dd9875ff44ffe6a40a8aaa3eefd`. *If it fails:* delete the file and download it again.
3. **Put it in tools.** Make a folder `tools\jdbc` and move the jar into it. *Expected:* the file `tools\jdbc\postgresql-42.7.14.jar` exists. *If it fails:* check that the folder is called `jdbc`, inside `tools`.

## 3. DBeaver 26.2.5

1. **Download the zip.** Open [the DBeaver release page](https://github.com/dbeaver/dbeaver/releases/tag/26.2.5). Under **Assets**, click `dbeaver-ce-26.2.5-windows-x86_64.zip`. *Expected:* that zip in Downloads. *If it fails:* if you see only some files, click **Show all assets**. Do not choose the file that ends in `.exe`.
2. **Check it.** Run `certutil -hashfile dbeaver-ce-26.2.5-windows-x86_64.zip SHA256`. *Expected:* `6d137b716061ddd9d1b160ef47a23ab4755d0d393d427809e9a352a351abde4a`. *If it fails:* delete the file and download it again.
3. **Unblock and extract it.** Unblock the zip, then use **Extract All** in Downloads. *Expected:* a folder that holds `dbeaver.exe`. *If it fails:* check that you chose the zip, not the installer.
4. **Copy it into tools.** Copy the folder that holds `dbeaver.exe` into `tools`, and name it `dbeaver`. *Expected:* the file `tools\dbeaver\dbeaver.exe` exists. *If it fails:* open the folders until you see `dbeaver.exe`, then copy the folder around it.

## 4. WinPython 3.14.10.0

1. **Download the file.** Open [the WinPython release page](https://github.com/winpython/winpython/releases/tag/2026-04). Under **Assets**, click `WinPython64-3.14.10.0slim.exe`. *Expected:* that file in Downloads. *If it fails:* click **Show all assets**, then look for the name again.
2. **Check it.** Run `certutil -hashfile WinPython64-3.14.10.0slim.exe SHA256`. *Expected:* `d164a73c9f3e202a9d78e819ea4cadf7d75db0fc719a502cf4eb49bfc0293c31`. *If it fails:* delete the file and download it again.
3. **Start it.** Double-click the file. If Windows shows "Windows protected your PC", choose **More info**, then **Run anyway**. *Expected:* a window called "7-Zip self-extracting archive", with an **Extract to:** box. *If it fails:* if **Run anyway** is missing, ask your lecturer.
4. **Extract it into tools.** In **Extract to:**, type the full path of your `tools` folder, such as `C:\Users\you\Documents\DWBI\tools`. Then click **Extract**. *Expected:* the file `tools\WPy64-314100\python\python.exe` exists. *If it fails:* if a path is too long, your kit folder path is longer than 77 characters. Move the kit to a shorter path and extract again.

This file holds Python 3.14.10, pandas 3.0.5 and JupyterLab 4.6.4. It writes only into the folder you choose, and it needs no administrator rights.

## 5. Java and Metabase

You add these two before Day 6. Their versions and steps appear here before then. Until Day 6 is posted, the setup check passes without them. If you add them earlier, the check tests them at once.

## Check your folder

1. **Run the setup check.** Double-click `setup\0_check_setup.bat`. *Expected:* every tool line says PASS. *If it fails:* find the FAIL line in the table below, and do what it says.

| FAIL line | What it means for a folder you built | What to do |
|---|---|---|
| PostgreSQL not found in tools\pgsql | The file `tools\pgsql\bin\psql.exe` is missing | Repeat step 3 of the PostgreSQL section |
| PostgreSQL *version*: the kit needs 16.10 or later in the 16 line | The zip was not version 16.16 | Repeat the PostgreSQL section with the row for 16.16 |
| PostgreSQL driver not found in tools\jdbc | The jar is not in `tools\jdbc` | Repeat step 3 of the driver section |
| DBeaver not found in tools\dbeaver | `dbeaver.exe` is not in `tools\dbeaver` | Repeat step 4 of the DBeaver section |
| WinPython not found in tools | No folder in `tools` starts with `WPy64` | Repeat step 4 of the WinPython section |
| pandas *version*: the labs need pandas 3.0 or 3.1 | You extracted another WinPython file | Repeat the WinPython section with the file named there |
| Jupyter not found in WinPython | You extracted another WinPython file | Repeat the WinPython section with the file named there |
| Java not found in tools | Day 6 is posted, and Java is missing | Follow the Java and Metabase section |
| Java *version*: Metabase needs Java 25 | The Java folder holds another version | Follow the Java and Metabase section with the version named there |
| Metabase not found in tools\metabase | Day 6 is posted, and Metabase is missing | Follow the Java and Metabase section |

When every line says PASS, go back to [getting started](getting-started.html) and start the tools.
