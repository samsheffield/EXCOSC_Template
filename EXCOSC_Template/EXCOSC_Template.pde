/*
EXCOSC Game Jam Template
Author: Sam Sheffield (hello@samsheffield.com)

A simple template for the EXCOSC Game Jam to get you started with OSC. 
Simplicity and hackability was favored over brevity and elegance to make it easier for others to modify.

Requires oscP5 library for Processing to manage the OSC (http://www.sojamo.de/libraries/oscP5/)

NOTE: Commandline arguments still needs testing on Linux and Windows (It works on OS X like this: open gamename.app --args -lp 8888 -sp 9999 -sa 127.0.0.1)
Good luck!
*/

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress send_to_address;

/*
Array which holds incoming player OSC in the following order:
[0] /player/position/x
[1] /player/position/y
[2] /player/colour/r
[3] /player/colour/g
[4] /player/colour/b
[5] /player/trigger
*/
float[] player_osc = new float[6];

/*
2-dimensional array which holds incoming entity OSC in the following order (NOTE: First [0] is a number between 0 and 7 which represents each entity:
[0][0] /entity0/position/x
[0][1] /entity0/position/y
[0][2] /entity0/colour/r
[0][3] /entity0/colour/g
[0][4] /entity0/colour/b
*/
float[][] entity_osc = new float[8][5];

// Network details for OSC communication
int listen_port, send_port;
String send_address;

void setup(){
	// Default ports for OSC
	listen_port  = 4444;
	send_port    = 5555;
	send_address = "127.0.0.1";

	for(int i=0; i<args.length; ++i){
		if(args[i].equals("-lp")){
			++i;
			listen_port = int(args[i]);
		}
		else if(args[i].equals("-sa")){
			++i;
			send_address = args[i];
		}
		else if(args[i].equals("-sp")){
			++i;
			send_port = int(args[i]);
		}
	}

	oscP5 = new OscP5(this, listen_port);
	send_to_address = new NetAddress(send_address, send_port);
}

void draw(){

	sendOsc("/player/position/x", map(mouseX, 0, width, 0, 1));
	/*
	//Usage examples:

	// Sending OSC messages is easy. Here's how to send the x, y position of the mouse mapped to a 0-1 range. 
	sendOsc("/player/position/x", map(mouseX, 0, width, 0, 1));
	sendOsc("/player/position/y", map(mouseY, 0, height, 0, 1));

	// Incoming OSC messages are also easy to deal with. 
	// When an OSC message is received it is parsed and stored in the appropriate array (either player_osc[] or entity_osc[][])
	rect(entity_osc[0][0], entity_osc[0][1], 20, 20);	// Entity 0's x, y from OSC 
	rect(player_osc[0], player_osc[1], 20, 20);			// Player's x, y from OSC 
	*/
}

// Simple OSC sender. _address_pattern is something like "/player/position/x". _osc_message is the floating point number between 0 and 1
void sendOsc(String _address_pattern, float _message){
    OscMessage _osc_message = new OscMessage(_address_pattern);
    _osc_message.add(_message);
    oscP5.send(_osc_message, send_to_address);
}

// OSC Event handler
void oscEvent(OscMessage _osc_message){
	// Player OSC
	if (_osc_message.checkAddrPattern("/player/position/x")){
		player_osc[0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/position/y")){
		player_osc[1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/colour/r")){
		player_osc[2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/colour/g")){
		player_osc[3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/colour/b")){
		player_osc[4] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/trigger")){
		player_osc[5] = _osc_message.get(0).floatValue();
	}

	// Entity 0 OSC
	else if (_osc_message.checkAddrPattern("/entity0/position/x")){
		entity_osc[0][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity0/position/y")){
		entity_osc[0][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity0/colour/r")){
		entity_osc[0][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity0/colour/g")){
		entity_osc[0][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity0/colour/b")){
		entity_osc[0][4] = _osc_message.get(0).floatValue();
	}

	// Entity 1 OSC
	else if (_osc_message.checkAddrPattern("/entity1/position/x")){
		entity_osc[1][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity1/position/y")){
		entity_osc[1][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity1/colour/r")){
		entity_osc[1][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity1/colour/g")){
		entity_osc[1][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity1/colour/b")){
		entity_osc[1][4] = _osc_message.get(0).floatValue();
	}

	// Entity 2 OSC
	else if (_osc_message.checkAddrPattern("/entity2/position/x")){
		entity_osc[2][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity2/position/y")){
		entity_osc[2][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity2/colour/r")){
		entity_osc[2][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity2/colour/g")){
		entity_osc[2][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity2/colour/b")){
		entity_osc[2][4] = _osc_message.get(0).floatValue();
	}

	// Entity 3 OSC
	else if (_osc_message.checkAddrPattern("/entity3/position/x")){
		entity_osc[3][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity3/position/y")){
		entity_osc[3][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity3/colour/r")){
		entity_osc[3][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity3/colour/g")){
		entity_osc[3][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity3/colour/b")){
		entity_osc[3][4] = _osc_message.get(0).floatValue();
	}

	// Entity 4 OSC
	else if (_osc_message.checkAddrPattern("/entity4/position/x")){
		entity_osc[4][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity4/position/y")){
		entity_osc[4][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity4/colour/r")){
		entity_osc[4][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity4/colour/g")){
		entity_osc[4][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity4/colour/b")){
		entity_osc[4][4] = _osc_message.get(0).floatValue();
	}

	// Entity 5 OSC
	else if (_osc_message.checkAddrPattern("/entity5/position/x")){
		entity_osc[5][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity5/position/y")){
		entity_osc[5][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity5/colour/r")){
		entity_osc[5][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity5/colour/g")){
		entity_osc[5][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity5/colour/b")){
		entity_osc[5][4] = _osc_message.get(0).floatValue();
	}

	// Entity 6 OSC
	else if (_osc_message.checkAddrPattern("/entity6/position/x")){
		entity_osc[6][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity6/position/y")){
		entity_osc[6][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity6/colour/r")){
		entity_osc[6][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity6/colour/g")){
		entity_osc[6][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity6/colour/b")){
		entity_osc[6][4] = _osc_message.get(0).floatValue();
	}

	// Entity 7 OSC
	else if (_osc_message.checkAddrPattern("/entity7/position/x")){
		entity_osc[7][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity7/position/y")){
		entity_osc[7][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity7/colour/r")){
		entity_osc[7][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity7/colour/g")){
		entity_osc[7][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity7/colour/b")){
		entity_osc[7][4] = _osc_message.get(0).floatValue();
	}
}