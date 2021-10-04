module Syntax
    
start syntax Game = game: (Prelude LBS)* {Section LBS}* LBS?;
  
syntax Prelude = prelude: PreludeKwd String+;
    
syntax Section
  = objects: (Delim LBS)? 'OBJECTS' LBS Delim? (LBS Object)*
  | legend: (Delim LBS)? 'LEGEND' LBS Delim? (LBS Legend)*
  | sounds: (Delim LBS)? 'SOUNDS' LBS Delim? (LBS Sound)*
  | layers: (Delim LBS)? 'COLLISIONLAYERS' LBS Delim? (LBS Layer)*
  | rules: (Delim LBS)? 'RULES' LBS Delim? (LBS Rule)*
  | conditions: (Delim LBS)? 'WINCONDITIONS' LBS Delim? (LBS Cond)*
  | levels: (Delim LBS)? 'LEVELS' LBS Delim? (LBS Level)*;

syntax Object = object: ID LegendKey? LB ID+ (LB Sprite)?;
    
syntax Sprite = sprite:
  SpriteLine LB
  SpriteLine LB
  SpriteLine LB
  SpriteLine LB
  SpriteLine LB;
     
syntax Legend = entry: LegendKey '=' ID (LegendKwd ID)*;
syntax Sound = sound: ID+;
syntax Layer = layer: {ID ','}+;
    
syntax Rule = rule: ID? RulePart+ '-\>' (Command|RulePart)* Message?;
syntax RulePart = part: '[' {RuleContent '|'}+ ']';
syntax RuleContent = content: (ID | Directional)*;
syntax Message = message: 'message' String+;    
syntax Command
  = command: CommandKwd
  | play_sound: 'sfx' SoundIndex; 

syntax Cond = condition: ID+;    
syntax Level
  = level: (LevelLine LB)+
  | level_progress: Message;
    

keyword SectionKwd
  = 'RULES' | 'OBJECTS' | 'LEGEND' | 'COLLISIONLAYERS' | 'SOUNDS' | 'WINCONDITIONS' | 'LEVELS';
  
keyword PreludeKwd 
  = 'title' | 'author' | 'homepage' | 'color_palette' | 'again_interval' | 'background_color' 
  | 'debug' | 'flickscreen' | 'key_repeat_interval' | 'noaction' | 'norepeat_action' | 'noundo'
  | 'norestart' | 'realtime_interval' | 'require_player_movement' | 'run_rules_on_level_start' 
  | 'scanline' | 'text_color' | 'throttle_movement' | 'verbose_logging' | 'youtube ' | 'zoomscreen';

keyword LegendKwd = 'or' | 'and';

keyword CommandKwd = 'again' | 'cancel' | 'checkpoint' | 'restart' | 'win';

keyword Kwds = SectionKwd | PreludeKwd | LegendKwd | CommandKwd;
    
layout LAYOUTLIST = LAYOUT* !>> [\t\r\ ] !>> '(';

lexical LAYOUT = [\t\r\ ] | ^Comment LBS > Comment;
lexical Comment = @category="Comment" '(' (![()]*|Comment)')';
lexical LB = [\n];
lexical LBS = LB+ !>> [\n];
lexical Delim = [=]+;
lexical ID = [a-z0-9.A-Z]+ !>> [a-z0-9.A-Z] \ Kwds;
lexical KeyChar = [a-zA-Z.!@#$%&*];
lexical LegendKey = KeyChar+ !>> KeyChar \ Kwds;
lexical SpriteLine = @category="Comment" '\n' << [0-9.]+ !>> [0-9.] \ Kwds;
lexical Pixel = [a-zA-Z.!@#$%&*0-9];
lexical LevelLine = @category="Comment" '\n' << Pixel+ !>> Pixel \ Kwds;
lexical String = ![\n]+ >> [\n];
lexical SoundIndex = [0-9]|'10' !>> [0-9]|'10';
lexical Directional = [\>\<^v] !>> [a-z0-9.A-Z];

public start[Game] ps_parse(str input, loc file) = 
  parse(#start[Game], input, file);
  
public start[Game] ps_parse(loc file) = 
  parse(#start[Game], file);