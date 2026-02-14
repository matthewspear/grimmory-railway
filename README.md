# BookLore on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/LcclVg?referralCode=matt)

One-click deploy of [BookLore](https://github.com/booklore-app/booklore) – a self-hosted book and audiobook manager with metadata fetching, reading progress tracking, and library organisation.

## What's Included

- **BookLore** – latest version, auto-updates with `:latest` tag
- **MariaDB** – persistent database for your library metadata
- **Persistent volume** – your books and app data survive redeploys

## Getting Started

After deploying, open your BookLore URL and create an account. You'll be prompted to set up your first library.

### Setting Up Your Library

When creating a library, you'll be asked to add book directories:

1. Click **Add Book Folder** → **Browse for directories**
2. Select **`/books`** – this is your main library folder (persistent, volume-backed)
3. Optionally add **`/bookdrop`** – a watched inbox that auto-imports new files
4. Click **Select Directories** → **Create Library**

### Adding Books

- **Via the UI** – use BookLore's built-in upload to add books directly
- **Via Bookdrop** – any files placed in `/bookdrop` are automatically detected and imported into your library

## Architecture

| Service | Image | Purpose |
|---------|-------|---------|
| BookLore | `booklore/booklore:latest` | App server (Tomcat on port 8080) |
| MariaDB | `mariadb:latest` | Database |

### Volume Layout

Railway supports one volume per service. This template mounts a single volume at `/booklore-data` and uses bind mounts to map subdirectories:

| Container Path | Backed By | Contents |
|---------------|-----------|----------|
| `/app/data` | `/booklore-data/app-data` | App config, covers, icons |
| `/books` | `/booklore-data/books` | Your book library |
| `/bookdrop` | Local (non-persistent) | Temporary import inbox |

> `/bookdrop` is intentionally non-persistent – it's a transient inbox. Files are moved to `/books` after import.

## Environment Variables

These are pre-configured in the template:

| Variable | Default | Description |
|----------|---------|-------------|
| `TZ` | `Etc/UTC` | Timezone |
| `DISK_TYPE` | `LOCAL` | Storage type |
| `DATABASE_URL` | Auto-configured | MariaDB connection string |
| `DATABASE_USERNAME` | `booklore` | DB user |
| `DATABASE_PASSWORD` | Auto-generated | DB password |

## Links

- [BookLore GitHub](https://github.com/booklore-app/booklore)
- [BookLore Docs](https://booklore-app.github.io/booklore-docs/)
- [Railway Docs](https://docs.railway.com/)
