module AST

data Game = game(list[Prelude] prelude, list[Section] sections);

data Prelude = prelude(PreludeKeyword key, list[String] val);
    
data Section
  = objects(list[Object] objects)
  | legend(list[Legend] legend)
  | sounds(list[Sound] sounds)
  | layers(list[Layer] layers)
  | rules(list[Rule] rules)
  | conditions(list[Cond] conditions)
  | levels(list[Level] levels);

data Object = object(ID key, string legendKey, list[ID] colors, Sprite sprite);

data Sprite = sprite(SpriteLine l1, SpriteLine l2, SpriteLine l3, SpriteLine l4, SpriteLine l5);

data Legend = entry(LegendKey, ID, list[tuple[LegendKeyword, ID]] items);

data Sound = sound(list[ID] sounds);

data Layer = layer(list[ID] objects);
    
//data Rule =  rule(ID, list[RulePart], list[
    
//syntax Rule = rule: ID? RulePart+ '-\>' (Command|RulePart)* Message?;

data RulePart = part(list[RuleContent] content);

data RuleContent = content();
    
//syntax RuleContent = content: (ID | Directional)*;
    
data Command
  = command(CommandKeyword key)
  | play_sound(SoundIndex index);
    
data Level
  = level(list[LevelLine] lines)
  | level_progress(Message message);

data Message
  = message(list[String] lines);

data Cond = condition(list[ID] conditions);