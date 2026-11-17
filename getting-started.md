# Getting started

This page sets up the four tools you use in every lab: PostgreSQL, DBeaver, Jupyter with pandas, and Metabase. They run from one folder, with no installation and no administrator rights. You set them up once, then start them the same way each day.

## What you need

You need two things in one folder:

1. **The module files.** Download them from the module's repository page: choose **Code**, then **Download ZIP**. Download them again when a new day is posted.
2. **The tools folder.** Copy the folder called `tools` from the lab USB drive. Or build it yourself, from the publishers' own downloads, with the [Build your own tools folder](build-your-tools.html) page.

You also need a Windows 10 or Windows 11 computer and a web browser.

## Where to put it

1. Right-click the downloaded ZIP file and choose **Properties**. Tick **Unblock**, then choose **OK**. Windows then does not stop each launcher to ask about it.
2. Right-click the ZIP file again and choose **Extract All**. Open the extracted folders until you see the `setup` folder.
3. Move the folder that holds `setup` to a folder you can write to, such as Documents, or to the USB drive itself. Rename it to a short name, such as `DWBI`.
4. Copy the `tools` folder from the lab USB into it, beside the `setup` folder. If you build your own, follow the Build your own tools folder page instead.

Keep the full path of the kit folder short: 77 characters or fewer, such as `C:\Users\you\Documents\DWBI`. A longer path breaks some files inside WinPython. A folder name with spaces is fine.

When you are done, the folder looks like this. We call it the kit folder.

```
DWBI kit\
    setup\       the launchers you double-click
    days\        notes, lab sheets and data for each day
    tools\       PostgreSQL, DBeaver, WinPython, Java and Metabase, from the lab USB or built by you
    data\        your databases: the first launcher creates it
    work\        your notebooks and files: Jupyter and psql start here
```

Do not put the kit folder inside OneDrive. Syncing breaks the database files. Avoid the characters `!` and `%` in folder names.

When a new day is posted, extract the new download over the same kit folder. Your `data`, `work` and `tools` folders stay as they are.

**Note.** If you run the kit from the USB drive, the drive letter may change between computers. That is fine: the launchers find every folder from where they sit.

## Check your setup

Double-click `setup\0_check_setup.bat`. Each line starts with PASS or FAIL. A FAIL line tells you what to do next.

| Line | What it means | If it says FAIL |
|---|---|---|
| Kit folder | The kit can store your databases here | Move the kit folder to Documents, or out of OneDrive |
| PostgreSQL | The database server is in `tools` and new enough | Copy the `tools` folder from the lab USB again, or repeat the step the Build your own tools folder page names |
| Port 15432 | No other program uses PostgreSQL's port | Open `setup\env.bat` in Notepad and change `PGPORT` to another number, such as 15433 |
| DBeaver, PostgreSQL driver | The SQL client and its driver file are in `tools` | Copy the `tools` folder from the lab USB again, or repeat the step the Build your own tools folder page names |
| pandas, Jupyter | WinPython has what the notebooks need | Use the WinPython file the Build your own tools folder page names, or the current lab USB |
| Java, Metabase | Metabase and the Java it needs are in `tools`. A folder you built needs them once Day 6 is posted | Copy the `tools` folder from the lab USB again, or follow the Build your own tools folder page |
| Day files | Each posted day finds its data files, unchanged | Copy the file again from the module files |

Fix the FAIL lines from the top, then run the check again. When every line says PASS, you are ready.

## Start the tools in order

Double-click each launcher in the `setup` folder, in this order. Start only the tools today's lab uses.

1. **`1_start_postgres.bat`** starts the database server. The first time, it also creates the database `thara` and loads the Thara Institute's registration system. Keep its window open while you work.
2. **`2_start_dbeaver.bat`** starts DBeaver. Open the connection called **thara (DWBI kit)**. The user is `postgres`, with no password.
3. **`3_start_jupyter.bat`** starts Jupyter in your `work` folder. Your browser opens it. Keep the window open.
4. **`4_start_metabase.bat`** starts Metabase. Wait until its window shows `Metabase Initialization COMPLETE`, then open `http://localhost:3300` in your browser. Keep the window open.

Two more launchers have no number, because you use them only on some days:

- **`open_psql.bat`** opens a window where psql is ready. Type the lab sheet's commands exactly as written, such as `psql -d thara`.
- **`restore_warehouse.bat`** replaces the warehouse with the correct one from Day 4. It ends with PASS when the tables hold 20, 7, 4 and 73 rows.

Every tool uses the same settings: host `localhost`, port `15432`, database `thara`, user `postgres`, and no password.

## Metabase, the first time

Metabase asks you to create an account the first time. It stays on your computer. Use any name and an address such as `you@thara.example`. Choose a password you will remember.

To add the warehouse, choose **PostgreSQL**. Type host `localhost`, port `15432`, database `thara` and user `postgres`. Leave the password empty.

## When you finish

1. Close DBeaver yourself, so it can ask you to save your SQL scripts.
2. Double-click `setup\stop_all.bat`. It stops PostgreSQL, Metabase and Jupyter.
3. Wait for its PASS line before you remove a USB drive.

## Restoring is not cheating

If your warehouse is wrong, restore it and carry on. Each day's `reference` folder holds the correct output of that day. Using it costs you nothing.

The restore replaces everything in schema `warehouse`, including any table you made there yourself. Schema `registration` is not touched.

## When a step fails

| What you see | Why | What to do |
|---|---|---|
| The check says port 15432 is used by another program | This computer already runs a database on that port | Change `PGPORT` in `setup\env.bat`, then start again |
| PostgreSQL does not start after you pulled out the USB drive | The server was not stopped, so a lock file was left | Run `1_start_postgres.bat` again: it removes the old lock file |
| psql says `invalid command \restrict` | Another, older psql ran instead of the kit's | Use `open_psql.bat`, which runs the kit's own psql |
| psql says `No such file or directory` | psql started in another folder | Use `cd` to go to the folder that holds the file, then run the command again |
| Windows asks about the firewall | A program tried to listen on the network | Choose **Cancel**. The kit only uses this computer, so it still works |
| DBeaver asks to download a driver and cannot | The computer has no internet | In DBeaver, open **Database**, then **Driver Manager**. Edit **PostgreSQL**, open **Libraries** and add the file in `tools\jdbc` |
| The browser cannot open `http://localhost:3300` | Metabase has not finished starting, or the address is mistyped | Wait for `Metabase Initialization COMPLETE` in its window, then try again |
| The restore seems to stop and wait | DBeaver or another window holds the warehouse open | Close DBeaver's open transaction, or close DBeaver, and the restore carries on |
| Metabase says Java is too old | The Java in `tools` does not match Metabase | Use the Java the Build your own tools folder page names, or the current lab USB |

If a step still fails, run `setup\0_check_setup.bat` and show its lines to your lecturer.

## On your own laptop

The same kit runs on your own Windows laptop. Copy the whole kit folder, with its `tools` folder, from the lab USB. Or build the `tools` folder yourself with the [Build your own tools folder](build-your-tools.html) page. If PostgreSQL is already installed on your laptop, the kit's own server runs beside it on its own port.
