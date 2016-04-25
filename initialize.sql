SET foreign_key_checks = 0;
drop database if exists 138_chess_game;
create database 138_chess_game;
use 138_chess_game;

#############REGULAR ENTITIES#############

create table gameboard_type (
	timer			float(4,2),		#minutes.seconds
	grid_number		integer,		#what does this refer to?
	board_color		varchar(10),
	piece_color		char(5),
	name			varchar(15) not null,	
	primary key 	(name)
    /*NOTES	
    need to add in foreign key to lobby, user which may require more attributes
	*/
);

create table lobby_stats(
	pieces_taken		integer,
    avg_gametime		float(4,2),		#hours.minutes
	avg_movetime		float(4,2),		#minutes.seconds
    games_in_lobby		integer,
    avg_moves_per_game	float(4,2),
    users_joined		integer,
    lobby_id			integer not null,
	primary key			(lobby_id),
    foreign key (lobby_id) references lobby(lobby_id)
    /*NOTES	
    added in lobby_id attribute for foreign key
	*/
);

create table game_lobby(
	player_waitlist		integer,	#not sure if integer here
    min_skill			integer,
    lobby_id			integer not null,
    primary key 		(lobby_id)
    /*NOTES	
    will need additional table for multivalue viewer_slot as normalization
    need foreign key to gameboard type; may need additional attribute
	*/
);

create table game_history(
	avg_movetime		float(4,2),				#minute.second
    match_id			integer not null,
    match_length		float(4,2),				#hour.minute
    replay_id			integer,
    elo_change			integer,
    winner				varchar(15),
    date_time			char(16),				#MM/DD/YYYY:HH.MM, when completed I assume?
    lobby_id			integer not null,
    player_id			varchar(25) not null,
    primary key 		(match_id),
    foreign key	(lobby_id) references lobby(lobby_id),
    foreign key	(player_id) references player(id)
    /*NOTES
    added lobby_id for foreign key
	*/
);

create table user(
	id			varchar(25) not null,
    email		varchar(25),
    password	varchar(32),			#used 32 assuming MD5 is used for hashing on insert
    unique		(email),
    primary key (id)
    /*NOTES	
    need foreign key to game lobby which may require additional attribute or normalization
	*/
);

#############GENERAL NOTES#############
/*
need to review how to handle the disjoint we have at user so none of the users have been added yet
*/