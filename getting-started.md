# Getting started

This page sets up the four tools you use in every lab: PostgreSQL, DBeaver, Jupyter with pandas, and Metabase. They run from one folder, with no installation and no administrator rights. You set them up once, then start them the same way each day.

## What you need

You need two things in one folder:

1. **The module files.** [Download the module files as one ZIP](https://github.com/nirangadh/HNDSE-Data-Warehousing-and-Business-Intelligence/archive/refs/heads/main.zip). The same ZIP is on the [module's repository page](https://github.com/nirangadh/HNDSE-Data-Warehousing-and-Business-Intelligence), under **Code**, then **Download ZIP**. Download it again when a new day is posted.
2. **The tools folder.** Build it with the [Build your own tools folder](build-your-tools.html) page, from the publishers' own downloads. If your computer cannot download them, that page shows how to build the folder on another computer.

You also need a Windows 10 or Windows 11 computer and a web browser.

## Where to put it

1. Right-click the downloaded ZIP file and choose **Properties**. Tick **Unblock**, then choose **OK**. Windows then does not stop each launcher to ask about it.
2. Right-click the ZIP file again and choose **Extract All**. Open the extracted folders until you see the `setup` folder.
3. Move the folder that holds `setup` to a folder you can write to, such as Documents. Rename it to a short name, such as `DWBI`.
4. Build the `tools` folder inside it, beside the `setup` folder, with the Build your own tools folder page.

Keep the full path of the kit folder short: 77 characters or fewer, such as `C:\Users\you\Documents\DWBI`. A longer path breaks some files inside WinPython. A folder name with spaces is fine.

When you are done, the folder looks like this. We call it the kit folder.

```
DWBI\
    setup\       the launchers you double-click
    days\        notes, lab sheets and data for each day
    tools\       PostgreSQL, DBeaver, WinPython, Java and Metabase, from the Build your own tools folder page
    data\        your databases: the first launcher creates it
    work\        your notebooks and files: Jupyter and psql start here
```

Do not put the kit folder inside OneDrive. Syncing breaks the database files. Avoid the characters `!` and `%` in folder names.

When a new day is posted, update the kit folder like this:

1. Download the ZIP again, unblock it, and use **Extract All** in Downloads, as above.
2. Open the extracted folders until you see the `setup` folder.
3. Select everything at that level, choose **Copy**, then open your kit folder and choose **Paste**.
4. When Windows asks about files with the same names, choose **Replace the files in the destination**.

Your `data`, `work` and `tools` folders stay as they are, because the download has none of them. If you changed `PGPORT` in `setup\env.bat`, the new copy sets it back, so change it again.

**Note.** If you move the kit folder to another computer or drive, its drive letter may change. That is fine: the launchers find every folder from where they sit.

## Check your setup

Double-click `setup\0_check_setup.bat`. Each line starts with PASS or FAIL. A FAIL line tells you what to do next.

| Line | What it means | If it says FAIL |
|---|---|---|
| Kit folder | The kit can store your databases here | Move the kit folder to Documents, or out of OneDrive |
| PostgreSQL | The database server is in `tools` and new enough | Follow the section and step the FAIL line names, on the Build your own tools folder page |
| Port 15432 | No other program uses PostgreSQL's port | Open `setup\env.bat` in Notepad and change `PGPORT` to another number, such as 15433 |
| DBeaver, PostgreSQL driver | The SQL client and its driver file are in `tools` | Follow the section and step the FAIL line names, on the Build your own tools folder page |
| pandas, Jupyter | WinPython has what the notebooks need | Follow the section and step the FAIL line names, on the Build your own tools folder page |
| Java, Metabase | Metabase and the Java it needs are in `tools`, once Day 6 is posted | Follow the section and step the FAIL line names, on the Build your own tools folder page |
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
- **`restore_warehouse.bat`** replaces the warehouse with the correct one from Day 4. It ends with PASS when the tables hold 20, 7, 4 and 73 rows. Those are `dim_student`, `dim_course`, `dim_date` and `fact_enrollment`, in that order.

Every tool uses the same settings: host `localhost`, port `15432`, database `thara`, user `postgres`, and no password. If you changed `PGPORT` in `setup\env.bat`, use your number wherever this site says port `15432`.

## Running SQL in DBeaver

1. In DBeaver's **Database Navigator**, open the connection **thara (DWBI kit)**. Open the levels under it until you see **Schemas**.
2. To open an SQL editor, select the connection, then choose **SQL Editor** and **New SQL script**.
3. To run one statement, put the cursor inside it and press **Ctrl+Enter**. Leave an empty line between statements, so DBeaver can tell them apart.
4. Run each statement once. **Execute script**, Alt+X, runs every statement in the editor again, so a load runs twice.
5. To see a diagram, right-click a schema, such as `registration`, and choose **View Diagram**.

The lab sheets write each result the way psql prints it. This is how each one looks in DBeaver:

| The lab sheet shows | What it means | In DBeaver you see |
|---|---|---|
| `Database Systems \| 9` | one row of a result, its columns split by `\|` | one row of the result grid, the same values in the same order |
| `(6 rows)` | how many rows the result has | the count of rows at the foot of the result, such as `6 row(s) fetched` |
| `SET`, `CREATE TABLE`, `DROP TABLE` | the statement ran | no error. The **Statistics** tab shows `Updated Rows 0` |
| `INSERT 0 6` | rows were added: the last number is the count, and the `0` before it is always `0` | the **Statistics** tab shows `Updated Rows 6` |
| `SELECT 73` after `CREATE TABLE ... AS` | the new table holds that many rows | the **Statistics** tab shows `Updated Rows 73` |
| `ERROR: column "campus" does not exist` | the statement failed, for the reason given | an error that starts `SQL Error [42703]:`, then the same words |

psql is the command-line client of PostgreSQL. You meet it in `open_psql.bat`, and it prints exactly what the lab sheets show.

## Metabase, the first time

Metabase asks you to create an account the first time. It stays on your computer. Use any name and an address such as `you@thara.example`. Choose a password you will remember.

To add the warehouse, choose **PostgreSQL**. Type host `localhost`, port `15432` or the number you set, database `thara` and user `postgres`. Leave the password empty.

## When you finish

1. Close DBeaver yourself, so it can ask you to save your SQL scripts.
2. Double-click `setup\stop_all.bat`. It stops PostgreSQL, Metabase and Jupyter.
3. Wait for its PASS line before you move the kit folder or turn the computer off.

## How each day works

Each day has a page on this site. Work through it in this order:

1. **Before the day.** Read the notes. Each notes page starts with the key words for that day.
2. **Theory.** Follow the theory slides in class, with the notes open beside them.
3. **Lab.** Follow the lab sheet step by step. Each step says what to run, what you should see, and what to do if you do not see it.
4. **After the lab.** Keep the files the lab sheet's Evidence section lists. Then try the practice activities on the day's page.
5. **Before the next day.** Answer the notes' Self-Check, and do the day's tasks.

## Your evidence repository

Evidence is the record that you did each lab: the screenshots, outputs and pages each lab sheet's Evidence section lists. Every student keeps their own. Nothing is done in pairs unless a page says so.

Keep your evidence in one private GitHub repository, from Day 1 on:

1. Sign in to GitHub, and create a new repository. Name it `dwbi-evidence`, and choose **Private**.
2. Make one folder for each day: `day-1`, `day-2`, and so on. On GitHub, choose **Add file**, then **Upload files**. To make a folder, type its name and a slash before the file name.
3. After each lab, upload that day's evidence into its folder.
4. When your lecturer asks for evidence, add them as a collaborator. Choose **Settings**, then **Collaborators**, then **Add people**, and enter the GitHub username your lecturer gives your cohort.

Anything you submit goes through this repository, with your lecturer added as a collaborator. Your lecturer announces which work is submitted and when.

## Restoring is not cheating

If your warehouse is wrong, restore it and carry on. Each day's `reference` folder holds the correct output of that day. Using it costs you nothing.

The restore replaces everything in schema `warehouse`, including any table you made there yourself. Schema `registration` is not touched.

## When a step fails

| What you see | Why | What to do |
|---|---|---|
| The check says port 15432 is used by another program | This computer already runs a database on that port | Change `PGPORT` in `setup\env.bat`, then start again |
| PostgreSQL does not start after the kit folder was moved, or the computer was turned off | The server was not stopped, so a lock file was left | Run `1_start_postgres.bat` again: it removes the old lock file |
| psql says `invalid command \restrict` | Another, older psql ran instead of the kit's | Use `open_psql.bat`, which runs the kit's own psql |
| psql says `No such file or directory` | psql started in another folder | Use `cd` to go to the folder that holds the file, then run the command again |
| Windows asks about the firewall | A program tried to listen on the network | Choose **Cancel**. The kit only uses this computer, so it still works |
| DBeaver asks to download a driver and cannot | The computer has no internet | In DBeaver, open **Database**, then **Driver Manager**. Edit **PostgreSQL**, open **Libraries** and add the file in `tools\jdbc` |
| The browser cannot open `http://localhost:3300` | Metabase has not finished starting, or the address is mistyped | Wait for `Metabase Initialization COMPLETE` in its window, then try again |
| The restore seems to stop and wait | DBeaver or another window holds the warehouse open | Close DBeaver, and the restore carries on |
| Metabase says Java is too old | The Java in `tools` does not match Metabase | Follow section 5 of the Build your own tools folder page |

If a step still fails, run `setup\0_check_setup.bat` and show its lines to your lecturer.

## On your own laptop

The same kit runs on your own Windows laptop. Make the kit folder as above, and build its `tools` folder with the [Build your own tools folder](build-your-tools.html) page. If PostgreSQL is already installed on your laptop, the kit's own server runs beside it on its own port.
