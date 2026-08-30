# README

# Docker
+ build and run services: docker compose up -d build

+ run 1 services: docker compose up -d db

+ check logs for running services : docker compose logs web

+ check continues logs for running services : docker compose logs -f web

+ to check or debugger in rails docker add this line on docker compose
  web:
    stdin_open: true
    tty: true

+ debug using byebug. run the web container first and then `docker compose attach web` to load container shell and ready to debug

# Rails
+ run rails command via docker: docker compose exec web bin/rails db:create

+ verify rails to postgres connection via docker: docker compose exec web bin/rails runner "puts ActiveRecord::Base.connection.active?"docker compose exec web bin/rails runner "puts ActiveRecord::Base.connection.active?"

+ restart web via docker: docker compose restart web

# Postgres
+ open console via docker: docker compose exec db psql -U digital_bank -d digital_bank_development -c '\conninfo' 



# Recommended practical roadmap
## Phase 1 — Core Banking

### Milestone 1 — Foundation

+ Rails 8
+ PostgreSQL
+ Tailwind
+ Git
+ Basic layout
+ Home page

### Milestone 2 — Authentication

+ Registration
+ Login
+ Logout
+ Profile
+ Authorization

### Milestone 3 — Bank Account

+ Account creation
+ Account number
+ Balance
+ Account status

### Milestone 4 — Deposit [HERE]
+ Deposit form
+ Validation
+ Balance update
+ Transaction record

### Milestone 4.A — Simulated Payment Gateway [HOLD]
+ Separate application
+ API authentication
+ Payment request
+ Payment status
+ Callback/webhook
+ Security
+ Digital Bank integration [CONTINUE_LATER]
    - Webhook authentication
    - Webhook failure handling/retry
    - Idempotency
    - Proper webhook processing on the Digital Bank side
    - End-to-end deposit flow verification

### Milestone 5 — Withdrawal

+ Withdrawal form
+ Insufficient balance
+ Balance update
+ Transaction record

### Milestone 6 — Transfer

+ Sender
+ Receiver
+ Transfer amount
+ Balance validation
+ Atomic PostgreSQL transaction
+ Transaction records

At this point you have a working bank.

User
 │
 ├── Deposit
 ├── Withdraw
 └── Transfer
       │
       ▼
   PostgreSQL

## Phase 2 — Hotwire + Stimulus
### Milestone 7 — Transaction History

Build:
+ Transaction list
+ Search
+ Filtering
+ Pagination
+ Transaction details

### Milestone 8 — Hotwire / Turbo

Now introduce:

+ Turbo Drive
+ Turbo Frames
+ Turbo Streams

For example:

Transfer
   ↓
PostgreSQL
   ↓
Turbo Stream
   ├── Update balance
   ├── Add transaction
   └── Show success message

### Milestone 9 — Stimulus

+ Use Stimulus for:
+ Confirmation modal
+ Currency formatting
+ Submit button state
+ Transfer UI
+ Deposit/withdraw UI
+ Client-side interaction

At this point you've learned the main reason you're building this project: Rails + Hotwire + Stimulus.

## Phase 3 — Redis

Now introduce Redis.

This is the right time because your core application is already working.

### Milestone 10 — Redis: Rate Limiting

Start with the simplest Redis use case.

Protect:

/login
/deposit
/withdraw
/transfer

Example:

User
 ↓
POST /transfer
 ↓
Redis
 ↓
Rate limit check
 ↓
Rails

Learn:

Redis connection
Keys
Counters
TTL
Rate limiting

### Milestone 11 — Redis: Login Attempt Protection

Build:

Failed login
     ↓
Redis counter
     ↓
5 failures
     ↓
Temporary lock

Example:

login_attempts:user:123
TTL: 15 minutes

This naturally follows rate limiting because you'll already understand Redis counters and TTL.

### Milestone 12 — Redis: Account/Dashboard Cache

Now learn caching.

Dashboard:

Dashboard
 ├── Account
 ├── Balance
 └── Recent transactions

Flow:

Request
   ↓
Redis
   │
   ├── Cache hit → return cached data
   │
   └── Cache miss
          ↓
      PostgreSQL
          ↓
       Redis

Important:

PostgreSQL remains the source of truth.

After:

Deposit
Withdraw
Transfer

you need to think about cache invalidation.

This is a very valuable real-world lesson.

### Milestone 13 — Redis: Idempotency

I would put this after the cache milestone.

Why?

Because now you're ready to use Redis for something more important than simple caching.

For transfer:

POST /transfers

Idempotency-Key:
8c8c3e...

First request:

Redis
  ↓
Key doesn't exist
  ↓
Execute transfer
  ↓
PostgreSQL
  ↓
Store result

Second request:

Redis
  ↓
Key already exists
  ↓
Return previous result
  ↓
DO NOT transfer again

This is particularly important for your banking application.

## Phase 4 — RabbitMQ

Now the synchronous banking system works and Redis is understood.

This is the right time to introduce RabbitMQ.

The important architectural distinction is:

PostgreSQL
     ↓
Money / financial state

while:

RabbitMQ
     ↓
Events / asynchronous work

### Milestone 14 — RabbitMQ: Basic Notifications

Start with the simplest RabbitMQ feature.

Example:

Deposit successful
        ↓
Publish message
        ↓
RabbitMQ
        ↓
Notification Worker
        ↓
Create notification

For example:

"You deposited $500."

Learn:

Queue
Producer
Consumer
Message
Worker
Acknowledgement

### Milestone 15 — RabbitMQ: Transaction Notifications

Now expand notifications.

Events:

DEPOSIT_COMPLETED
WITHDRAWAL_COMPLETED
TRANSFER_COMPLETED
TRANSFER_RECEIVED

Architecture:

                    Rails
                      │
                      ▼
                 PostgreSQL
                      │
                Transaction OK
                      │
                      ▼
                  RabbitMQ
                      │
          ┌───────────┴───────────┐
          ▼                       ▼
    Notification               Other
      Worker                   Workers

For example:

Alice → Bob
$500

After the transaction succeeds:

RabbitMQ
   ↓
TRANSFER_RECEIVED
   ↓
Notification Worker
   ↓
Bob:
"You received $500 from another account."

This is where you're starting to learn event-driven architecture.

### Milestone 16 — RabbitMQ: Audit Logging

Now introduce a separate consumer.

Example:

TRANSFER_COMPLETED
        ↓
     RabbitMQ
        │
        ├── Notification Worker
        │
        └── Audit Worker
                ↓
           Audit Log

Audit record:

User: 123
Action: TRANSFER
Amount: $500
From: 100001
To: 100002
Time: ...
Reference: TRX-12345

The important lesson here is:

One event can have multiple consumers.

### Milestone 17 — RabbitMQ: Fraud Detection

I would make this the last RabbitMQ feature.

Why?

Because it combines everything you've learned.

Transfer
   ↓
PostgreSQL
   ↓
RabbitMQ
   ↓
Fraud Detection Worker
   ↓
Analyze transaction

Example rules:

Transfer > $10,000
        ↓
Suspicious

or:

20 transfers
within 5 minutes
        ↓
Suspicious

Then:

Fraud Alert
   ↓
RabbitMQ
   ↓
Notification

For your learning project, this can be a simple rule-based system. You don't need actual ML.

## Phase 5 — Advanced Banking
### Milestone 18 — Admin Dashboard

Admin can:

View users
View accounts
Block accounts
View transactions
View transfers
View fraud alerts
View audit logs
Milestone 19 — Ledger

This is where the project becomes much more interesting financially.

Instead of thinking only:

accounts.balance

introduce:

Ledger
   │
   ├── +$1,000 Deposit
   ├── -$500 Transfer
   ├── +$250 Transfer
   └── -$100 Withdrawal

This teaches you how financial systems can maintain a more robust record of money movement.

### Milestone 20 — Security & Concurrency

Now study:

Database locking
Race conditions
Concurrent transfers
Idempotency
Authorization
CSRF
Secure sessions
Input validation
Rate limiting
Audit logging

For example, two simultaneous withdrawals:

Balance = $1,000

Request A → withdraw $800
Request B → withdraw $800

You need to make sure both requests cannot incorrectly succeed.

This is an excellent advanced Rails/PostgreSQL exercise.

### Milestone 21 — Testing

Test:

Deposit
Withdraw
Transfer
Idempotency
Rate limiting
Login lock
Notifications
Fraud detection
Audit logging

Especially test:

Transfer succeeds
Transfer fails
Insufficient balance
Concurrent transfer
Duplicate transfer request
Invalid account
Blocked account

### Milestone 22 — Deployment

Finally:

Rails 8
   │
   ├── PostgreSQL
   ├── Redis
   └── RabbitMQ

Deploy the complete application and configure:

Environment variables
Database
Redis
RabbitMQ
Background workers
Logging
Monitoring
Backups
Final architecture

By the end, your project could look like this:

                         Browser
                            │
                            ▼
                       Rails 8
                            │
             ┌──────────────┼──────────────┐
             │              │              │
             ▼              ▼              ▼
          Hotwire        Stimulus      Controllers
                                           │
                                           ▼
                                    Service Objects
                                           │
                       ┌───────────────────┼─────────────────┐
                       │                   │                 │
                       ▼                   ▼                 ▼
                  PostgreSQL            Redis            RabbitMQ
                  SOURCE OF             │                   │
                    TRUTH               │                   │
                       │                │           ┌───────┼────────┐
                       │                │           │       │        │
                       │                │           ▼       ▼        ▼
                       │                │      Notification Audit   Fraud
                       │                │        Worker    Worker   Worker
                       │                │
                       │                ├── Rate limiting
                       │                ├── Login attempts
                       │                ├── Dashboard cache
                       │                └── Idempotency
                       │
                       ▼
                  Transactions
                  Accounts
                  Ledger
The important sequence

The order I recommend is:

1.  Rails 8
        ↓
2.  PostgreSQL
        ↓
3.  Authentication
        ↓
4.  Account
        ↓
5.  Deposit
        ↓
6.  Withdraw
        ↓
7.  Transfer
        ↓
8.  Transaction history
        ↓
9.  Hotwire
        ↓
10. Stimulus
        ↓
11. Redis — Rate limiting
        ↓
12. Redis — Login attempts
        ↓
13. Redis — Cache
        ↓
14. Redis — Idempotency
        ↓
15. RabbitMQ — Notifications
        ↓
16. RabbitMQ — Transaction events
        ↓
17. RabbitMQ — Audit logging
        ↓
18. RabbitMQ — Fraud detection
        ↓
19. Admin
        ↓
20. Ledger
        ↓
21. Security + concurrency
        ↓
22. Testing
        ↓
23. Deployment

This is the sequence I would use for your project. It prevents you from learning Rails, Hotwire, Redis, RabbitMQ, PostgreSQL transactions, and event-driven architecture all at once.

The most important dependency is: core banking first → Hotwire/Stimulus → Redis → RabbitMQ → advanced banking.

