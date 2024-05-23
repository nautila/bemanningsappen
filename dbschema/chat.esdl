module chat {
	type Conversation {
		multi participants: default::User;

		multi messages := .<conversation[is Message];
		single lastMessage := (select .messages order by .index desc limit 1);
	}

	type Message {
		required index: int64;
		required body: str;

		required author: default::User { on target delete delete source };
		required conversation: Conversation { on target delete delete source };

		index on (.index);
		constraint exclusive on ((.conversation, .index));
	}
}
