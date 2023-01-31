trigger AccountUpdateTrigger on Account (after update) {
	ContactUpdater.updateContacts(Trigger.new);
}