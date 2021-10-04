module IDE

import Syntax;

import util::IDE;

public str PS_NAME = "PuzzleScript";
public str PS_EXT  = "ps";

public void ps_register()
{
  registerLanguage(PS_NAME, PS_EXT, Syntax::ps_parse);
}