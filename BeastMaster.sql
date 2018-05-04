-- Here you can set npc entry, name, subname, gossip_menu_id, displayID
SET @NpcEntry := 180005;
SET @NpcName := 'The Beastmaster';
SET @NpcSubName := 'Ashen WoW';
SET @NpcDisplayID := 30883;
SET @GossipOptionID := 50030;
SET @GOSSIP_ICON_TRAINER := 0;

-- If @NpcEntry, @GossipOptionID already exists in your database, delete those entries
DELETE FROM world.gossip_menu_option WHERE menu_id = @GossipOptionID;
DELETE FROM world.conditions WHERE SourceGroup = @GossipOptionID;
DELETE FROM world.smart_scripts WHERE entryorguid = @NpcEntry;
DELETE FROM world.creature_template WHERE entry = @NpcEntry;

-- Creature Template
INSERT INTO world.creature_template (entry, modelid1, name, subname, minlevel, maxlevel, faction, npcflag, rank, AIName, gossip_menu_id) VALUES 
(@NpcEntry, @NpcDisplayID, @NpcName, @NpcSubName, 80, 80, 35, 1, 4, 'SmartAI', @GossipOptionID);


-- gossip_menu_option - gossip menus
SET @GID := IFNULL((SELECT id FROM world.gossip_menu_option WHERE menu_id = @GossipOptionID ORDER BY id DESC LIMIT 1), 0)+1;
INSERT INTO world.gossip_menu_option (menu_id, id, option_icon, option_text, option_id, npc_option_npcflag, action_menu_id, action_poi_id, box_coded, box_money, box_text) VALUES
(@GossipOptionID, @GID, @GOSSIP_ICON_TRAINER, 'Pet Ravager', 1, 1, @GossipOptionID, 0, 0, 0, NULL), 
(@GossipOptionID, @GID+1, @GOSSIP_ICON_TRAINER, 'Pet Scorpid', 1, 1, @GossipOptionID, 0, 0, 0, NULL), 
(@GossipOptionID, @GID+2, @GOSSIP_ICON_TRAINER, 'Pet Serpent', 1, 1, @GossipOptionID, 0, 0, 0, NULL), 
(@GossipOptionID, @GID+3, @GOSSIP_ICON_TRAINER, 'Pet Spider', 1, 1, @GossipOptionID, 0, 0, 0, NULL),
(@GossipOptionID, @GID+4, @GOSSIP_ICON_TRAINER, 'Pet Bear', 1, 1, @GossipOptionID, 0, 0, 0, NULL),
(@GossipOptionID, @GID+5, @GOSSIP_ICON_TRAINER, 'Pet Wolf', 1, 1, @GossipOptionID, 0, 0, 0, NULL),
(@GossipOptionID, @GID+6, @GOSSIP_ICON_TRAINER, 'Pet Cat', 1, 1, @GossipOptionID, 0, 0, 0, NULL),
(@GossipOptionID, @GID+7, @GOSSIP_ICON_TRAINER, 'Pet Bat', 1, 1, @GossipOptionID, 0, 0, 0, NULL),
(@GossipOptionID, @GID+8, @GOSSIP_ICON_TRAINER, 'Pet Raptor', 1, 1, @GossipOptionID, 0, 0, 0, NULL),
(@GossipOptionID, @GID+9, @GOSSIP_ICON_TRAINER, 'Pet Tallstrider', 1, 1, @GossipOptionID, 0, 0, 0, NULL),
(@GossipOptionID, @GID+10, @GOSSIP_ICON_TRAINER, 'Pet Turtle', 1, 1, @GossipOptionID, 0, 0, 0, NULL),
(@GossipOptionID, @GID+11, @GOSSIP_ICON_TRAINER, 'Pet Crab', 1, 1, @GossipOptionID, 0, 0, 0, NULL),
(@GossipOptionID, @GID+12, @GOSSIP_ICON_TRAINER, 'Maximize Pet\'s Loyalty and Happiness', 1, 1, @GossipOptionID, 0, 0, 0, NULL);


-- Smart Scripts - Cast spell when clicking on a gossip menu (e.g. 'Pet Ravager' cast spell 46725)
SET @SID := IFNULL((SELECT id FROM world.smart_scripts WHERE entryorguid = @NpcEntry ORDER BY id DESC LIMIT 1), 0)+1;
INSERT INTO world.smart_scripts (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@NpcEntry, 0, @SID, 0, 62, 0, 100, 0, @GossipOptionID, @GID, 0, 0, 85, 46725, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Ravager'),
(@NpcEntry, 0, @SID+1, 0, 62, 0, 100, 0, @GossipOptionID, @GID+1, 0, 0, 85, 46726, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Scorpid'),
(@NpcEntry, 0, @SID+2, 0, 62, 0, 100, 0, @GossipOptionID, @GID+2, 0, 0, 85, 46727, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Serpent'),
(@NpcEntry, 0, @SID+3, 0, 62, 0, 100, 0, @GossipOptionID, @GID+3, 0, 0, 85, 46728, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Spider'),
(@NpcEntry, 0, @SID+4, 0, 62, 0, 100, 0, @GossipOptionID, @GID+4, 0, 0, 85, 64330, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Bear'),
(@NpcEntry, 0, @SID+5, 0, 62, 0, 100, 0, @GossipOptionID, @GID+5, 0, 0, 85, 46730, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Wolf'),
(@NpcEntry, 0, @SID+6, 0, 62, 0, 100, 0, @GossipOptionID, @GID+6, 0, 0, 85, 46720, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Cat'),
(@NpcEntry, 0, @SID+7, 0, 62, 0, 100, 0, @GossipOptionID, @GID+7, 0, 0, 85, 46717, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Bat'),
(@NpcEntry, 0, @SID+8, 0, 62, 0, 100, 0, @GossipOptionID, @GID+8, 0, 0, 85, 46724, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Raptor'),
(@NpcEntry, 0, @SID+9, 0, 62, 0, 100, 0, @GossipOptionID, @GID+9, 0, 0, 85, 64337, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Tallstrider'),
(@NpcEntry, 0, @SID+10, 0, 62, 0, 100, 0, @GossipOptionID, @GID+10, 0, 0, 85, 64339, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Turtle'),
(@NpcEntry, 0, @SID+11, 0, 62, 0, 100, 0, @GossipOptionID, @GID+11, 0, 0, 85, 64331, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Pet Crab'),
(@NpcEntry, 0, @SID+12, 0, 62, 0, 100, 0, @GossipOptionID, @GID+12, 0, 0, 85, 46649, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Maximize Pet\'s Loyalty and Happiness');


-- Conditions - The condition is that only hunters (class 4) can access the gossip menu
INSERT INTO world.conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES 
(15, @GossipOptionID, @GID, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 0'),
(15, @GossipOptionID, @GID+1, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 1'),
(15, @GossipOptionID, @GID+2, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 2'), 
(15, @GossipOptionID, @GID+3, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 3'),
(15, @GossipOptionID, @GID+4, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 4'),
(15, @GossipOptionID, @GID+5, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 5'),
(15, @GossipOptionID, @GID+6, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 6'),
(15, @GossipOptionID, @GID+7, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 7'),
(15, @GossipOptionID, @GID+8, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 8'),
(15, @GossipOptionID, @GID+9, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 9'),
(15, @GossipOptionID, @GID+10, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 10'),
(15, @GossipOptionID, @GID+11, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 11'),
(15, @GossipOptionID, @GID+12, 0, 0, 15, 0, 4, 0, 0, 0, 0, 0, '', 'Beastmaster - Condition Class 4 (HUNTER only) gossip_menu_option.id 12'); 