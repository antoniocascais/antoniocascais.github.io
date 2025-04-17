---
layout: none
---

 # Thread Persistence & Lifecycle Improvements
 
 ## Context
 Currently the bot keeps its mapping of Telegram users to OpenAI thread IDs in a flat JSON file (`threads.json`). This approach has limitations:
 - New users don’t get a thread automatically created on first contact.
 - Concurrent accesses can lead to race conditions and file corruption.
 - The JSON file grows unbounded as users increase.
 - No clear lifecycle management for stale or orphaned threads.

 ## Objective
 Introduce a robust persistence layer for thread mappings and lifecycle management to ensure:
 - Automatic thread creation for new users.
 - Safe concurrent access.
 - Cleanup of stale threads.
 - Improved scalability and reliability.

 ## Proposed Solution
 1. Replace JSON file storage with an embedded database (e.g., SQLite, BoltDB) or an external store (e.g., Redis).
 2. Define a `ThreadStore` interface with methods: `GetOrCreateThread(user)`, `UpdateThread(user, threadID)`, `DeleteThread(user)`, `ListThreads()`.
 3. Implement the store with proper locking or transactional guarantees.
 4. Modify the `threads` package to use `ThreadStore` instead of direct file I/O.
 5. On first user message, call `GetOrCreateThread` to ensure a thread exists.
 6. Provide a CLI command or background job to clean up or archive stale threads.

 ## Dependencies
 - Database library (SQLite, BoltDB, or Redis).
 - Migration/schema initialization logic.

 ## Impact Assessment
 - Touches the `threads` package, `main.go`, and initialization code.
 - Improves reliability and scales better for many users.

 ## Related Tickets
 - codex_t2_config_management.md
 - codex_t3_resilient_api_client.md
