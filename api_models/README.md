# Smithy Models for the API

**User Service**: Manages user profiles and authentication.
**Chat Service**: Handles chat messages, including saving and retrieving.
**File Service**: Responsible for file uploads, downloads, and metadata.
**Channel Service**: Manages channel creation, user invitations, and metadata.
**Unified Search Service**: Provides a centralized search functionality across indexed data from User, Chat, File, and Channel services.

## Data Models

### User

- `user_id`: Unique identifier for a user.
- `username`: Username chosen by the user.
- `password_hash`: Hashed version of the user's password.
- `email`: User's email address.
- Additional fields like `first_name`, `last_name`, `profile_image`, etc.
- **Indexed Fields for Search**: `user_id`, `username`, `email`

### Message

- `message_id`: Unique identifier for a message.
- `content`: Text content of the message.
- `timestamp`: When the message was sent.
- `user_id`: ID of the user who sent the message.
- `channel_id`: ID of the channel where the message was sent.
- **Indexed Fields for Search**: `message_id`, `content`, `timestamp`, `user_id`, `channel_id`

### File

- `file_id`: Unique identifier for a file.
- `file_name`: Name of the file.
- `file_type`: Type of the file (e.g., PDF, JPG).
- `size`: File size in bytes.
- `uploaded_by`: ID of the user who uploaded the file.
- `channel_id`: ID of the channel where the file is shared.
- **Indexed Fields for Search**: `file_id`, `file_name`, `file_type`, `uploaded_by`, `channel_id`

### Channel

- `channel_id`: Unique identifier for a channel.
- `channel_name`: Name of the channel.
- `created_by`: ID of the user who created the channel.
- `participants[]`: Array of user IDs who are participants in the channel.
- **Indexed Fields for Search**: `channel_id`, `channel_name`, `created_by`, `participants[]`

### SearchQuery (For Unified Search)

- `query_string`: The search term entered by the user.
- `limit`: Maximum number of results to return.
- `offset`: Number of results to skip for pagination.
- `sort_order`: How to sort the results (e.g., ascending, descending).
- `service_filters[]`: List of services to include in the search (e.g., User, Message, File, Channel).
- `Results`: A composite object that includes an array of results, each with a `type` (User, Message, File, Channel) and the relevant indexed fields.

## Setup (note for mac users)

### Install Smithy CLI

Reference: https://aws.amazon.com/blogs/developer/introducing-the-smithy-cli/

- Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Install Smithy: `brew tap smithy-lang/tap`
- Install Smithy CLI: `brew install smithy-cli`

```bash
  → smithy --help
Usage: smithy [-h | --help] [--version] <command> [<args>]

Available commands:
    validate    Validates Smithy models.
    build       Builds Smithy models and creates plugin artifacts for each projection found in smithy-build.json.
    diff        Compares two Smithy models and reports differences.
    ast         Reads Smithy models in and writes out a single JSON AST model.
    select      Queries a model using a selector.
    format      Formats Smithy IDL models.
    clean       Removes Smithy build artifacts and caches.
    migrate     Migrate Smithy IDL models from 1.0 to 2.0 in place.
    init        Initialize a smithy project using a template
```

## Build Smithy Models

```bash
  → smithy build api_models/
```
