import "package:logging/logging.dart";
export "Command/Command.dart";
export "Command/ICommand.dart";

/// The main command handler
class Commands {
	Logger _log = new Logger("COMMAND");
	List<Command> _commands;
	List<String> _admins;


	// Make it according to your own project.
	Commands(dynamic client, [this._admins]){
		_commands = [];
	}

	void dispatch(String message, String author){
		if(message.startsWith("help"))
		{
			// Send the message
			sendMessage( _createHelp() );
		}

		// Search for matching command in registry. 
		// If registry contains multiple commands 
		// with identical name - run the first one.
		var matchedCommand = _commands
					.where((i) => message.startsWith(i.name))
					.first;

		if( matchedCommand.isAdmin && _admins != null &&
			_admins.any( (i) => (i == author) ) ) {}
		else return;

		try {
			await matchedCommand.run(message);
			_log.info("Dispatched command successfully");
		}
		catch(e){
			_log.warn("Error in Dispatching command.");
		}
		
	}

	/// Creates help String based on registred commands metadata.
	String _createHelp() {
		var buffer = new StringBuffer();

		buffer.writeln("\n**Available commands:**");

		_commands.forEach((item) {
			buffer.writeln("* ${item.name} - ${item.help}");
			buffer.writeln("\t Usage: ${item.usage}");
		});

		return buffer.toString();
	}

	/// Register new [Command] object
	void add(Command cmd){
		_commands.add(cmd);
		_log.info("Added new message: ${cmd.name}");
	}

	/// Register an array of [Command] objects
	void addMany(List<ICommand> commands){
		commands.forEach( (c) => add(c) );
	}

}
