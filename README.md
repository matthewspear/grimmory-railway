# Grimmory on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/grimmory-1?referralCode=matt&utm_medium=integration&utm_source=template&utm_campaign=generic)

Railway template wrapper for [Grimmory](https://github.com/grimmory-tools/grimmory), the community fork of BookLore.

Grimmory is a self-hosted book and audiobook manager with metadata fetching, reading progress tracking, and library organisation.

## What's Included

- **Grimmory** – pinned to `grimmory/grimmory:v3.1.0` for predictable deploys
- **MariaDB** – persistent database for your library metadata
- **Persistent volume** – your books and app data survive redeploys

## Getting Started

After deploying, open your Grimmory URL and create an account. You'll be prompted to set up your first library.

### Setting Up Your Library

When creating a library, you'll be asked to add book directories:

1. Click **Add Book Folder** → **Browse for directories**
2. Select **`/books`** – this is your main library folder (persistent, volume-backed)
3. Optionally add **`/bookdrop`** – a watched inbox that auto-imports new files
4. Click **Select Directories** → **Create Library**

### Adding Books

- **Via the UI** – use Grimmory's built-in upload to add books directly
- **Via Bookdrop** – any files placed in `/bookdrop` are automatically detected and imported into your library

## Architecture

| Service | Image | Purpose |
|---------|-------|---------|
| Grimmory | `grimmory/grimmory:v3.1.0` | App server (port 6060) |
| MariaDB | `mariadb:latest` | Database |

### Volume Layout

Railway supports one volume per service. This template mounts a single volume at `/booklore-data` and maps subdirectories into the paths Grimmory expects:

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
| `PORT` | `6060` | Railway router port |
| `DISK_TYPE` | `LOCAL` | Storage type |
| `DATABASE_URL` | Auto-configured | MariaDB connection string |
| `DATABASE_USERNAME` | `booklore` | DB user |
| `DATABASE_PASSWORD` | Auto-generated | DB password |

## Links

- [Grimmory GitHub](https://github.com/grimmory-tools/grimmory)
- [Grimmory Docs](https://grimmory.org/docs)
- [Railway Docs](https://docs.railway.com/)
