# SMP Monitor

Bash scripts to monitor STB (Set-Top Box) online/offline counts on
ZTE SMP platform, store history, and detect abnormal trends.

## Environment

- Runs on SMP DB1 (PG / PostgreSQL)
- Authenticated via peer auth (must run as `postgres` user)
- Tested on PostgreSQL 9.4.1

## Scripts

| Script | Purpose |
|---|---|
| `q_Online_Offline.sh` | Query current online/offline counts |

## Usage

```bash
# As root
su - postgres
cd ~/smp_monitor
./script/query_status.sh
```
## Roadmap

- [x] Step 1: Query online/offline count
- [x] Step 2: Add timestamp + log file
- [ ] Step 3: Save history to CSV
- [ ] Step 4: Compute baseline from history
- [ ] Step 5: Classify normal / abnormal
- [ ] Step 6: Email alert on abnormal trend
