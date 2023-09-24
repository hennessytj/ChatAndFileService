$version: "2"
namespace com.computationista.chatservice
use com.computationista.userservice#UserId

@documentation("Chat service for sending and receiving messages")
@paginated(inputToken: "nextToken", outputToken: "nextToken",
           pageSize: "pageSize")
service ChatService {
    version: "2021-08-29"
    resources: [Chat]
}

// each chat will technically be part of some channel to allow for additional users to join
@documentation("A message in a chat channel")
resource Chat {
    identifiers:  { messageId: MessageId }
    create: CreateMessage
    read: GetMessage
    update: UpdateMessage // e.g., make edit to existing message
    delete: DeleteMessage
    list: ListMessages
}

@documentation("Create a new message in a chat channel")
operation CreateMessage {
    input: CreateMessageInput
    output: CreateMessageOutput
}

structure CreateMessageInput {
    @required
    message: MessageData
}

structure CreateMessageOutput {
    messageId: MessageId
}

@documentation("Get specific instance of message by id")
@readonly
operation GetMessage {
    input: GetMessageInput
    output: GetMessageOutput
}

structure GetMessageInput {
    @required
    messageId: MessageId
}

structure GetMessageOutput {
    message: MessageData
}

@documentation("Update or edit an existing message")
operation UpdateMessage {
    input: UpdateMessageInput
    output: UpdateMessageOutput
}

structure UpdateMessageInput {
    @required
    messageId: MessageId
    messageData: MessageData
}

// Might want to make a decision that updated messages return new message ids because they are technically new messages
structure UpdateMessageOutput {
    messageId: MessageId
}

// The database might need to have a state field to indicate if a message has been edited, deleted, etc.
// It also might be helpful for the database to have a field to indicate if a message has been read by a user
// It might be helpful for the database to also have a field to indicate if a message has been delivered to a user
// It might be helpful for the database to link to original message if it has been edited
@documentation("Delete a message from channel. This will not delete the message from the database but will instead mark it as deleted.")
@idempotent
operation DeleteMessage {
    input: DeleteMessageInput
    output: DeleteMessageOutput
}

structure DeleteMessageInput {
    @required
    messageId: MessageId
}

// Not sure that I really want to return the message id here but it might be useful to return the message id of the deleted message
structure DeleteMessageOutput {
    messageId: MessageId
}

@documentation("List messages in a chat channel")
@readonly
@paginated
operation ListMessages {
    input: ListMessagesInput
    output: ListMessagesOutput
}

// TODO: might want to walk back adding more than what is absolutely necessary because removing later is harder than adding later
// TODO: not sure I want to make any particular field required because it might be useful to allow for more flexible queries
//     might need to explicitly defined expected return values for cases where input are empty
structure ListMessagesInput {
    nextToken: String
    pageSize: Integer
    userId: UserId
    channelId: String // ChannelId
    timestamp: String // ISO 8601 or Unix timestamp TBD
    limit: Integer
}

structure ListMessagesOutput {
    nextToken: String

    @required
    items: Messages
}   

list Messages {
    member: MessageData
}

@documentation("""
The unique identifier for a message used to ensure data integrity, facilitate message indexing and retrieval, and prevent duplicate messages.
A message id combines UserId, ChannelId, Timestamp, and a Counter. Counter will be incremented for each message sent by a user in a channel.
""")
// timestamp will either be ISO 8601 or Unix timestamp TBD
// Need to figure out if using string interpolation in the pattern is allowed but the form of the MessageId is as follows
// UserId-ChannelId-Timestamp-Counter
string MessageId

structure MessageData {
    messageId: MessageId
    content: String // TODO: this might need to be a more complex type to allow aggregated media (e.g., message with a file attachment)
    timestamp: String // ISO 8601 or Unix timestamp TBD
    userId: UserId
    channelId: String // ChannelId
}
