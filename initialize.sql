SET foreign_key_checks = 0;
drop database if exists 138_chess_game;
create database 138_chess_game;
use 138_chess_game;

create table gameboard_type(
	timer			float(4,2),		#minutes.seconds
	grid_number		char(2),
	board_color		varchar(10),
	piece_color		char(5),
	name			varchar(15) not null,
	lobby_id		integer not null,
	primary key (lobby_id,name),
	foreign key (lobby_id) references lobby(lobby_id)
);

create table lobby_stats(
	pieces_taken		integer,
    	avg_gametime		float(4,2),		#hours.minutes
	avg_movetime		float(4,2),		#minutes.seconds
    	games_in_lobby		integer,
    	avg_moves_per_game	float(4,2),
    	users_joined		integer,
    	lobby_id		integer not null,
#	primary key (lobby_id),					#FIX
    	foreign key (lobby_id) references lobby(lobby_id)	#FIX
);

create table lobby(
	player_waitlist		integer,
    	min_skill		integer,
    	lobby_id		integer not null,
    	primary key (lobby_id)
);

create table viewer_slot(
	viewer			varchar(25) not null,
    	lobby_id		integer not null,
    	primary key		(lobby_id),
    	foreign key (lobby_id) references lobby(lobby_id),
    	foreign key (viewer) references user(id)
);

create table game_history(
	avg_movetime		float(4,2),				#minute.second
	match_id		integer not null,
	match_length		float(4,2),				#hour.minute
	replay_id		integer,
	elo_change		integer,
	winner			varchar(15),
	date_time		char(16),				#MM/DD/YYYY:HH.MM
	lobby_id		integer not null,
	player_id		varchar(25) not null,
	primary key (match_id),
	foreign key (lobby_id) references lobby(lobby_id),
	foreign key (player_id) references player(id)
);

create table user(
	id			varchar(25) not null,
	email			varchar(25),
	password		varchar(32),			#used 32 assuming MD5 is used for hashing on insert
	active_lobby		integer,
	unique (email),
	primary key (id),
	foreign key (active_lobby) references lobby(lobby_id)
);

create table player(
	player_since 		char(10) not null,		#MM/DD/YYYY
	streak 			char(2),
	player_id		varchar(25) not null,
	skill			integer,
	past_punishments	varchar(15),
	primary key (player_id),
	foreign key (player_id) references user(id)
);

create table developer(
	fname 			varchar(15) not null,
	lname 			varchar(15) not null,
	dev_id			varchar(25) not null,
	dev_rights		varchar(15) not null,
	primary key (dev_id),
	foreign key (dev_id) references user(id)
);

create table moderator(
	fname 			varchar(15) not null,
	lname 			varchar(15) not null,
	mod_id			varchar(25) not null,
	admin_powers		varchar(15) not null,
	primary key (mod_id),
	foreign key (mod_id) references user(id)
);

SET foreign_key_checks = 1;
