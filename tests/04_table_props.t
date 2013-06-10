<?php
	include(dirname(__FILE__).'/testmore.php');
	include(dirname(__FILE__).'/../lex.php');

	function table_props_test($tokens, $props_expect){

		$obj = new SchemaCompSchema();
		$props = $obj->parse_table_props($tokens);

		is_deeply($props, $props_expect);
	}


	plan(8);


	# the equals is optional

	table_props_test(array('ENGINE', '=', 'INNODB'), array('ENGINE' => 'INNODB'));
	table_props_test(array('ENGINE',      'INNODB'), array('ENGINE' => 'INNODB'));


	# lots of ways to say this

	table_props_test(array('DEFAULT', 'CHARACTER', 'SET',	'foo'), array('CHARACTER SET' => 'foo'));
	table_props_test(array('CHARACTER', 'SET',		'foo'), array('CHARACTER SET' => 'foo'));
	table_props_test(array('DEFAULT', 'CHARSET',		'foo'), array('CHARACTER SET' => 'foo'));
	table_props_test(array('CHARSET',			'foo'), array('CHARACTER SET' => 'foo'));

	table_props_test(array('DEFAULT', 'COLLATE',	'bar'), array('COLLATE' => 'bar'));
	table_props_test(array('COLLATE',		'bar'), array('COLLATE' => 'bar'));
